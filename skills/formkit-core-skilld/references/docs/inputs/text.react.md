# Text Input

A native HTML text input.

The `text` input uses HTML's native text input. It allows a user to enter a single line of text.

When controlling this input in React, prefer `modelValue` and `onUpdateModelValue` instead of wiring directly to the native input element.

## Basic example

### Example: Text input

#### text.react.jsx

```jsx
<FormKit
        type="text"
        label="Your username"
        value="calypso"
        help="Pick a username people will remember!"
      />
```

## Cast to number

By default all native HTML `<input>` elements return a string value. The `number` prop allows you to cast the value to a true `number` type. There are two valid values for the `number` prop: `float` and `integer`.

These options use `parseFloat` (default) or `parseInt` respectively. If the value cannot be parsed by the respective function it will fall back to using the string value. Applying the `number` prop will expand the `value` of the input to be `number | string | undefined` in TypeScript.

### Example: Range cast input

#### text-cast.react.jsx

```jsx
<FormKit
            type="text"
            label="Atmospheric pressure"
            number
            name="pressure"
            help="My value will be a number if it can be parsed by parseFloat"
            value="29.82"
          />
          <pre>{JSON.stringify(value, null, 2)}</pre>
```

## Props & Attributes

The `text` input has only one unique prop, `number`, which can be used to cast the value of the input to a `number` type. Additionally, the native HTML `text` input has a few attributes that can be used to control the input.

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `number` | `String` | `float` | Specifies how to cast a value to a number. Valid values are float and integer. |

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

Additional slot data specific to the `text` input:

| Property | Type | Description |
|----------|------|-------------|
| `_value` | `string` |  |
| `value` | `string` |  |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```
- outer
  └─ wrapper
    └─ label
    └─ inner
      └─ prefixIcon
      └─ prefix
      └─ input
      └─ suffix
      └─ suffixIcon
    └─ help
    └─ messages
      └─ message
```

### Section Keys Reference

| Section Key | Element | Description |
|-------------|---------|-------------|
| `outer` | `<div>` | The outermost wrapping element. |
| `wrapper` | `<label>` | A wrapper around the label and input. |
| `label` | `<span>` | The label of the input. |
| `prefix` | (none) | Has no output by default, but allows content directly before an input element. |
| `prefixIcon` | `<label>` | An element for outputting an icon before the prefix section. |
| `inner` | `<span>` | A wrapper around the actual input element. |
| `suffix` | (none) | Has no output by default, but allows content directly after an input element. |
| `suffixIcon` | `<span>` | An element for outputting an icon after the suffix section. |
| `input` | `<select>` | The input element itself. |
| `help` | `<div>` | The element containing help text. |
| `messages` | `<ul>` | A wrapper around all the messages. |
| `message` | `<li>` | The element (or many elements) containing a message — most often validation and error messages. |

## Accessibility

All FormKit inputs are designed with the following accessibility considerations in mind. Help us continually improve accessibility for all by filing accessibility issues here:

- ✓ Semantic markup
- ✓ ARIA attributes
- ✓ Keyboard accessibility
- ✓ Focus indicators
- ✓ Color contrast with the provided theme
- ✓ Accessible labels, help text, and errors

### Accessibility attributes

| Section | Attribute | Value | Description |
|---------|-----------|-------|-------------|
| `label` | `for` | `-` | Associates a label to an input element. Users can click on the label to focus the input or to toggle between states. |
| `input` | `disabled` | `-` | Disables an HTML element, preventing user interaction and signaling a non-interactive state. |
| `input` | `aria-describedby` | `-` | Associates an element with a description, aiding screen readers. |
| `input` | `aria-required` | `true` | Added when input validation is set to required. |
| `icon` | `for` | `-` | Links icon to input element when icon in rendered as a label. |

### Keyboard Interactions

| Key | Description |
|-----|-------------|
| `tab` | Moves the focus to the next focusable element on the page. |
| `shift` + `tab` | Moves the focus to the previous focusable element on the page. |
