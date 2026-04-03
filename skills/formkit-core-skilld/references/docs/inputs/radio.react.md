# Radio Input

A native HTML radio input with support for one or many nested options elements.

The `radio` input uses HTML's native radio inputs to allow a user to select one value from a series of options. The `options` prop is required for radio inputs and can be provided in 3 ways:

- An array of strings
- An object of value/label pairs
- An array of objects with `label` and `value` properties (the same as the [checkbox](/inputs/checkbox) and [select](/inputs/select) inputs)

In React JSX props like <code>decoratorIcon</code> follow the usual prop casing for that framework.

### Array of strings

The simplest way to provide options is an array of strings. The provided strings will be used for both the label and the value of the option.

### Example: Radio input

#### radio-strings.react.jsx

```jsx
<FormKit
        modelValue={value}
        onUpdateModelValue={setValue}
        type="radio"
        label="Preferred transportation"
        options={[
          'E-Bike',
          'E-Scooter',
          'Electric car',
          'Walking',
          'Space tube',
        ]}
        help="How do you like to get around?"
      />
      <pre>{value}</pre>
```

### Value / Label object

You may also provide the `options` prop where the keys are values and the values of each property are labels.

### Example: Radio input

#### radio-object.react.jsx

```jsx
<FormKit
        modelValue={value}
        onUpdateModelValue={setValue}
        type="radio"
        label="Stuffed animal"
        options={{
          teddy: 'Bear',
          lama: 'Lama',
          lizard: 'Lizard',
          giraffe: 'Giraffe',
        }}
        help="What is your favorite stuffed animal?"
      />
      <pre>{value}</pre>
```

### Array of objects

The most flexible way to define options is by providing an array of objects. The objects *must* include `value` and `label` properties — but may also include a `help` property as well as an `attrs` object of additional attributes to apply to each radio input tag.

### Example: Radio input

#### radio-objects.react.jsx

```jsx
<FormKit
        modelValue={value}
        onUpdateModelValue={setValue}
        type="radio"
        label="Best movie"
        options={[
          { label: 'Shawshank redemption', value: 'shawshank' },
          { label: 'The Godfather', value: 'godfather' },
          {
            label: 'Casablanca (too old)',
            value: 'casablanca',
            attrs: { disabled: true },
          },
          { label: 'The Lord of the Rings', value: 'lotr' },
          { label: 'Saving Private Ryan', value: 'saving-ryan' },
        ]}
        help="What is the best movie of all time?"
      />
      <pre>{value}</pre>
```

> **Tip:** If you have multiple radio inputs with the same name spread across different parts of your template, you may need to use the `mergeStrategy` config option on a parent node to keep their values synchronized. See [Syncing multiple nodes with the same name](/essentials/architecture#syncing-multiple-nodes-with-the-same-name) in the architecture documentation.

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `decorator-icon` | `String` | `’’` | Specifies an icon to put in the decoratorIcon section. Shows when the radio is checked. Defaults to the radioDecorator icon. |
| `options` | `Array/Object` | `[]` | An object of value/label pairs or an array of strings, or an array of objects that must contain a label and value property. |

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

Additional slot data specific to the `radio` input:

| Property | Type | Description |
|----------|------|-------------|
| `options` | `FormKitOptionsList` | An array of option objects. Each contains value, label, and optional attrs/help properties. |
| `fns` | `Record<string, (...args: any[]) => any>` | Utility functions for the radio input. |
| `fns.isChecked` | `(value: any) => boolean` | Returns true if the given value is currently selected. |
| `fns.eq` | `(a: any, b: any) => boolean` | Returns true if two values are equal (for single radio checked state). |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the radio input. |
| `handlers.toggleChecked` | `(e: Event) => void` | Sets the value when the radio is selected. |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |
| `option` | `option`, `wrapper`, `inner`, `label`, `optionHelp` | `FormKitOptionsProp` | The current option object when iterating. Contains value, label, attrs, and help. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```
- outer
  └─ fieldset
    └─ legend
    └─ help
    └─ options
      └─ option
        └─ wrapper
          └─ inner
            └─ prefix
            └─ input
            └─ decorator
              └─ decoratorIcon
            └─ suffix
          └─ label
        └─ optionHelp
  └─ messages
    └─ message
```

### Section Keys Reference

| Section Key | Element | Description |
|-------------|---------|-------------|
| `outer` | `<div>` | The outermost wrapping element. |
| `fieldset` | `<fieldset>` | A fieldset element that acts as the root element. |
| `legend` | `<legend>` | A legend element that renders the label. |
| `help` | `<div>` | The element containing help text. |
| `options` | `<div>` | Container wrapping all toggle button options. |
| `option` | `<div>` | Wrapper for each individual toggle button option. |
| `wrapper` | `<label>` | A label element wrapping the inner section and label text. Clicking anywhere toggles the checkbox/radio. |
| `inner` | `<span>` | A span wrapping the input, decorator, prefix, and suffix sections. |
| `prefix` | (none) | Has no output by default, but allows content directly before an input element. |
| `input` | `<select>` | The native HTML select element. |
| `decorator` | `<span>` | A span element that provides a styleable visual indicator (checkbox square or radio circle). |
| `decoratorIcon` | `<span>` | An icon inside the decorator, typically a checkmark or dot for selected state. |
| `suffix` | (none) | Has no output by default, but allows content directly after an input element. |
| `label` | `<span>` | A span containing the label text beside the checkbox/radio. |
| `optionHelp` | `<div>` | Help text displayed below an individual option (when option has help property). |
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
| `fieldset` | `aria-describedby` | `-` | Associates an element with a description, aiding screen readers. |
| `decorator` | `aria-hidden` | `true` | Hides the decorator from screen readers. |

### Keyboard Interactions

| Key | Description |
|-----|-------------|
| `space` | Selects the currently focused radio input. |
