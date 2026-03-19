# Configuration

Learn to customize your forms to your precise needs.

## Introduction

FormKit uses a unique hierarchical configuration system that is well suited for forms. To understand how this configuration works, there are 4 questions we need to answer:

1. [What are core nodes](#what-are-core-nodes)?
2. [What are node options](#what-are-node-options)?
3. [What are node props](#what-are-node-props)?
4. [What is node config](#what-is-node-config)?

## What are core nodes?

Every `<FormKit>` component has its own instance of a core node. This node is responsible for almost all of the component’s functionality. There are 3 types of core nodes: inputs, lists, and groups (forms are just a type of group!).

There is no global FormKit instance that controls the application. Instead, you can think of each node as its own little application — complete with its own configuration.

One last thing about nodes — they can all have parent nodes. Groups and lists can also have children. For example, a login form might have two children — the email and password inputs. You can draw this relationship as a simple tree diagram:


  Hover over each node to see its initial options.
## What are node options?

When creating one of these "mini applications" that we call core nodes, some options can be passed in. Except in extremely advanced use cases, you won't be creating your own core nodes — this is normally done for you by the `<FormKit>` component. However, it can be useful to define some of the node options globally. This is done with the `@formkit/vue` plugin —  **core node options are the same as the @formkit/vue plugin options**.

For example, in a typical FormKit Vue registration, we use `defaultConfig` which is just a function that returns core node options:

```
import { createApp } from 'vue'
import App from 'App.vue'
import { plugin, defaultConfig } from '@formkit/vue'

// 👀 defaultConfig is just a function that returns core node options!
createApp(App).use(plugin, defaultConfig)

```

### Available node options

The following is a list of all the available options that can be used when registering FormKit or creating a node individually. Options that are passed to the `@formkit/vue` plugin will be applied to every `<FormKit>` component’s core node when it is created.

```
createNode({
  /**
   * Used to rename the global "FormKit" component.
   */
  alias: 'FormKit',
  /**
   * This array is normally built for you by the FormKit component.
   */
  children: [],
  /**
   * An object of config settings. Keep reading for more on this.
   */
  config: {},
  /**
   * The name of the node — normally this is mapped to the name of your input.
   */
  name: 'inputName',
  /**
   * Parent — this is normally set for you by the FormKit component.
   */
  parent: null,
  /**
   * An array of plugin functions
   */
  plugins: [],
  /**
   * Default prop values, keep reading to learn more.
   */
  props: {},
  /**
   * Used to rename the global "FormKitSchema" component.
   */
  schemaAlias: 'FormKitSchema',
  /**
   * All are only 1 of 3 values: 'input', 'group', or 'list'
   */
  type: 'input',
  /**
   * The initial value of the node.
   */
  value: 'foobar',
})

```

### What is defaultConfig?

Developers familiar with FormKit will notice that the above list of node options differs slightly from the values that can be passed into the `defaultConfig` function.

Many of FormKit’s features, like validation, inputs, and Vue support are provided courtesy of first-party plugins. The `defaultConfig` function configures many of these plugins before they are given over to the Vue plugin as node options. So, `defaultConfig` can accept any of the above node options, but also a few extras:

```
defaultConfig({
  /**
   * Validation rules to add or override.
   * See validation docs.
   */
  rules: {},
  /**
   * Locales to register.
   * See internationalization docs.
   */
  locales: {},
  /**
   * Input definitions to add or override.
   * See docs on custom inputs.
   */
  inputs: {},
  /**
   * Explicit locale messages to override.
   * See internationalization docs.
   */
  messages: {},
  /**
   * The currently active locale. This is actually a config setting, but
   * defaultConfig accepts it as a top-level value to improve the DX.
   */
  locale: 'en',
  /**
   * Any of the above node options are accepted.
   */
  ...nodeOptions,
})

```

## What are node props?

All core nodes have a `props` object (`node.props`). FormKit core, and any third-party plugins or code can read and write values to this object. In fact, nearly every feature of FormKit references `node.props` to determine how it should operate.

For example, the validation plugin looks at `node.props.validation` to determine if there are any rules it needs to run. So the real question is — how are these props being set? There are 3 primary mechanisms for setting props:

- Direct assignment
- Component props
- Global options
- Provider options

Let’s see how we can set the validation rules of an input (`node.props.validation`) these three ways:

### 1. Direct assignment

If you have a node instance, you can directly assign it a prop value:

### Example: Direct node assignment

#### node-assignment.vue

```vue
<script setup>
import { getNode } from '@formkit/core'

function addValidation() {
  const node = getNode('ssn')
  node.props.validation = 'required|matches:/\\d{3}-\\d{2}-\\2{4}/'
}
</script>

<template>
  <FormKit
    id="ssn"
    label="Social security number"
    type="text"
    help="Initially this input has no validation"
    placeholder="XXX-XX-XXXX"
    validation-visibility="live"
  />

  <FormKit type="button" @click="addValidation">Add validation</FormKit>
</template>
```

### 2. Component props

Any props passed to the `<FormKit>` input are assigned to the `node.props` object (you know the drill).

### Example: Component props

#### component-props.vue

```vue
<template>
  <FormKit
    type="text"
    label="Health insurance group"
    placeholder="G-XXXXX"
    validation="required|matches:/^G-\d{5}$/"
    validation-visibility="live"
    :validation-messages="{
      matches: 'Must be in the format G-12345',
    }"
  />
</template>
```

### 3. Global options

When registering the `@formkit/vue` plugin (or using `@formkit/nuxt` with a `formkit.config.ts`) you can provide prop values to be injected into to all `<FormKit>` components.

### Example: Component props

#### vue-plugin-props.vue

```vue
<!--
    👀 The validation prop is not set here but both
    inputs are receiving the validation prop 
    from the formkit.config file.
   -->
  <FormKit
    label="Username"
    validation-visibility="live"
  />
  <FormKit
    type="password"
    label="Password"
    validation-visibility="live"
  />
```

#### formkit.config.ts

```ts
import { defineFormKitConfig } from '@formkit/vue'
import { genesisIcons } from '@formkit/icons'
import { rootClasses } from '~/formkit.theme'

export default defineFormKitConfig({
  props: {
    validation: 'required|length:5,20',
  },
  icons: {
    ...genesisIcons,
  },
  config: {
    rootClasses,
  },
})
```

### 4. Provider options

Similar to global options the `<FormKitProvider>` component allows you to specify what "global" configuration options should be injected into its children. This technique can be used to create a "scoped" configuration for a specific section of an app, override global options for a specific section of an app, or provide more targeted loading of the FormKit library.

When using the `<FormKitProvider>` component, all globally defined options (from global plugin) are removed and only options provided by the provider are used on any `<FormKit>` components within its scope.

> **Tip:** The @formkit/nuxt module with autoImport: true enabled automatically wraps your components that use FormKit in a <FormKitProvider> component. This keeps formkit from being included in your entry bundle.

## What is node config?

Props are pretty powerful, but in addition to `node.props`, core nodes all have a config object `node.config`. This is where configuration hierarchy comes in. The `node.config` object acts like initial values for `node.props`. If a given prop is requested, like `node.props.validation`, and that property is not explicitly set using any of the [methods discussed above](#what-are-node-props), then FormKit will check the `node.config` object to see if it has a value. If it does not have a value, then it recursively checks the node parent's config object — then the grandparent's config object — and so on — until a value is found or it reaches a node with no parent.


  
  This diagram describes how a request for property of node.props resolves.
What does this mean in practice? When you combine the tree like structure of forms (and their corresponding core nodes) and this hierarchical configuration you can do some pretty exciting things. For example, here we set the validation visibility of an entire form:

### Example: Validation visibility

#### validation-visibility.vue

```vue
<!-- config is passed down to descendant inputs: -->
  <FormKit
    type="form"
    @submit="() => false"
    :config="{ validationVisibility: 'submit' }"
  >
    <FormKit
      type="text"
      label="Name"
      validation="required|length:3"
      help="Enter your full name."
    />
    <FormKit
      type="date"
      label="Birthday"
      validation="required|date_between:1990-01-01 00:00:00,1999-12-31 23:59:59"
      :validation-messages="{ date_between: 'Only for those born in the 90s.' }"
      help="Enter your date of birth"
    />
    <!-- We override validation-visibility for the input below: -->
    <FormKit
      type="tel"
      label="Phone Number"
      placeholder="xxx-xxx-xxxx"
      validation="required|matches:/^[0-9]{3}-[0-9]{3}-[0-9]{4}$/"
      validation-visibility="live"
      help="What are your digits?"
    />
  </FormKit>
```

It’s worth noting that plugins have their own inheritance model which differs from `config` and `props`, and is described in more detail in the [core documentation](/essentials/architecture).
