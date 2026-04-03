# Datetime-local Input

A native HTML datetime-local picker.

The `datetime-local` input uses HTML's native datetime-local picker to allow users to easily select a date and time based on their browser’s locale.

When controlling this input in React, prefer `modelValue` and `onUpdateModelValue` instead of wiring directly to the native input element.

> **Tip:** Need more flexibility than the native HTML `datetime-local` input provides? [Check out the datepicker input](/inputs/datepicker) available in FormKit Pro.

## Basic example

### Example: Datetime-local input

#### datetime-local-example.react.jsx

```jsx
<FormKit
        type="datetime-local"
        value="2020-03-13T18:22"
        label="End of the world"
        help="When will the end of the world take place?"
        validation="required|date_after"
        validationVisibility="live"
      />
```

> **Warning:** The internal format of all native datetime-local pickers is `YYYY-MM-DDTHH:MM`. This is true even though the format of the datetime-local displayed to the user may be different. For example U.S. based browsers display datetime-local format as `MM/DD/YYYY, HH:MM AM/PM`.

## Props & Attributes

The `datetime-local` input has no unique props but can make use of the following universal FormKit props.

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `config` | `Object` | `{}` | Configuration options to provide to the <a href= |
| `delay` | `Number` | `20` | Number of milliseconds to debounce an input’s value before the commit <a href= |
| `dirtyBehavior` | `string` | `touched` | Determines how the |
| `errors` | `Array` | `[]` | Array of strings to show as error messages on this field. |
| `help` | `String` | `-` | Text for help text associated with the input. |
| `id` | `String` | `input_{n}` | The unique id of the input. Providing an id also allows the input’s node to be globally accessed. |
| `ignore` | `Boolean` | `false` | Prevents an input from being included in any parent (group, list, form etc). Useful when using inputs for UI instead of actual values. |
| `index` | `Number` | `undefined` | Allows an input to be inserted at the given index if the parent is a list. If the input’s value is undefined, it inherits the value from that index position. If it has a value it inserts it into the lists’s values at the given index. |
| `label` | `String` | `-` | Text for the label element associated with the input. |
| `name` | `String` | `input_{n}` | The name of the input as identified in the data object. This should be unique within a group of fields. |
| `parent` | `FormKitNode` | `contextual` | By default the parent is a wrapping group, list or form — but this props allows explicit assignment of the parent node. |
| `prefix-icon` | `String` | `-` | Specifies <a href= |
| `preserve` | `Boolean` | `false` | Preserves the value of the input on a parent group, list, or form when the input unmounts. |
| `preserve-errors` | `Boolean` | `false` | By default errors set on inputs using setErrors are automatically cleared on input, setting this prop to true maintains the error until it is explicitly cleared. |
| `sections-schema` | `Object` | `{}` | An object of section keys and schema partial values, where each schema partial is applied to the respective section. |
| `suffix-icon` | `String` | `-` | Specifies <a href= |
| `type` | `String` | `text` | The type of input to render from the library. |
| `validation` | `String, Array` | `[]` | The <a href= |
| `validation-visibility` | `String` | `blur` | Determines when to show an input |
| `validation-label` | `String` | `{label prop}` | Determines what label to use in validation error messages, by default it uses the label prop if available, otherwise it uses the name prop. |
| `validation-rules` | `Object` | `{}` | Additional custom validation rules to make available to the validation prop. |
| `value` | `Any` | `undefined` | Seeds the initial value of an input and/or its children. Not reactive. Can seed <a href= |

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

Additional slot data specific to the `datetime-local` input:

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
| `enter` | Opens the browser datetime picker panel when input is focused. Confirms datetime selection when date picker is focused. |
| `space` | Opens the browser datetime picker panel when input is focused. |
| `esc` | Closes the browser datetime picker panel. |
| `up` + `down` + `left` + `right` | Adjusts selection of UI elements in browser datetime picker panel. |
