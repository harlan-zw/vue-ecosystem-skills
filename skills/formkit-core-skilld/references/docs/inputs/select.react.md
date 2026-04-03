# Select Input

A native HTML select input. Supports both single-value and multi-value selections.

The select input uses HTML's native select input. Select inputs can be single value selections, or multi-value selections by using the `multiple` attribute. There are 4 ways to provide options to a select input:

- An array of strings
- An object of value/label pairs
- An array of objects with `label` and `value` properties (the same as the [checkbox](/inputs/checkbox) and [radio](/inputs/radio) inputs)
- Using `<option>` tags directly inside the `default` slot.

In React JSX props like <code>selectIcon</code> follow the usual prop casing for that framework. When controlling the input in React, prefer `modelValue` and `onUpdateModelValue` as shown in the paired examples.

> **Tip:** Need more flexibility than the native HTML `select` input provides? [Check out the dropdown input](/inputs/dropdown) available in FormKit Pro.

## Single selection

Select lists are most commonly used to select a single item from a list of options.

### Array of strings

The simplest way to provide options is an array of strings. The provided strings will be used for both the label and the value of the option.

### Example: Select input - strings

#### select-strings.react.jsx

```jsx
<FormKit
        type="select"
        label="Which country is the smallest?"
        name="small_country"
        options={['Monaco', 'Vatican City', 'Maldives', 'Tuvalu']}
      />
```

### Value / Label object

You may also provide the `options` prop where the keys are values and the values of each property are labels.

### Example: Select input

#### select.react.jsx

```jsx
<FormKit
        type="select"
        label="What planet is the largest?"
        placeholder="Select a planet"
        name="planet"
        options={{
          mercury: 'Mercury',
          venus: 'Venus',
          earth: 'Earth',
          mars: 'Mars',
          jupiter: 'Jupiter',
          saturn: 'Saturn',
          uranus: 'Uranus',
          neptune: 'Neptune',
        }}
        validation="required|is:jupiter"
        validationVisibility="dirty"
        validationMessages={{
          is: 'Nope! Jupiter is the largest planet',
        }}
      />
```

### Array of objects

The most flexible way to define options is by providing an array of objects. The objects *must* include `value` and `label` properties — but may also include a `help` property as well as an `attrs` object of additional attributes to apply to each select input tag.

### Example: Select input - objects

#### select-objects.react.jsx

```jsx
<FormKit
        type="select"
        label="What country makes the best food?"
        name="country"
        placeholder="Select a country"
        options={[
          { label: 'France', value: 'fr', attrs: { disabled: true } },
          { label: 'Germany', value: 'de', attrs: { disabled: true } },
          { label: 'Spain', value: 'es', attrs: { disabled: true } },
          { label: 'Italy', value: 'ie' },
          { label: 'Greece', value: 'gr', attrs: { disabled: true } },
        ]}
        help="Don't worry, you can't get this one wrong."
      />
```

> **Tip:** To pass additional attributes to each `<option>` element, your object can also contain an `attrs` property.


```
[
  {
    label: 'My Label',
    value: 'a-value',
    attrs: {
      disabled: true
    }
  }
]

```

### Option groups (optgroup)

Using the [array of objects](#array-of-objects) syntax you can also create option groups (`<optgroup>` in HTML). To do so provide a `group` option:

### Example: Option groups

#### select-groups.react.jsx

```jsx
<FormKit
        type="select"
        label="Letters or numbers"
        options={[
          {
            group: 'Letters',
            options: ['A', 'B', 'C'],
          },
          {
            group: 'Numbers',
            options: [1, 2, 3],
          },
        ]}
      />
```

### Default slot

Sometimes it may be desirable to manually output the contents of a select list in order to create specialized structures. This can be done by using the `default` slot to explicitly output your options.

In React this means passing <code><option></code> and <code><optgroup></code> children directly to <code><FormKit /></code>.

### Example: Select input - objects

#### select-slot.react.jsx

```jsx
<FormKit
        type="select"
        label="Where would you prefer to live?"
        name="planet"
        modelValue={value}
        onUpdateModelValue={setValue}
      >
        <optgroup label="Inner Planets">
          <option value="mercury">Mercury</option>
          <option value="venus">Venus</option>
          <option value="earth">Earth</option>
          <option value="mars">Mars</option>
        </optgroup>
        <optgroup label="Outer planets">
          <option value="jupiter">Jupiter</option>
          <option value="saturn">Saturn</option>
          <option value="uranus">Uranus</option>
          <option value="neptune">Neptune</option>
        </optgroup>
      </FormKit>
      <pre>{value}</pre>
```

> **Warning:** When using the default slot to output options, you should not use the `placeholder` or `options` props.

## Multiple

The `select` input also supports a `multiple` attribute that allows for multi-selection. When used with FormKit, this option produces an array of values.

### Example: Select input - objects

#### select-multiple.react.jsx

```jsx
<FormKit
        modelValue={values}
        onUpdateModelValue={setValues}
        type="select"
        multiple
        label="Serious medical conditions"
        name="medical_conditions"
        options={[
          { label: 'Outie belly button', value: 'outie' },
          { label: 'Large feet', value: 'lg-feet' },
          { label: 'Neck beard', value: 'neard' },
          { label: 'Tiny hands', value: 'trump-hands' },
        ]}
        help="Select all that apply by holding command (macOS) or control (PC)."
      />
      <pre>{JSON.stringify(values, null, 2)}</pre>
```

> **Tip:** Select inputs with the `multiple` attribute can be challenging for some users because they require holding-down the control or command keys to perform multiple selections. Depending on your audience, you may want to consider using a [checkbox input with options](/inputs/checkbox) instead.

> **Warning:** When using the default slot in conjunction with the `multiple` attribute you must explicitly assign the `selected` attribute to each option.

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `options` | `Array/Object` | `[]` | An object of value/label pairs or an array of strings, or an array of objects that must contain a label and value property. |
| `placeholder` | `String` | `none` | When defined, FormKit injects a non-selectable hidden option tag as the first value of the list to serve as a placeholder. |
| `select-icon` | `String` | `’’` | Specifies an icon to put in the selectIcon section. Defaults to the select icon. |

## Sections & slot data

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

Additional slot data specific to the `select` input:

| Property | Type | Description |
|----------|------|-------------|
| `options` | `FormKitOptionsList` | An array of option objects. Each contains value, label, and optional attrs/group properties. |
| `placeholder` | `string` | Placeholder text shown when no option is selected. |
| `fns` | `Record<string, (...args: any[]) => any>` | Utility functions for the select input. |
| `fns.isSelected` | `(option: FormKitOptionsProp) => boolean` | Returns true if the given option is currently selected. |
| `fns.showPlaceholder` | `(value: any, placeholder: string) => string | undefined` | Returns the placeholder if no value is selected, otherwise undefined. |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the select input. |
| `handlers.onChange` | `(e: Event) => void` | Handles the change event when selection changes. |
| `handlers.selectInput` | `(e: Event) => void` | Handles the input event on the select. |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |
| `option` | `option`, `optGroup` | `FormKitOptionsProp` | The current option object when iterating. Contains value, label, attrs, and optionally group. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```

#### Default
A native HTML select element with options rendered inside.
- outer
  └─ wrapper
    └─ label
    └─ inner
      └─ prefixIcon
      └─ prefix
      └─ input
        └─ option
      └─ selectIcon
      └─ suffix
      └─ suffixIcon
  └─ help
  └─ messages
    └─ message

#### With option groups
When options have a group property, they are rendered inside optgroup elements.
- outer
  └─ wrapper
    └─ label
    └─ inner
      └─ prefixIcon
      └─ prefix
      └─ input
        └─ optGroup
          └─ option
      └─ selectIcon
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
| `wrapper` | `<label>` | A label element wrapping the inner section and label text. Clicking anywhere toggles the checkbox/radio. |
| `label` | `<span>` | A span containing the label text beside the checkbox/radio. |
| `inner` | `<span>` | A span wrapping the input, decorator, prefix, and suffix sections. |
| `prefixIcon` | `<label>` | An element for outputting an icon before the prefix section. |
| `prefix` | (none) | Has no output by default, but allows content directly before an input element. |
| `input` | `<select>` | The native HTML select element. |
| `option` | `<div>` | Wrapper for each individual toggle button option. |
| `selectIcon` | `<span>` | An icon displayed beside the select (typically a dropdown caret). |
| `suffix` | (none) | Has no output by default, but allows content directly after an input element. |
| `suffixIcon` | `<span>` | An element for outputting an icon after the suffix section. |
| `help` | `<div>` | The element containing help text. |
| `messages` | `<ul>` | A wrapper around all the messages. |
| `message` | `<li>` | The element (or many elements) containing a message — most often validation and error messages. |
| `optGroup` | `<optgroup>` | An optgroup element that groups related options with a label. |

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
| `space` | Opens the select options when the input is focused. Selects an item when an option is focused |
| `esc` | Closes the select options when the input is focused. |
| `up` | Opens the listbox when input is focused. Navigates to previous option in select options. |
| `down` | Opens the listbox when input is focused. Navigates to next option in select options. |
