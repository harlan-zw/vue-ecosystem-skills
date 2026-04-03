# Checkbox Input

A native HTML checkbox input with support for one or many nested options elements.

The `checkbox` input uses HTML's native checkbox input. It can display one or many options to a user and is a great way to allow users to select multiple items from a list. FormKit supports both single and multiple checkbox inputs.

In React JSX props like <code>onValue</code>, <code>offValue</code>, and <code>decoratorIcon</code> use the standard prop casing for that framework.

## Single checkbox

By default the checkbox type will render a single checkbox and uses `boolean` values. In order for a single checkbox to be checked — the current value of the input must match the `on-value` of that input (by default, a single checkbox uses `true` as the `on-value`).

### Example: Checkbox input

#### checkbox-single.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="checkbox"
              label="Terms and Conditions"
              help="Do you agree to our terms of service?"
              name="terms"
              value={true}
              validation="accepted"
              validationVisibility="dirty"
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

> **Warning:** In order to improve API consistency across all FormKit inputs — FormKit uses the `value` as the initial state of the input. The `checked` prop/attribute should not be used directly.

## Multiple checkboxes

To output multiple checkboxes with a single input use the `options` prop. Options can be specified 3 ways:

- An array of strings
- An object of value/label pairs
- An array of objects with `label` and `value` properties (the same as the [select](/inputs/select) and [radio](/inputs/radio) inputs)

The value of a checkbox input with multiple `options` is an array of the selected values.

### Array of strings

The simplest way to provide options is an array of strings. The provided strings will be used for both the label and the value of the option.

### Example: Checkbox input

#### checkbox-strings.react.jsx

```jsx
<FormKit
        modelValue={value}
        onUpdateModelValue={setValue}
        type="checkbox"
        label="Toppings"
        options={['Mushrooms', 'Olives', 'Salami', 'Anchovies']}
        decoratorIcon="happy"
        help="Select your pizza toppings"
        validation="required|min:3"
      />
      <pre>{JSON.stringify(value, null, 2)}</pre>
```

### Value / Label object

You may also provide the `options` prop where the keys are values and the values of each property are labels.

### Example: Checkbox input

#### checkbox-object.react.jsx

```jsx
<FormKit
        modelValue={value}
        onUpdateModelValue={setValue}
        type="checkbox"
        label="Trim extras"
        options={{
          650: 'Leather seats ($650)',
          1200: 'Sweet rims ($1,200)',
          13250: 'Gold leaf ($13,250)',
          500: 'Massaging seats ($500)',
        }}
        help="Configure your car's trim options"
      />
      <pre>{`Extra cost: $${sum}`}</pre>
```

### Array of objects

The most flexible way to define options is by providing an array of objects. The objects *must* include `value` and `label` properties — but may also include a `help` property as well as an `attrs` object of additional attributes to apply to each checkbox input tag.

### Example: Checkbox input

#### checkbox-objects.react.jsx

```jsx
<FormKit
        type="checkbox"
        value={[]}
        label="Indian food"
        options={[
          {
            value: 'item-2',
            label: 'Bhajji',
            help: 'Fried chickpea batter - spicy.',
          },
          {
            value: 'item-55',
            label: 'Vada Pav (out of stock)',
            help: 'Fried vegetarian dumplings.',
            attrs: { disabled: true },
          },
          {
            value: 'item-22',
            label: 'Paratha',
            help: 'Flatbread layered and pan friend.',
          },
          {
            value: 'item-44',
            label: 'Halwa',
            help: 'Pudding made with flour.',
          },
        ]}
        help="Select your favorite Indian dishes."
      />
```

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `decorator-icon` | `String` | `’’` | Specifies an icon to put in the decoratorIcon section. Shows when the checkbox is checked. Defaults to the checkboxDecorator icon. |
| `options` | `Array/Object` | `[]` | An object of value/label pairs or an array of strings, or an array of objects that must contain a label and value property. |
| `on-value` | `any` | `true` | The value when the checkbox is checked (single checkboxes only). |
| `off-value` | `any` | `false` | The value when the checkbox is unchecked (single checkboxes only). |

## Sections

The checkbox input has a different construction depending on if it's a single or multiple checkbox.

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

Additional slot data specific to the `checkbox` input:

| Property | Type | Description |
|----------|------|-------------|
| `options` | `FormKitOptionsList` | An array of option objects. Each contains value, label, and optional attrs/help properties. |
| `onValue` | `any` | The value to set when the checkbox is checked. Defaults to true. |
| `offValue` | `any` | The value to set when the checkbox is unchecked. Defaults to undefined. |
| `fns` | `Record<string, (...args: any[]) => any>` | Utility functions for the checkbox input. |
| `fns.isChecked` | `(value: any) => boolean` | Returns true if the given value is currently selected (for multi-checkbox). |
| `fns.eq` | `(a: any, b: any) => boolean` | Returns true if two values are equal (for single checkbox checked state). |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the checkbox input. |
| `handlers.toggleChecked` | `(e: Event) => void` | Toggles the checked state of the checkbox. |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |
| `option` | `option`, `wrapper`, `inner`, `label`, `optionHelp` | `FormKitOptionsProp` | The current option object when iterating. Contains value, label, attrs, and help. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```

#### Single checkbox
When no options prop is provided, a single checkbox is rendered with a label beside it.
- outer
  └─ wrapper
    └─ inner
      └─ prefix
      └─ input
      └─ decorator
        └─ decoratorIcon
      └─ suffix
    └─ label
  └─ help
  └─ messages
    └─ message

#### Multiple checkboxes
When an options prop is provided, multiple checkboxes are rendered inside a fieldset.
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
| `wrapper` | `<label>` | A label element wrapping the inner section and label text. Clicking anywhere toggles the checkbox/radio. |
| `inner` | `<span>` | A span wrapping the input, decorator, prefix, and suffix sections. |
| `prefix` | (none) | Has no output by default, but allows content directly before an input element. |
| `input` | `<select>` | The native HTML select element. |
| `decorator` | `<span>` | A span element that provides a styleable visual indicator (checkbox square or radio circle). |
| `decoratorIcon` | `<span>` | An icon inside the decorator, typically a checkmark or dot for selected state. |
| `suffix` | (none) | Has no output by default, but allows content directly after an input element. |
| `label` | `<span>` | A span containing the label text beside the checkbox/radio. |
| `help` | `<div>` | The element containing help text. |
| `messages` | `<ul>` | A wrapper around all the messages. |
| `message` | `<li>` | The element (or many elements) containing a message — most often validation and error messages. |
| `fieldset` | `<fieldset>` | A fieldset element that acts as the root element. |
| `legend` | `<legend>` | A legend element that renders the label. |
| `options` | `<div>` | Container wrapping all toggle button options. |
| `option` | `<div>` | Wrapper for each individual toggle button option. |
| `optionHelp` | `<div>` | Help text displayed below an individual option (when option has help property). |

## Accessibility

All FormKit inputs are designed with the following accessibility considerations in mind. Help us continually improve accessibility for all by filing accessibility issues here:

- ✓ Semantic markup
- ✓ ARIA attributes
- ✓ Keyboard accessibility
- ✓ Focus indicators
- ✓ Color contrast with the provided theme
- ✓ Accessible labels, help text, and errors

### Single checkbox accessibility attributes

| Section | Attribute | Value | Description |
|---------|-----------|-------|-------------|
| `decorator` | `aria-hidden` | `true` | Hides the decorator from screen readers. |

### Multiple checkbox accessibility attributes

| Section | Attribute | Value | Description |
|---------|-----------|-------|-------------|
| `fieldset` | `aria-describedby` | `-` | Associates an element with a description, aiding screen readers. |
| `decorator` | `aria-hidden` | `true` | Hides the decorator from screen readers. |

### Keyboard Interactions

| Key | Description |
|-----|-------------|
| `space` | Toggles the checked state of the currently focused input. |
