# Custom Inputs

Create your own inputs that automatically inherit FormKit’s value-added features such as validation, error messages, data modeling, grouping, labels, help text and more.

# Custom inputs

FormKit includes many inputs out of the box, but you can also define your own inputs that automatically inherit FormKit’s value-added features like validation, error messages, data modeling, grouping, labels, help text and others.

> **Info:** If your use case requires modifications of an existing input, such as moving sections, changing or restructuring HTML elements, etc., consider using FormKit's [input export feature](/guides/export-and-restructure-inputs).

Inputs are comprised of two essential parts:

1. [An input definition](#input-definition).
2. The input’s code: [a schema](#schema-inputs) or a [component input](#component-inputs).

> **Warning:** If you are just getting started with custom inputs, consider reading the “[Create a custom input](/guides/create-a-custom-input)” guide. The content on this page is intended to explain the intricacies of custom inputs for advanced use cases like authoring a plugin or library and is not required for many common use cases.

## Registering inputs

New inputs require an [input definition](#input-definition). Input definitions can be registered with FormKit three ways:

- Locally on a `FormKit` component [with the type prop](#using-the-type-prop).
- [Globally using defaultConfig](#global-custom-inputs).
- [Selectively using plugin libraries](#plugin-libraries).

### Input definition

Input definitions are objects that contain the necessary information to initialize an input — like which [props to accept](#adding-props), what [schema or component to render](#schema-vs-component), and if any additional [feature functions](#adding-features) should be included. The shape of the definition object is:

```
{
  // Node type: input, group, or list.
  type: 'input',
  // Schema to render (schema object or function that returns an object)
  schema: [],
  // A framework component to render (use schema _OR_ component, but not both)
  component: YourComponent,
  // (optional) Input specific props the <FormKit> component should accept.
  // should be an array of camelCase strings
  props: ['fooBar'],
  // (optional) Array of functions that receive the node.
  features: []
}

```

### Using the type prop

Let’s make the simplest possible input — one that only outputs "Hello world".

### Example: Custom input

#### custom-input.react.jsx

```jsx
import { FormKit } from '@formkit/react'

const helloWorld = {
  type: 'input',
  schema: ['Hello world'],
}

function CustomInputExample() {
  return <FormKit type={helloWorld} />
}
```

Even though this simplistic example doesn’t contain any input/output mechanism, it still qualifies as a full input. It can have a value, run validation rules (they wont be displayed, but they can block form submissions), and execute plugins. Fundamentally, all inputs are [core nodes](/essentials/architecture#node) and the input’s definition provides the mechanisms to interact with that node.

### Global custom inputs

To use your custom input anywhere in your application via a "type" string (ex: `<FormKit type="foobar" />`) you can add an `inputs` property to the `defaultConfig` options. The property names of the `inputs` object become the "type" strings available to the `<FormKit>` component in your application.

```
import { createApp } from 'vue'
import App from 'App.vue'
import { plugin, defaultConfig } from '@formkit/vue'

const helloWorld = {
  type: 'input',
  schema: ['Hello world'],
}

createApp(App)
  .use(
    plugin,
    defaultConfig({
      inputs: {
        // The property will be the “type” in <FormKit type="hello">
        hello: helloWorld,
      },
    })
  )
  .mount('#app')

```

```
import { FormKitProvider, defaultConfig } from '@formkit/react'
import App from './App'

const helloWorld = {
  type: 'input',
  schema: ['Hello world'],
}

const config = defaultConfig({
  inputs: {
    // The property will be the “type” in <FormKit type="hello" />
    hello: helloWorld,
  },
})

export default function Root() {
  return (
    <FormKitProvider config={config}>
      <App />
    </FormKitProvider>
  )
}

```

Now that we’ve defined our input we can use it anywhere in the application:

### Example: Custom input

#### custom-input-default-config.react.jsx

```jsx
import { FormKit } from '@formkit/react'

function CustomInputDefaultConfigExample() {
  return <FormKit type="hello" />
}
```

#### formkit.config.react.jsx

```jsx
import { defineFormKitConfig } from '@formkit/react'

export default defineFormKitConfig({
  inputs: {
    hello: {
      type: 'input',
      schema: ['Hello world'],
    },
  },
})
```

### Plugin libraries

The above example extends the `@formkit/inputs` library (via `defaultConfig`). However, a powerful feature of FormKit is its ability to [load input libraries from multiple plugins](/essentials/architecture#library). These inputs can then be registered anywhere plugins can be defined:

- Globally
- Per group
- Per form
- Per list
- Per input

Let’s refactor our hello world input to use its own plugin:

### Example: Custom input - plugin

#### custom-input-plugin.react.jsx

```jsx
import { FormKit } from '@formkit/react'

const helloDefinition = {
  type: 'input',
  schema: ['Hello world'],
}

const myPlugin = () => {}

myPlugin.library = (node) => {
  if (node.props.type === 'hello') {
    node.define(helloDefinition)
  }
}

function CustomInputPluginExample() {
  return (
    <FormKit type="form" plugins={[myPlugin]} onSubmit={() => false}>
      <FormKit type="hello" />
    </FormKit>
  )
}
```

> **Tip:** Notice in the above example our plugin was defined on a parent of the element that actually used it! This is thanks to [plugin inheritance](/essentials/architecture#plugins) — a core feature of FormKit plugins.

## Schema vs component

Your input can be written using [FormKit’s schema](/essentials/schema) or a framework component. There are pros and cons to each approach:

| Code | Pros | Cons |
| --- | --- | --- |
| Component | Learning curve (you likely already know how to write components in your framework).Framework-native authoring experience.Slightly faster initial render. | Cannot use the sectionsSchema prop to modify structure.Plugins cannot modify schema to change rendered output.Framework specific.Easy to write inputs that don’t play well with the FormKit ecosystem. |
| Schema | Structure can be modified via the sectionsSchema prop (if you allow it).Plugins can modify/change the rendered output.Portable across supported frameworks.Ecosystem compatibility (great for publishing your own open source inputs). | Learning curve (need to understand schemas).Slightly slower initial render.Less mature dev tooling. |

> **Warning:** Even if you prefer to write a custom input using a standard component, you can still use a schema in your input definition. Please read the [Using createInput to extend the base schema](#using-createinput-to-extend-the-base-schema) section.

The primary takeaway is if you are planning to use a custom input on multiple projects — then consider using the schema-based approach. If your custom input will only be used in a single project and flexibility is not a concern, a framework component can be a pragmatic choice.

### Future proofing

Schema inputs are the most portable option across FormKit’s supported frameworks, including Vue and React. If you want a custom input to travel between frameworks with minimal changes, schema is still the best fit.

## Schema inputs

All of FormKit’s core inputs are written using schemas to allow for the greatest flexibility possible. You have two primary options when writing your own schema inputs:

- [Extend the base schema](#using-createinput-to-extend-the-base-schema) (recommended).
- Write your input from scratch.

It is important to understand the basic structure of a “standard” FormKit input, which is broken down into [sections](/essentials/inputs#sections):

The `custom-inputs` input is composed of sections that can be targeted for styling or extended with slots:

- outer - Outermost wrapping element
- wrapper - Wraps the label and input area
- label - The input's label element
- inner - Wraps the actual input element
- input - The native input element
- help - Help text below the input
- messages - Validation messages container
- message - Individual validation message

  Composition of a standard FormKit text input.
The `input` section in the diagram above is typically what you’ll swap out when creating your own inputs — keeping the wrappers, labels, help text, and messages intact. However, if you want to control these aspects as well, you can also write your own input from scratch.

#### Using createInput to extend the base schema

To create inputs using the base schema you can use the `createInput()` utility from <code>@formkit/react</code>. This function accepts 3 arguments:

- (required) A schema node *or* a framework component, which it inserts into the base schema at the `input` section (see diagram above).
- (optional) An object of [input definition](#input-definition) properties to merge with an auto-generated one.
- (optional) A `sectionsSchema` object (just [like the sections-schema prop](/essentials/inputs#sections-schema)) to merge with the base schema. This lets you modify the wrapping structure of the input.

The function returns a ready-to-use [input definition](#input-definition).

When providing a component as the first argument, `createInput` will generate a schema object that references your component within the base schema. Your component will be passed a single `context` prop:

```
{
  $cmp: 'YourComponent',
  props: {
    context: '$node.context'
  }
}

```

When providing a schema object, your schema is directly injected into the base schema object. Notice that our hello world example now supports outputting "standard" FormKit features like labels, help text, and validation:

### Example: Create input

#### create-input.react.jsx

```jsx
import { FormKit, createInput } from '@formkit/react'

const myInput = createInput('Hello world')

function CreateInputExample() {
  return (
    <FormKit
      type={myInput}
      label="Hello world example"
      help="You still cant interact with me, but im here!"
      validation="required"
      validationVisibility="live"
    />
  )
}
```

#### Writing schema inputs from scratch

It might make sense to write your inputs completely from scratch without using any of the base schema features. When doing so, just provide the [input definition](#input-definition) your full schema object.

### Example: Create input

#### scratch-schema-input.react.jsx

```jsx
import { FormKit } from '@formkit/react'

const myInput = {
  type: 'input',
  schema: [
    {
      $el: 'label',
      if: '$label',
      attrs: {
        class: '$classes.label',
      },
      children: '$label',
    },
    {
      $el: 'div',
      attrs: {
        class: '$classes.inner',
      },
      children: ['Hello world'],
    },
    {
      $el: 'div',
      if: '$help',
      attrs: {
        class: '$classes.help',
      },
      children: '$help',
    },
    {
      $el: 'ul',
      attrs: {
        class: '$classes.messages',
      },
      children: [
        {
          $el: 'li',
          for: ['message', '$messages'],
          attrs: {
            class: '$classes.message',
          },
          children: '$message.value',
        },
      ],
    },
  ],
}

function ScratchSchemaInputExample() {
  return (
    <FormKit
      type={myInput}
      label="Hello world example"
      help="You still cant interact with me, but im here!"
      validation="required"
      validationVisibility="live"
    />
  )
}
```

In the above example, we were able to re-create the same features as the `createInput` example — namely — label, help text, and validation message output. However, we are still missing a number of "standard" FormKit features like slot support. If you are attempting to publish your input or maintain API compatibility with the other FormKit inputs, take a look at the [input checklist](#input-checklist).

## Component inputs

> **Info:** When writing a custom FormKit input with framework components it is generally best to avoid nesting FormKit components inside the custom input itself. Custom inputs are meant to behave like regular inputs, using the FormKit `context` prop to add the behavior FormKit expects. If your real goal is to wrap an existing FormKit input with defaults or surrounding UI, prefer a normal framework component wrapper or FormKit’s [input export feature](/guides/export-and-restructure-inputs) instead.

For most users, [passing a component to createInput](#using-createinput-to-extend-the-base-schema) provides a good balance between customization and value-added features. If you’d like to completely eject from schema-based inputs altogether, you can pass a component directly to an input definition.

Component inputs receive a single prop — [the context object](/essentials/configuration). It’s then up to you to write a component that encompasses the desired features of FormKit (labels, help text, message display, etc.). Checkout the [input checklist](#input-checklist) for a list of what you’ll want to output.

## Input & output values

Inputs have two critical roles:

- Receiving user input.
- Displaying the current value.

### Receiving input

You can receive input from any user interaction and the input can set its value to any type of data. Inputs are *not* limited to strings and numbers — they can happily store Arrays, Objects, or custom data structures.

Fundamentally, all an input needs to do is call `node.input(value)` with a value. The `node.input()` method is automatically debounced, so feel free to call it frequently — like every keystroke. Typically, this looks like binding to the `input` event.

The [context object](/essentials/configuration) includes an input handler for basic input types: `context.handlers.DOMInput`. This can be used for text-like inputs where the value of the input is available at `event.target.value`. If you need a more complex event handler, you can [expose it using "features"](#adding-features).

Any user interaction can be considered an input event. For many native HTML inputs, that interaction is captured with the input event.

```
// An HTML text input written in schema:
{
  $el: 'input',
  attrs: {
    onInput: '$handlers.DOMInput'
  }
}

```

The equivalent in a React component:

```
function MyInput({ context }) {
  return <input onInput={context.handlers.DOMInput} />
}

```

### Displaying values

Inputs are also responsible for displaying the current value. Typically, you’ll want to use the `node._value` or `$_value` in schema to display a value. This is the "live" non-debounced value. The currently *committed* value is `node.value` (`$value`). Read more about "value settlement" [here](/essentials/architecture#setting-values).

```
// An HTML text input written in schema:
{
  $el: 'input',
  attrs: {
    onInput: '$handlers.DOMInput',
    value: '$_value'
  }
}

```

The equivalent in a React component:

```
function MyInput({ context }) {
  return <input value={context._value} onInput={context.handlers.DOMInput} />
}

```

> **Warning:** The only time the uncommitted input `_value` should be used is for displaying the value on the input itself — in all other locations, it is important to use the committed `value`.

## Adding props

The [standard FormKit props](/essentials/inputs#props--attributes) that you can pass to the `<FormKit>` component (like `label` or `type`) are available in the root of the [context object](/essentials/configuration) and in the [core node props](/essentials/architecture#config--props), and you can use these props in your schema by directly referencing them in expressions (ex: `$label`). Any props passed to a `<FormKit>` component that are not *node props* end up in the `context.attrs` object (just `$attrs` in the schema).

If you need additional props, you can declare them in your input definition. Props can also be used to accept new props from the `<FormKit>` component, but they are also used for internal input state.

FormKit uses the `props` namespace for both purposes (see the autocomplete example below for an example of this). Props should *always* be defined in camelCase and then consumed using camelCase in React JSX. There are 2 ways to define props:

1. [Array notation](#array-notation).
2. [Object notation](#object-notation).
3. [The node.addProps() method](#add-props-method)

### Array notation

### Example: Custom props

#### custom-props.react.jsx

```jsx
import { FormKit } from '@formkit/react'

const hello = {
  type: 'input',
  props: ['location'],
  schema: [
    {
      $el: 'h1',
      children: ['Hello ', '$location'],
    },
  ],
}

function CustomPropsExample() {
  return <FormKit type={hello} location="Mars" />
}
```

When extending the base schema by using the `createInput` helper, pass a second argument with input definition values to merge:

### Example: Custom props - createInput

#### custom-props-create-input.react.jsx

```jsx
import { FormKit, createInput } from '@formkit/react'

const myInput = createInput(
  {
    $el: 'input',
    attrs: {
      class: '$classes.input',
      placeholder: '$: "Hello " + $location',
    },
  },
  {
    props: ['location'],
    family: 'text',
  }
)

function CustomPropsCreateInputExample() {
  return (
    <FormKit
      type={myInput}
      label="Hello where?"
      location="Spain"
      help="We use the custom prop location in our placeholder."
    />
  )
}
```

### Object notation

Object notation gives you fine grained control over how your props are defined by giving you the ability to:

- Define a default value.
- Define `boolean` props that can be passed without a value.
- Define custom getter/setter functions.

### Example: Custom props - object notation

#### custom-props-object-notation.react.jsx

```jsx
import { FormKit, createInput } from '@formkit/react'

const myInput = createInput(
  {
    $el: 'button',
    for: ['option', '$options'],
    attrs: {
      class: '$classes.input',
      placeholder: '$: "Hello " + $location',
      onClick: '$handlers.setValue($option)',
      ariaSelected: '$: $option === $value',
    },
    children: ['$currency', '$option'],
  },
  {
    props: {
      capitalize: {
        boolean: true,
      },
      currency: {
        default: '',
      },
      options: {
        setter(value, node) {
          let options
          if (typeof value === 'string') {
            options = value.split(',')
          } else {
            options = value
          }
          if (node.props.capitalize) {
            options = options.map(
              (option) => option[0].toUpperCase() + option.slice(1)
            )
          }
          return options
        },
      },
    },
    features: [
      function setValues(node) {
        node.on('created', () => {
          node.context.handlers.setValue = (value) => () => node.input(value)
        })
      },
    ],
  }
)

function CustomPropsObjectNotationExample() {
  const [value, setValue] = useState({})

  return (
    <>
      <FormKit
        type="group"
        modelValue={value}
        onUpdateModelValue={(nextValue) => setValue(nextValue ?? {})}
      >
        <FormKit
          type={myInput}
          name="planet"
          label="Select a hospitable planet"
          capitalize
          options="earth,mars,venus"
          inputClass="border-2 border-gray-300 mr-2 mb-2 px-2 py-1 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm aria-[selected=true]:bg-gray-200 dark:bg-gray-800 dark:aria-[selected=true]:bg-blue-900 dark:border-gray-700 dark:focus:ring-gray-500 dark:focus:border-gray-500"
        />
        <FormKit
          type={myInput}
          name="price"
          label="Price"
          currency="$"
          options={['10.00', '12.99', '15.00']}
          help="How much are you willing to pay?"
          inputClass="border-2 border-gray-300 mr-2 mb-2 px-2 py-1 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm aria-[selected=true]:bg-gray-200 dark:bg-gray-800 dark:aria-[selected=true]:bg-blue-900 dark:border-gray-700 dark:focus:ring-gray-500 dark:focus:border-gray-500"
        />
      </FormKit>
      <pre>{JSON.stringify(value, null, 2)}</pre>
    </>
  )
}
```

### Add props method (node.addProps())

You can dynamically add props using the `node.addProps()` method in any runtime environment where you have access to the node. For custom inputs this is particularly helpful when used in a features. Both array notation and object notation are supported (see above).

### Example: Custom props - node.addProps

#### custom-props-add-props.react.jsx

```jsx
import { FormKit, createInput } from '@formkit/react'

function useLocation(node) {
  node.addProps({
    location: {
      default: 'World',
    },
  })
}

const myInput = createInput(
  {
    $el: 'input',
    attrs: {
      class: '$classes.input',
      placeholder: '$: "Hello " + $location',
    },
  },
  {
    family: 'text',
    features: [useLocation],
  }
)

function CustomPropsAddPropsExample() {
  return (
    <FormKit
      type={myInput}
      label="Hello where?"
      location="Andromeda"
      help="We used a feature with node.addProps() to add a location"
    />
  )
}
```

## Adding features

Features are the preferred way to add functionality to a custom input type. A "feature" is a function that receives the [core node](/essentials/architecture#node) as an argument. Effectively, they are plugins without inheritance (so they only apply to the current node). You can use features to add input handlers, manipulate values, interact with props, listen to events, and much more.

Features are defined in an array to encourage code reuse when possible. For example, we use a feature called “options” on `select`, `checkbox`, and `radio` inputs.

As an example, let's imagine you want to build an input that allows users to enter two numbers, and the value of the input is the sum of those two numbers:

### Example: Custom input - sum numbers

#### custom-sum.react.jsx

```jsx
import { FormKit, createInput } from '@formkit/react'

const sum = createInput(
  [
    {
      $el: 'input',
      attrs: {
        class: '$classes.addend',
        type: 'number',
        onInput: '$handlers.numberA',
      },
    },
    '+',
    {
      $el: 'input',
      attrs: {
        class: '$classes.addend',
        type: 'number',
        onInput: '$handlers.numberB',
      },
    },
    '= ',
    '$_value || 0',
  ],
  {
    features: [addHandlers],
    family: 'text',
  }
)

function addHandlers(node) {
  let numberA = 0
  let numberB = 0

  node.on('created', () => {
    node.context.handlers.numberA = (event) => {
      numberA = Number(event.target.value)
      node.input(numberA + numberB)
    }

    node.context.handlers.numberB = (event) => {
      numberB = Number(event.target.value)
      node.input(numberA + numberB)
    }
  })
}

function CustomSumExample() {
  const [groupValues, setGroupValues] = useState({})

  return (
    <>
      <FormKit
        type="group"
        modelValue={groupValues}
        onUpdateModelValue={(value) => setGroupValues(value ?? {})}
      >
        <p className="mb-4">
          To illustrate the final value of this input, let&apos;s stick it in a
          group.
        </p>
        <FormKit
          type={sum}
          name="mySum"
          label="Sum 2 numbers"
          help="Enter two numbers above and their values will be summed!"
        />
      </FormKit>
      <pre>{JSON.stringify(groupValues, null, 2)}</pre>
    </>
  )
}
```

#### formkit.config.react.jsx

```jsx
import { genesisIcons } from '@formkit/icons'
import { defineFormKitConfig } from '@formkit/react'

export default defineFormKitConfig({
  icons: {
    ...genesisIcons,
  },
  config: {
    classes: {
      addend: 'appearance-none bg-transparent my-0 mx-2 w-16 px-1',
    },
  },
})
```

## TypeScript support

FormKit is written in TypeScript and includes type definitions for all of its core inputs. If you are writing your own inputs and would like to provide TypeScript support you can define your own inputs using two module augmentations:

### Adding prop types

The `type` prop of the `<FormKit>` component is a string that is used as the key of a discriminated union of props (`FormKitInputProps`). By augmenting this type your custom inputs can define their own prop types. To do so you must augment the `FormKitInputProps` type to add your own custom types:

```
declare module '@formkit/inputs' {
  interface FormKitInputProps<Props extends FormKitInputs<Props>> {
    // This key and the `type` should match:
    'my-input': {
      // Define your input `type`:
      type: 'my-input',
      // Define an optional prop. Use camelCase for all prop names:
      myOptionalProp?: string | number
      // Define a required prop
      superImportantProp: number
      // Define the value type, this should always be a optional!
      value?: string | number
      // Use the Prop generic to infer information from another field, notice
      // we a utility "PropType" to infer the type of the `value` from the Props
      // generic:
      someOtherProp?: PropType<Props, 'value'>
    }
  }
}

```

### Adding slot types

If you define your own sections (slots) in your custom input, you can also add TypeScript support for those too. To do so, you must augment the `FormKitInputSlots` type to add your own custom slots:

```
declare module '@formkit/inputs' {
  interface FormKitInputProps<Props extends FormKitInputs<Props>> {
    'my-input' {
      type: 'my-input'
      // ... props here
    }
  }

  interface FormKitInputSlots<Props extends FormKitInputs<Props>> {
    'my-input': FormKitBaseSlots<Props>
  }
}

```

In the example above, we use `FormKitBaseSlots` — a TypeScript utility to add all the "basic" slots that most custom inputs implement, like `outer`, `label`, `help`, `message`, etc. However you could also define your own slots entirely from scratch, or augment `FormKitBaseSlots` to add additional slots (`FormKitBaseSlots<Props> & YourCustomSlots`).

```
declare module '@formkit/inputs' {
  // ... props here
  interface FormKitInputSlots<Props extends FormKitInputs<Props>> {
    'my-input': {
      // This will be the *only* slot available on the my-input input
      slotName: FormKitFrameworkContext & {
          // this will be available as slot data in the `slotName` slot
          fooBar: string
        }
      }
    }
  }
}

```

> **Warning:** In order to augment the `FormKitInputSlots`, you must first have written an augmentation for `FormKitInputProps` that at least includes the `type` prop.

## Examples

Below are some examples of custom inputs. They are not intended to be comprehensive or production ready, but rather illustrate some custom input features.

### Simple text input

This is the simplest possible input and does not leverage any of FormKit’s built in DOM structure and only outputs a text input — however it is a fully functional member of the group it is nested inside of and able to read and write values.

### Example: Create input

#### standard-text-input.react.jsx

```jsx
import { FormKit } from '@formkit/react'

const simpleText = {
  type: 'input',
  schema: [
    {
      $el: 'input',
      attrs: {
        onInput: '$handlers.DOMInput',
        value: '$_value',
        class: 'border border-gray-900 bg-transparent dark:border-gray-500',
      },
    },
  ],
}

function StandardTextInputExample() {
  const [groupValues, setGroupValues] = useState({})

  return (
    <>
      <FormKit
        type="group"
        modelValue={groupValues}
        onUpdateModelValue={(value) => setGroupValues(value ?? {})}
      >
        <FormKit type={simpleText} name="simple" />
      </FormKit>
      <pre>{JSON.stringify(groupValues, null, 2)}</pre>
    </>
  )
}
```

> **Tip:** In the above example the `$handlers.DOMInput` is a built-in convenience function for `(event) => node.input(event.target.value)`.

### Autocomplete input

Let’s take a look at a slightly more complex example that utilizes `createInput` to provide all the standard FormKit structure while still providing a custom input interface.

### Example: Create input

#### autocomplete.react.jsx

```jsx
import { FormKit } from '@formkit/react'

function AutocompleteExample() {
  return (
    <FormKit
      label="U.S. State"
      type="myAutocomplete"
      placeholder="Search for a state"
      help="What is your favorite U.S. state?"
      defaultValue="Virginia"
      options={stateList}
    />
  )
}
```

#### autocomplete-input.react.js

```js
import { createInput } from '@formkit/react'

const searchFeature = (node) => {
  node.on('created', () => {
    node.props.matches = []
    node.props.selection = ''

    const setValue = async (event) => {
      if (event && typeof event.preventDefault === 'function') {
        event.preventDefault()
      }
      node.input(node.props.selection)
      node.props.selection = ''
      node.props.searchValue = ''
      await new Promise((resolve) => setTimeout(resolve, 50))
      if (document.querySelector('input#' + node.props.id)) {
        document.querySelector('input#' + node.props.id).focus()
      }
    }

    const select = (delta) => {
      const available = node.props.matches
      let idx = available.indexOf(node.props.selection) + delta
      if (idx >= available.length) {
        idx = 0
      } else if (idx < 0) {
        idx = available.length - 1
      }
      node.props.selection = available[idx]
    }

    Object.assign(node.context.handlers, {
      setValue,
      selection: (event) => {
        switch (event.key) {
          case 'Enter':
            return setValue()
          case 'ArrowDown':
            event.preventDefault()
            return select(1)
          case 'ArrowUp':
            event.preventDefault()
            return select(-1)
        }
      },
      search(event) {
        node.props.searchValue = event.target.value
      },
      hover: (event) => {
        node.props.selection = event.target.textContent
      },
      unhover: (event) => {
        if (event.target.textContent === node.props.selection) {
          node.props.selection = ''
        }
      },
    })
  })

  node.on('prop:searchValue', ({ payload: value }) => {
    const results = node.props.options.filter((option) =>
      option.toLowerCase().startsWith(value.toLowerCase())
    )
    if (!results.length) results.push('No matches')
    node.props.matches = results
  })
}

const schema = {
  if: '$value',
  then: [
    {
      $el: 'a',
      attrs: {
        id: '$id',
        href: '#',
        class: '$classes.value',
        onClick: '$handlers.setValue',
      },
      children: '$value',
    },
  ],
  else: [
    {
      $el: 'input',
      bind: '$attrs',
      attrs: {
        id: '$id',
        class: '$classes.input',
        onKeydown: '$handlers.selection',
        onInput: '$handlers.search',
        value: '$searchValue',
      },
    },
    {
      $el: 'ul',
      if: '$matches.length < $options.length',
      attrs: {
        class: '$classes.dropdown',
      },
      children: [
        {
          $el: 'li',
          for: ['match', '$matches'],
          attrs: {
            'data-selected': {
              if: '$selection === $match',
              then: 'true',
              else: 'false',
            },
            class: '$classes.dropdownItem',
            onClick: '$handlers.setValue',
            onMouseenter: '$handlers.hover',
            onMouseleave: '$handlers.unhover',
          },
          children: '$match',
        },
      ],
    },
  ],
}

const autocomplete = createInput(schema, {
  props: ['options', 'matches', 'selection', 'searchValue'],
  features: [searchFeature],
  family: 'text',
})

export default autocomplete
```

#### formkit.config.react.jsx

```jsx
import { genesisIcons } from '@formkit/icons'
import { defineFormKitConfig } from '@formkit/react'
import { generateClasses } from '@formkit/themes'
import autocomplete from './_examples__autocomplete__autocomplete-input.react.js'

export default defineFormKitConfig({
  icons: {
    ...genesisIcons,
  },
  inputs: {
    myAutocomplete: autocomplete,
  },
  config: {
    classes: generateClasses({
      myAutocomplete: {
        inner: 'relative !p-0',
        dropdown:
          'absolute top-full left-0 min-w-[15em] bg-white shadow-md m-0 p-0 list-none overflow-hidden rounded-md dark:bg-slate-800',
        dropdownItem:
          'p-2 border-b border-gray-200 data-[selected=true]:bg-blue-100 dark:border-gray-700 dark:data-[selected=true]:bg-blue-800 dark:text-gray-200',
        input: 'w-full !p-[0.55em]',
        value:
          'flex items-center justify-between w-full p-[0.55em] bg-gray-100 dark:bg-slate-800 !text-gray-800 dark:!text-gray-200 rounded-md after:content-["×"] after:first-letter:ml-[0.5em] after:text-[1.1em] hover:text-current hover:!no-underline dark:hover:text-current dark:hover:!no-underline',
      },
    }),
  },
})
```

## Input checklist

FormKit exposes dozens of value-added features to even the most mundane inputs. When writing a custom input for a specific project, you only need to implement the features that will actually be used on that project. However, if you plan to distribute your inputs to others, you will want to ensure these features are available. For example, the standard `<FormKit type="text">` input uses the following schema for its `input` element:

```
{
  $el: 'input',
  bind: '$attrs',
  attrs: {
    type: '$type',
    disabled: '$disabled',
    class: '$classes.input',
    name: '$node.name',
    onInput: '$handlers.DOMInput',
    onBlur: '$handlers.blur',
    value: '$_value',
    id: '$id',
  }
}

```

There are several features in the above schema that may not be immediately obvious like the `onBlur` handler. The following checklist is intended to help input authors cover all their bases:
