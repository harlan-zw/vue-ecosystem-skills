# Multi-Step Input Plugin

Easily add multi-step sections to your FormKit forms.

## Introduction

FormKit ships with a first-party multi-step input plugin available from the `@formkit/addons` package. This input allows you to build a wizard or easily break your forms into multiple steps. Breaking forms into multiple steps can improve the user-experience of larger forms by keeping them feeling small and approachable compared to listing all inputs at once.

## Installation

To use this plugin with FormKit, install `@formkit/addons`:

```
yarn add @formkit/addons

```

Once you've installed the addons package, you'll need to register the plugin with FormKit and include the supporting CSS styles:

```
// formkit.config.ts
import { defaultConfig } from '@formkit/vue'
import { createMultiStepPlugin } from '@formkit/addons'

const config = defaultConfig({
  plugins: [createMultiStepPlugin()],
})

export default config

```

#### A quick demonstration of the multi-step input type in action:

### Example: Multi-Step Introduction

#### intro.vue

```vue
<template>
  <FormKit type="form" :actions="false">
    <FormKit type="multi-step" tab-style="tab">
      <FormKit type="step" name="personalInfo">
        <!-- component for example brevity. -->
        <StepOne />
      </FormKit>

      <FormKit type="step" name="references">
        <!-- component for example brevity. -->
        <StepTwo />
      </FormKit>

      <FormKit type="step" name="Supplemental">
        <!-- component for example brevity. -->
        <StepThree />

        <!-- using step slot for submit button-->
        <template #stepNext>
          <FormKit type="submit" />
        </template>
      </FormKit>
    </FormKit>
  </FormKit>
</template>
```

#### step-one.vue

```vue
<template>
  <FormKit
    type="text"
    label="Name"
    prefix-icon="avatarMan"
    validation="required"
  />
  <FormKit
    type="email"
    label="Email"
    prefix-icon="email"
    validation="required|email"
  />
  <FormKit
    type="text"
    name="phone"
    label="Phone"
    prefix-icon="telephone"
    validation="required"
  />
</template>
```

#### step-two.vue

```vue
<template>
  <FormKit
    type="textarea"
    label="Why do you want to work here?"
    validation="required"
  />
  <FormKit
    type="radio"
    label="How did you hear about us"
    validation="required"
    :options="[
      { label: 'Google', value: 'google' },
      { label: 'Facebook', value: 'facebook' },
      { label: 'Twitter', value: 'twitter' },
      { label: 'Friend', value: 'friend' },
    ]"
  />
</template>
```

#### step-three.vue

```vue
<template>
  <FormKit
    type="textarea"
    label="Please supply contact information for 2 references"
    validation="required"
  />
</template>
```

#### formkit.config.ts

```ts
import { defineFormKitConfig } from '@formkit/vue'
import { createProPlugin, inputs } from '@formkit/pro'
import { genesisIcons } from '@formkit/icons'
import { rootClasses } from '~/formkit.theme'
import { createMultiStepPlugin } from '@formkit/addons'

const pro = createProPlugin(import.meta.env.VITE_FORMKIT_PRO_KEY, inputs)

export default defineFormKitConfig({
  plugins: [pro, createMultiStepPlugin()],
  icons: {
    ...genesisIcons,
  },
  config: {
    rootClasses,
  },
})
```

## Usage

The `createMultiStepPlugin` function registers two new input types for you to use with the `FormKit` component.

- `multi-step`: The wrapping group for the entire multi-step input. This input keeps track of which step is active, validation and errors per step, and should only contain `step` inputs as its immediate children
- `step`: The wrapping group for a given step within your multi-step input. Should only be an immediate child of a `multi-step` input. Its children will be rendered as the contents of the step.

Using these inputs together is as simple as wrapping any markup you want to have present within a step in a multi-step form.

```
<FormKit type="multi-step">
  <FormKit type="step" name="stepOne">
    <!-- content for stepOne goes here! -->
  </FormKit>
</FormKit>

```

Out-of-the-box the parent `multi-step` input will track the validity of the inputs contained in each child `step` input and prevent advancing to the next `step` until the current step is valid. The count of total blocking validations and errors will be shown next to the current step name if a user attempts to advance to the next step or submit the form before satisfying the current step's input validations.

## Tab style

The `multi-step` input ships with two available tab styles.

- `tab`: The default tab experience. Each step name is show in a tab with an active state. Error count is shown in the top right of the tab.
- `progress`: A progress bar style where each step is a "node" on a timeline of total steps. With this display mode you can also use the `hide-progress-labels` prop to hide the step names.

### Example: Multi-Step Introduction

#### tab-style.vue

```vue
<!-- default tab style -->
  <FormKit type="multi-step" tab-style="tab">
    <MultiStepContent />
  </FormKit>

  <!-- progress tab style -->
  <FormKit type="multi-step" tab-style="progress">
    <MultiStepContent />
  </FormKit>

  <!-- progress tab style w/ hidden labels -->
  <FormKit type="multi-step" tab-style="progress" :hide-progress-labels="true">
    <MultiStepContent />
  </FormKit>
```

#### multi-step-content.vue

```vue
<template>
  <FormKit type="step" name="stepOne">
    <FormKit type="text" label="Name" validation="required" />
  </FormKit>
  <FormKit type="step" name="stepTwo">
    <FormKit type="textarea" label="Your story" validation="required" />
  </FormKit>
  <FormKit type="step" name="stepThree">
    <FormKit type="textarea" label="Something else" validation="required" />
  </FormKit>
</template>
```

#### formkit.config.ts

```ts
import { defineFormKitConfig } from '@formkit/vue'
import { createProPlugin, inputs } from '@formkit/pro'
import { genesisIcons } from '@formkit/icons'
import { rootClasses } from '~/formkit.theme'
import { createMultiStepPlugin } from '@formkit/addons'

const pro = createProPlugin(import.meta.env.VITE_FORMKIT_PRO_KEY, inputs)

export default defineFormKitConfig({
  plugins: [pro, createMultiStepPlugin()],
  icons: {
    ...genesisIcons,
  },
  config: {
    rootClasses,
  },
})
```

## Step labels

By default the `multi-step` input will use the `name` attribute of its child `step` inputs to generate labels for steps. If you'd like more control over the display of your step names you can use the `label` prop. You can also customize the labels that appear in the `stepActions` section of your `step` using the `previous-label` and `next-label` props.

- `label`: An override for the step name that should appear in the multi-step tabs.
- `previous-label`: an override for the `stepPrevious` button label which defaults to `Back`.
- `next-label`: an override for the `stepNext` button label which defaults to `Next`.

### Example: Step Labels

#### step-labels.vue

```vue
<FormKit
      type="step"
      name="stepOne"
      label="My Custom Label"
      next-label="Continue to next step"
    >
      <FormKit type="text" label="Name" />
    </FormKit>

    <FormKit type="step" name="stepTwo" previous-label="Go back to previous step">
      <FormKit type="textarea" label="Your story" />
    </FormKit>
```

#### formkit.config.ts

```ts
import { defineFormKitConfig } from '@formkit/vue'
import { createProPlugin, inputs } from '@formkit/pro'
import { genesisIcons } from '@formkit/icons'
import { rootClasses } from '~/formkit.theme'
import { createMultiStepPlugin } from '@formkit/addons'

const pro = createProPlugin(import.meta.env.VITE_FORMKIT_PRO_KEY, inputs)

export default defineFormKitConfig({
  plugins: [pro, createMultiStepPlugin()],
  icons: {
    ...genesisIcons,
  },
  config: {
    rootClasses,
  },
})
```

## Allow incomplete steps

By default the `multi-step` input will allow advancing to later steps even if the current step or a step between the current step and the target step has blocking validation messages. To prevent a user from jumping ahead set the `allow-incomplete` prop to `false`.

### Example: Allow Incomplete

#### allow-incomplete.vue

```vue
<FormKit type="multi-step" :allow-incomplete="false">
    <FormKit type="step" name="personalInfo">
      <!-- component for example brevity. -->
      <StepOne />
    </FormKit>

    <FormKit type="step" name="references">
      <!-- component for example brevity. -->
      <StepTwo />
    </FormKit>

    <FormKit type="step" name="Supplemental">
      <!-- component for example brevity. -->
      <StepThree />
    </FormKit>
  </FormKit>
```

#### step-one.vue

```vue
<template>
  <FormKit
    type="text"
    label="Name"
    prefix-icon="avatarMan"
    validation="required"
  />
  <FormKit
    type="email"
    label="Email"
    prefix-icon="email"
    validation="required|email"
  />
  <FormKit
    type="text"
    name="phone"
    label="Phone"
    prefix-icon="telephone"
    validation="required"
  />
</template>
```

#### step-two.vue

```vue
<template>
  <FormKit
    type="textarea"
    label="Why do you want to work here?"
    validation="required"
  />
  <FormKit
    type="radio"
    label="How did you hear about us"
    validation="required"
    :options="[
      { label: 'Google', value: 'google' },
      { label: 'Facebook', value: 'facebook' },
      { label: 'Twitter', value: 'twitter' },
      { label: 'Friend', value: 'friend' },
    ]"
  />
</template>
```

#### step-three.vue

```vue
<template>
  <FormKit
    type="textarea"
    label="Please supply contact information for 2 references"
    validation="required"
  />
</template>
```

#### formkit.config.ts

```ts
import { defineFormKitConfig } from '@formkit/vue'
import { createProPlugin, inputs } from '@formkit/pro'
import { genesisIcons } from '@formkit/icons'
import { rootClasses } from '~/formkit.theme'
import { createMultiStepPlugin } from '@formkit/addons'

const pro = createProPlugin(import.meta.env.VITE_FORMKIT_PRO_KEY, inputs)

export default defineFormKitConfig({
  plugins: [pro, createMultiStepPlugin()],
  icons: {
    ...genesisIcons,
  },
  config: {
    rootClasses,
  },
})
```

## Valid step icon

When a step has been completed with no validation errors the `multi-step` input will — by default — render a check icon showing that the step is valid and no more action is required. The `valid-step-icon` is a [FormKit Icon](/essentials/icons) and can be changed via a prop like any other FormKit icon.

You can either:

- Change the `valid-step-icon` on the `multi-step` input to change the icon for all steps inside the input.
- Change the `valid-step-icon` on a `step` input to change or override the icon just for that step.

### Example: Valid Step Icon

#### valid-step-icon.vue

```vue
<!-- on multi-step we set all icons to 'star' -->
  <FormKit type="multi-step" valid-step-icon="star" tab-style="progress">
    <FormKit type="step" name="stepOne">
      <FormKit type="text" label="Name" />
    </FormKit>
    <FormKit type="step" name="stepTwo">
      <FormKit type="textarea" label="Your story" />
    </FormKit>
    <!-- on this step we set the icon to 'submit' -->
    <FormKit type="step" valid-step-icon="submit" name="stepThree">
      <FormKit type="textarea" label="Something else" />
    </FormKit>
  </FormKit>
```

#### formkit.config.ts

```ts
import { defineFormKitConfig } from '@formkit/vue'
import { createProPlugin, inputs } from '@formkit/pro'
import { genesisIcons } from '@formkit/icons'
import { rootClasses } from '~/formkit.theme'
import { createMultiStepPlugin } from '@formkit/addons'

const pro = createProPlugin(import.meta.env.VITE_FORMKIT_PRO_KEY, inputs)

export default defineFormKitConfig({
  plugins: [pro, createMultiStepPlugin()],
  icons: {
    ...genesisIcons,
  },
  config: {
    rootClasses,
  },
})
```

## Customizing step actions

Each `step` in a `multi-step` input has default buttons rendered for moving between steps. By default the first `step` in a `multi-step` will only have a `stepNext` action button rendered, and the last `step` will only have a `stepPrevious` action button. This allows a multi-step to act as a self-contained group within the context of a larger form.

If you want to add a custom action such as a form submit to a `multi-step` — useful if you're using the `multi-step` as your whole form — you can do so by overriding the `stepNext` slot on the desired step. In this case we'll add a `submit` input to the last step in our `multi-step` input to submit the form.

The `stepNext` and `stepPrevious` sections have access to the `incrementStep` handler — which returns a callable function — to enable programatic navigation.

> **Warning:** By default, the stepNext in a multi-step input uses event listeners to capture tab navigation via keyboard and allow users to cycle through all available steps within a multi-step.If you want to preserve this behaviour in your own custom stepNext implementation then be sure to add a data-next="true" attribute to your focusable element that triggers step navigation.

### Example: Customizing step actions

#### step-actions.vue

```vue
<!-- we'll get rid of the default form actions -->
  <FormKit type="form" :actions="false">
    <FormKit type="multi-step" tab-style="tab">
      <FormKit type="step" name="personalInfo">
        <FormKit type="text" label="Name" prefix-icon="avatarMan" />

        <template #stepNext="{ handlers, node }">
          <!-- incrementStep returns a callable function -->
          <FormKit
            type="button"
            @click="handlers.incrementStep(1)()"
            label="Custom Next"
            data-next="true"
          />
        </template>
      </FormKit>

      <FormKit type="step" name="references">
        <FormKit
          type="textarea"
          label="Please supply contact information for 2 references"
          validation="required"
        />

        <template #stepPrevious="{ handlers, node }">
          <!-- incrementStep returns a callable function -->
          <FormKit
            type="button"
            @click="handlers.incrementStep(-1)()"
            label="Custom Previous"
          />
        </template>
        <!--
        normally there is no stepNext section rendered
        on the last step of a multi-step. But we can
        supply our own.
         -->
        <template #stepNext>
          <FormKit type="submit" />
        </template>
      </FormKit>
    </FormKit>
  </FormKit>
```

#### formkit.config.ts

```ts
import { defineFormKitConfig } from '@formkit/vue'
import { createProPlugin, inputs } from '@formkit/pro'
import { genesisIcons } from '@formkit/icons'
import { rootClasses } from '~/formkit.theme'
import { createMultiStepPlugin } from '@formkit/addons'

const pro = createProPlugin(import.meta.env.VITE_FORMKIT_PRO_KEY, inputs)

export default defineFormKitConfig({
  plugins: [pro, createMultiStepPlugin()],
  icons: {
    ...genesisIcons,
  },
  config: {
    rootClasses,
  },
})
```

## The beforeStepChange event

Sometimes you need to *do* something with your form data between steps. Maybe you want to submit each step independently to your back-end or you need to log analytics events to determine how far users are making it through your form. In cases such as these you can use the `beforeStepChange` event. `beforeStepChange` accepts a function and is provided a context object with the following keys:

- `currentStep`: The currently active step node context object that the user is navigating away from.
- `targetStep`: The step node context object that the user is navigating to.
- `delta`: The distance between steps. Positive integers represent stepping forward, negative integers represent stepping backward.

Your `beforeStepChange` function should return a `Boolean`. Returning `false` will *prevent* the step change from ocurring.

`beforeStepChange` can be used on your `multi-step` input in which case it will apply to *all* steps. Additionally you can use `beforeStepChange` on a specific `step` input to run your function only when navigating away from the step which has the function assigned. `beforeStepChange` applied to a `step` will override any `beforeStepChange` set on a parent `multi-step` if one exists.

### Example: beforeStepChange

#### before-step-change.vue

```vue
<FormKit
    type="multi-step"
    :before-step-change="
      ({ currentStep, targetStep, delta }) => {
        stepInformation.value = {
          currentStepName: currentStep.stepName,
          targetStepName: targetStep.stepName,
          delta,
        }
        // Change to false to block all step changes
        return true
      }
    "
  >
    <FormKit type="step" name="personalInfo">
      <FormKit type="text" label="Name" prefix-icon="avatarMan" />
    </FormKit>

    <FormKit type="step" name="favoriteThing">
      <FormKit type="text" label="Favorite Thing" prefix-icon="star" />
    </FormKit>

    <FormKit type="step" name="happyMemory">
      <FormKit type="text" label="Happy Memory" prefix-icon="happy" />
    </FormKit>
  </FormKit>
```

#### formkit.config.ts

```ts
import { defineFormKitConfig } from '@formkit/vue'
import { createProPlugin, inputs } from '@formkit/pro'
import { genesisIcons } from '@formkit/icons'
import { rootClasses } from '~/formkit.theme'
import { createMultiStepPlugin } from '@formkit/addons'

const pro = createProPlugin(import.meta.env.VITE_FORMKIT_PRO_KEY, inputs)

export default defineFormKitConfig({
  plugins: [pro, createMultiStepPlugin()],
  icons: {
    ...genesisIcons,
  },
  config: {
    rootClasses,
  },
})
```

## Programmatic Navigation

The multi-step node is equipped with convenient helper functions designed to facilitate programmatic navigation between any of its steps. These functions include:

- `next`: It goes to the next `step` from the current selected step.
- `previous`: It goes to the previous `step` from the current selected step.
- `goTo`: It accepts a `step` argument to move to that step from the current selected step, it accepts the index or the name of the step.

### Example: programmaticNavigation

#### programmatic-navigation.vue

```vue
<script setup>
import { getNode } from '@formkit/core'

const next = () => {
  const node = getNode('multi-step')
  node.next()
}

const previous = () => {
  const node = getNode('multi-step')
  node.previous()
}

const goTo = () => {
  const node = getNode('multi-step')
  node.goTo('favoriteThing')
}
</script>
```

#### formkit.config.ts

```ts
import { defineFormKitConfig } from '@formkit/vue'
import { createProPlugin, inputs } from '@formkit/pro'
import { genesisIcons } from '@formkit/icons'
import { rootClasses } from '~/formkit.theme'
import { createMultiStepPlugin } from '@formkit/addons'

const pro = createProPlugin(import.meta.env.VITE_FORMKIT_PRO_KEY, inputs)

export default defineFormKitConfig({
  plugins: [pro, createMultiStepPlugin()],
  icons: {
    ...genesisIcons,
  },
  config: {
    rootClasses,
  },
})
```

## Props & Attributes (multi-step)

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `allowIncomplete` | `boolean` | `true` | When true, allows users to navigate between steps even if current step is invalid. |
| `tabStyle` | `string` | `tab` | Used to set a data-attribute for creating tab styles. Default theme ships with support for tab and progress tab styles. |
| `hideProgressLabels` | `boolean` | `false` | When true, hides labels for the progress tab style. |
| `validStepIcon` | `string` | `check` | Specifies an icon to put in the badge section when a step is valid. When applied to the multi-step the icon will be applied to all child step inputs. |
| `beforeStepChange` | `function` | `undefined` | A function to run before the active step is changed. The function is supplied with a context object containing currentStep and targetStep which are both FormKit node context objects. Additionally, delta is supplied as an integer which reflects the distance between currentStep and targetStep. When supplied to the multi-step this function will fire on every step change. |

## Props & Attributes (step)

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `label` | `string` | `-` | Used to change the tab label of the step. If not custom label is supplied the step's name will be used. |
| `previousLabel` | `string` | `Previous` | Used to change the label of the default previousAction button. |
| `nextLabel` | `string` | `Next` | Used to change the label of the default nextAction button. |
| `previousAttrs` | `object` | `[object Object]` | Used to apply attributes to the default previousAction button input. |
| `nextAttrs` | `object` | `[object Object]` | Used to apply attributes to the default nextAction button input. |
| `validStepIcon` | `string` | `check` | Specifies an icon to put in the badge section when the step is valid. When applied to a step the icon will be applied only to the target step. |
| `beforeStepChange` | `function` | `undefined` | A function to run before the active step is changed. The function is supplied with a context object containing currentStep and targetStep which are both FormKit node context objects. Additionally, delta is supplied as an integer which reflects the distance between currentStep and targetStep. When supplied to a step this function will fire only when navigating away from the specified step. |

## Sections

You can target specific sections of an input using the `section-key` attribute or slots. Each section can be styled or customized independently.

## Slot Data

### Universal Slot Data

Available in all sections of this input:

| Property | Type | Description |
|----------|------|-------------|
| `_value` | `any` | The current  |
| `_root` | `Document | ShadowRoot` | The root document or shadow root the input is inside. This can be set by using a higher-order `<FormKitRoot>` component. |
| `attrs` | `Record<string, any>` | An object of attributes that (generally) should be applied to the root <input> element. |
| `classes` | `Record<string, string>` | Classes to apply on the various sections. |
| `defaultMessagePlacement` | `boolean` | Whether or not to render messages in the standard location. |
| `describedBy` | `string` | The ID of an element that describes the input. This is generally used for screen readers. |
| `didMount` | `boolean` | Whether or not the input has been mounted. |
| `disabled` | `boolean` | Whether the input is disabled. |
| `family` | `string` | The family of the input. This is generally the same as the input type but can be used to group similar inputs for styling purposes. |
| `fns` | `Record<string, (...args: any[]) => any>` | Utility functions, generally for use in the input’s schema. |
| `help` | `string` | The help text of the input |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers. |
| `id` | `string` | The unique id of the input. Should also be applied as the id attribute. This is generally required for accessibility reasons. |
| `items` | `symbol[]` | An array of symbols that represent the a child’s nodes. These are not the child’s nodes but are just symbols representing them. They are used to iterate over the children for rendering purposes. |
| `label` | `string` | The label of the input |
| `messages` | `Record<string, FormKitMessage>` |  A list of messages to be displayed on the input. Often these are validation messages and error messages, but other `visible` core node messages do also apply here. This object is only populated when the validation should be actually displayed. |
| `node` | `FormKitNode` | The cored node of this input. |
| `slots` | `Record<string, CallableFunction>` | A record of slots that have been passed into the top level component responsible for creating the node. |
| `state` | `FormKitFrameworkContextState` | A collection of state trackers/details about the input |
| `type` | `string` | The type of input eg.  |
| `ui` | `Record<string, FormKitMessage>` | Translated ui messages that are not validation related. These are generally used for interface messages like  |
| `value` | `any` | The current committed value of the input. This is the value that should be used for most use cases. The setting of this property is debounced by the value of the debounce prop (default of 20ms). |

### Input-Specific Slot Data

Additional slot data specific to the `multi-step` input:

| Property | Type | Description |
|----------|------|-------------|
| `steps` | `FormKitFrameworkContext[]` | Array of step node context objects. |
| `activeStep` | `string` | The name of the currently active step. |
| `allowIncomplete` | `boolean` | Whether users can navigate to later steps without completing current step. |
| `tabStyle` | `string` | The tab display style (tab or progress). |
| `validStepIcon` | `string` | Icon to show when a step is valid. |
| `fns` | `Record<string, (...args: any[]) => any>` | Utility functions for the multi-step input. |
| `fns.isActiveStep` | `(step: FormKitFrameworkContext) => boolean` | Returns true if the given step is currently active. |
| `fns.isFirstStep` | `(step: FormKitFrameworkContext) => boolean` | Returns true if the given step is the first step. |
| `fns.isLastStep` | `(step: FormKitFrameworkContext) => boolean` | Returns true if the given step is the last step. |
| `fns.isStepValid` | `(step: FormKitFrameworkContext) => boolean` | Returns true if the given step has no validation errors. |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the multi-step input. |
| `handlers.setActiveStep` | `(step: FormKitFrameworkContext) => void` | Sets the specified step as the active step. |
| `handlers.incrementStep` | `(delta: number) => () => void` | Returns a function that navigates by the specified delta (1 for next, -1 for previous). |
| `handlers.next` | `() => void` | Navigates to the next step. |
| `handlers.previous` | `() => void` | Navigates to the previous step. |
| `handlers.goTo` | `(step: number | string) => void` | Navigates to the specified step by index or name. |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |
| `step` | `tab`, `tabLabel`, `badge`, `step`, `stepInner`, `stepActions` | `FormKitFrameworkContext` | The current step context object when iterating. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```
- outer
  └─ wrapper
    └─ tabs
      └─ tab
        └─ tabLabel
        └─ badge
    └─ steps
      └─ step
        └─ stepInner
        └─ stepActions
          └─ stepPrevious
          └─ stepNext
```

### Section Keys Reference

| Section Key | Element | Description |
|-------------|---------|-------------|
| `outer` | `<div>` | The outermost wrapping element. |
| `wrapper` | `<label>` | A label element wrapping the inner section and label text. Clicking anywhere toggles the checkbox/radio. |
| `tabs` | `<div>` | A wrapper around all of the tabs. |
| `tab` | `<button>` | A button element for navigating to a step. |
| `tabLabel` | `<span>` | A span element containing the name of the tab. |
| `badge` | `<span>` | A span for showing current tab validity state (errors or valid). |
| `steps` | `<div>` | A wrapper around all steps. |
| `step` | `<div>` | A wrapper around step content and action buttons. |
| `stepInner` | `<div>` | A wrapper around the default slot content for a step. |
| `stepActions` | `<div>` | A wrapper around the action buttons for moving between steps. |
| `stepPrevious` | `<div>` | A wrapper around the button for navigating to the previous step. |
| `stepNext` | `<div>` | A wrapper around the button for navigating to the next step. |
