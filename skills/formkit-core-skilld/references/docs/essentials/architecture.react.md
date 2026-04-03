# Architecture

A zero-dependency package that is responsible for nearly all of FormKit's low-level critical functions.

## Introduction

At the heart of the FormKit framework is `@formkit/core`. This zero-dependency package is responsible for nearly all of FormKit's low-level critical functions, such as:

- Configuration
- Value input/output
- Event bubbling
- Plugin management
- Tree state tracking
- Message management
- Lifecycle hooks

## Architecture

The functionality of FormKit core is not exposed to your application via a centralized instance but rather a distributed set of "nodes" (`FormKitNode`) where each node represents a single input.

This mirrors HTML — in fact DOM structure is actually a general tree and FormKit core nodes reflect this structure. For example, a simple login form could be drawn as the following tree graph:


  Hover over each node to see its initial options.
In this diagram, a `form` node is a parent to three child nodes — `email`, `password` and `submit`. Each input component in the graph "owns" a FormKit core node, and each node contains its own options, configuration, props, events, plugins, lifecycle hooks, etc. This architecture ensures that FormKit’s primary features are decoupled from the rendering framework layer — whether you are using Vue, React, or another renderer — a key to reducing side effects and maintaining blazing fast performance.

Additionally, this decentralized architecture allows for tremendous flexibility. For example — one form could use different plugins than other forms in the same app, a group input could modify the configuration of its sub-inputs, and validation rules can even be written to use props from another input.

## Node

Every `<FormKit>` component owns a single core node, and each node must be one of three types:

- [Input](#input)
- [List](#list)
- [Group](#group)

> **Tip:** Core nodes are always one of three types (input, list, or group). These are not the same as input types — of which there can be unlimited variation. Strictly speaking all inputs have 2 types: their node type (like `input`), and their input type (like `checkbox`).

### Input

Most of FormKit’s native inputs have a node type of `input` — they operate on a single value. The value itself can be of any type, such as objects, arrays, strings, and numbers — any value is acceptable. However, nodes of type `input` are always leafs — meaning they cannot have children.

```
// @noErrors
import { createNode } from '@formkit/core'

const input = createNode({
  type: 'input', // defaults to 'input' if not specified
  value: 'hello node world',
})

console.log(input.value)
// 'hello node world'

```

### List

A list is a node that produces an array value. Children of a list node produce a value in the list’s array value. The names of immediate children are ignored — instead each is assigned an index in the list’s array.

```
// @noErrors
import { createNode } from '@formkit/core'

const list = createNode({
  type: 'list',
  children: [
    createNode({ value: 'paprika@example.com' }),
    createNode({ value: 'bill@example.com' }),
    createNode({ value: 'jenny@example.com' }),
  ],
})

console.log(list.value)
// ['paprika@example.com', 'bill@example.com', 'jenny@example.com']

```

### Group

A group is a node that produces an object value. Children of a group node use their `name` to produce a property of the same name in the group’s value object — `<FormKit type="form">` is an instance of a group.

```
// @noErrors
import { createNode } from '@formkit/core'

const group = createNode({
  type: 'group',
  children: [
    createNode({ name: 'meat', value: 'turkey' }),
    createNode({ name: 'greens', value: 'salad' }),
    createNode({ name: 'sweets', value: 'pie' }),
  ],
})

console.log(group.value)
// { meat: 'turkey', greens: 'salad', sweets: 'pie' }

```

### Options

In addition to specifying the `type` of node when calling `createNode()`, you can pass any of the following options:

| Options | Default | Description |
| --- | --- | --- |
| children | [] | Child FormKitNode instances. |
| config | {} | Configuration options. These become the defaults of the props object. |
| name | {type}_{n} | The name of the node/input. |
| parent | null | The parent FormKitNode instance. |
| plugins | [] | An array of plugin functions. |
| props | {} | An object of key/value pairs that represent the current node instance details. |
| type | input | The type of FormKitNode to create (list, group, or input). |
| value | undefined | The initial value of the input. |

### Config & Props

FormKit uses an inheritance-based configuration system. Any values declared in the `config` option are automatically passed to children (and all descendants) of that node, but not passed to siblings or parents. Each node can override its inherited values by providing its own config, and these values will in turn be inherited by any deeper children and descendants. For example:

```
// @noErrors
import { createNode } from '@formkit/core'

const parent = createNode({
  type: 'group',
  config: {
    color: 'yellow',
  },
  children: [
    createNode({
      type: 'list',
      config: { color: 'pink' },
      children: [createNode(), createNode()],
    }),
    createNode(),
  ],
})

```

The above code will result in each node having the following configuration:


  Notice how the list subtree is pink.
> **Tip:** It is best practice to read configuration values from `node.props` rather than `node.config`. The next section details this feature.

### Props

The `node.props` and `node.config` objects are closely related. `node.config` is best thought of as the initial values for `node.props`. `props` is an arbitrarily shaped object that contains details about the current *instance* of the node.

The best practice is to always read configuration and prop data from `node.props` even if the original value is defined using `node.config`. Explicitly defined props take precedence over configuration options.

```
// @noErrors
import { createNode } from '@formkit/core'

const child = createNode({
  props: {
    flavor: 'cherry',
  },
})
const parent = createNode({
  type: 'group',
  config: {
    size: 'large',
    flavor: 'grape',
  },
  children: [child],
})
console.log(child.props.size)
// outputs: 'large'
console.log(child.props.flavor)
// outputs: 'cherry'

```

> **Tip:** When using the `<FormKit>` component, any props defined for the input `type` are automatically set as `node.props` properties. For example: `<FormKit label="Email" />` would result in `node.props.label` being `Email`.

### Syncing multiple nodes with the same name

By default, when a parent node (like a `group` or `form`) has multiple children with the same `name`, only one of those nodes contributes to the parent's value. However, in some cases you may want all same-named nodes to stay synchronized — for example, when you have multiple radio inputs with the same name spread across different locations in your template.

> **Warning:** We recommend avoiding multiple inputs with the same name at the same level of depth in your form tree. If this is unavoidable due to your template structure, the `mergeStrategy` config option can help keep their values synchronized.

The `mergeStrategy` config option enables this synchronization. When set on a parent's config, it specifies which child names should have their values synced:

```
// @noErrors
import { createNode } from '@formkit/core'

const form = createNode({
  type: 'group',
  config: {
    mergeStrategy: { my_field: 'synced' }
  }
})

```

When using the `<FormKit>` component:

```
<FormKit
  type="form"
  :config="{ mergeStrategy: { my_radio: 'synced' } }"
>
  <div>
    <FormKit type="radio" name="my_radio" :options="['Option 1']" />
  </div>
  <div>
    <FormKit type="radio" name="my_radio" :options="['Option 2']" />
  </div>
</FormKit>

```

With `mergeStrategy` set to `'synced'`, all inputs with `name="my_radio"` will share and synchronize their values, behaving as a unified input even when rendered in different DOM locations.

### Setting values

You can set the initial value of a node by providing the `value` option on `createNode()` — but FormKit is all about interactivity, so how do we update the value of an already defined node? By using `node.input(value)`.

```
// @noErrors
import { createNode } from '@formkit/core'

const username = createNode()
username.input('jordan-goat98')
console.log(username.value)
// undefined  👀 wait — what!?

```

In the above example `username.value` is still undefined immediately after it’s set because `node.input()` is asynchronous. If you need to read the resulting value after calling `node.input()` you can await the returned promise.

```
// @noErrors
import { createNode } from '@formkit/core'

const username = createNode()
username.input('jordan-goat98').then(() => {
  console.log(username.value)
  // 'jordan-goat98'
})

```

Because `node.input()` is asynchronous, the rest of our form does not need to recompute its dependencies on every keystroke. It also provides an opportunity to perform modifications to the unsettled value before it is "committed" to the rest of the form. However — for internal node use only — a `_value` property containing the unsettled value of the input is also available.

> **Danger:** You cannot *directly* assign the value of an input `node.value = 'foo'`. Instead, you should always use `node.input(value)`

### Value settlement

Now that we understand `node.input()` is asynchronous, let's explore how FormKit solves the "settled tree" problem. Imagine a user quickly types in their email address and hits "enter" very quickly — thus submitting the form. Since `node.input()` is asynchronous, incomplete data would likely be submitted. We need a mechanism to know when the whole form has "settled".

To solve this, FormKit’s nodes automatically track tree, subtree, and node "disturbance". This means the form (usually the root node) always knows the settlement state of all the inputs it contains.

The following graph illustrates this "disturbance counting". Click on any input node (blue) to simulate calling `node.input()` and notice how the whole form is always aware of how many nodes are "disturbed" at any given time. When the root node has a disturbed count of `0` the form is settled and safe to submit.


  Click on the inputs (blue) to simulate calling a user input.
```
// @noErrors
import { createNode } from '@formkit/core'

const form = createNode({
  type: 'group',
  children: [
    createNode(),
    createNode(),
    createNode()
  ],
})
// ...
// user interaction:
async function someEvent () {
  await form.settled
  // we now know the form is fully "settled"
  // and that form.value is accurate.
}

```

> **Tip:** The `<FormKit type="form">` input already incorporates this await behavior. It will not call your <code>onSubmit</code> handler until your form is completely settled. However when building advanced inputs it can be useful to understand these underlying principles.

## Getting a component’s node

Sometimes it can be helpful to get the underlying instance of a node from the framework `<FormKit>` component. There are four primary methods of fetching an input’s node.

- Using `getNode()`
- Using `useFormKitNodeById`
- Using the <code>onNode</code> prop
- Using a React <code>ref</code>

### getNode()

When using FormKit you can access a node by assigning it an `id` and then accessing it by that property via the `getNode()` function.

> **Warning:** You must assign the input an `id` to use this method.

### Example: Get core node

#### node-get.react.jsx

```jsx
import { getNode } from '@formkit/core'
import { useEffect } from 'react'
import { FormKit } from '@formkit/react'

function NodeGetExample() {
  useEffect(() => {
    const node = getNode('manufacturer')
    node?.input('Samsung', false)
  }, [])

  return (
    <FormKit
      type="select"
      id="manufacturer"
      label="Manufacturer"
      options={['Sony', 'Apple', 'Samsung', 'Lenovo']}
      help="Select your favorite tech manufacturer."
    />
  )
}
```
