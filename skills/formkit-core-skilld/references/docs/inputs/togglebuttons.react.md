# Toggle Buttons

The toggle buttons are used to choose between one or more choices with a button aesthetic.

## Toggle Buttons

To output multiple toggle buttons use the `options` prop. Options can be specified 3 ways:

- An array of strings
- An object of value/label pairs
- An array of objects with `label` and `value` properties (the same as the [select](/inputs/select) and [radio](/inputs/radio) inputs).
- Additional parameters can be passed to set `disabled`, `help`, `onLabel`, and/or `offLabel` on a per option basis.

In React JSX props like <code>onValue</code>, <code>offValue</code>, <code>onLabel</code>, and <code>offLabel</code> use the standard prop casing for that framework.

### Example: Toggle Buttons Simple Options

#### togglebuttons-multiple-basic.react.jsx

```jsx
<FormKit
            type="togglebuttons"
            name="transportation"
            label="Travel Preference"
            options={['Car', 'Airplane', 'Train', 'Hoverboard']}
          />

          <FormKit
            type="togglebuttons"
            name="shirt_size"
            label="T-shirt Size"
            options={{
              sm: 'Small',
              md: 'Medium',
              lg: 'Large',
              xl: 'X-Large',
            }}
          />

          <FormKit
            type="togglebuttons"
            name="pizza_toppings"
            label="Pizza Toppings"
            options={[
              'Pepperoni',
              'Sausage',
              'Mushrooms',
              {
                value: 'Pineapple',
                label: 'Pineapple',
                disabled: true,
                help: "Sorry, pineapple doesn't belong on pizza",
              },
            ]}
          />
```

## Behavioral props

### Multiple

The `togglebuttons` input, by default, only allows one option to be selected. You can change this behavior by setting the `multiple` prop which will then allow the selection of multiple options:

### Example: Multiple

#### togglebuttons-multiple.react.jsx

```jsx
<FormKit
            type="togglebuttons"
            name="pizza_toppings"
            label="Pizza Toppings"
            options={['Pepperoni', 'Sausage', 'Mushroom', 'Olives']}
            multiple
          />
```

### Enforced

By default `togglebuttons` will allow you to select and deselect allowing for an off state. With the `enforced` prop enabled once a user has interacted with the input, one value will always be set much like that of a radio input.

### Example: Multiple

#### togglebuttons-single-enforced.react.jsx

```jsx
<FormKit
            type="togglebuttons"
            name="shirt_size"
            label="T-shirt Size"
            enforced
            options={['Small', 'Medium', 'Large', 'X-Large']}
          />
```

### Vertical

Assuming you are using the default FormKit styles, the `vertical` prop applies dataset attributes and styling to stack toggle buttons in a vertical orientation.

### Example: Vertical

#### togglebuttons-vertical.react.jsx

```jsx
<FormKit
        type="togglebuttons"
        name="pizza_toppings"
        label="Pizza Toppings"
        options={['Pepperoni', 'Sausage', 'Mushroom', 'Olives']}
        vertical
      />
```

More prop examples and combinations:

### Example: Toggle Buttons Multiple Enforced

#### togglebuttons-enforced.react.jsx

```jsx
<FormKit
            type="togglebuttons"
            name="shirt_size"
            label="T-shirt Size"
            options={['Small', 'Medium', 'Large', 'X-Large']}
            vertical={value?.orientation}
          />

          <FormKit
            type="togglebuttons"
            label="Size Toggle Orientation"
            name="orientation"
            enforced
            defaultValue={false}
            multiple={false}
            options={[
              { label: 'Horizontal', value: false },
              { label: 'Vertical', value: true },
            ]}
          />
```

## Standalone Toggle

### Standalone basic example

The `togglebuttons` input offers choices between one or more values; it's a great option when you want the user to toggle a feature on or off, between choices or allow multiple selections.

### Example: Single Toggle Button

#### togglebuttons-simple.react.jsx

```jsx
<FormKit type="togglebuttons" name="toggle" label="Toggle Me" />
```

### Standalone Toggle On/Off Values

The values for the toggle buttons are `undefined` if not-interacted with, `true` if checked, and `false` if unchecked. You can change these values by passing the `onValue` and `offValue` props. In this example, we will set the `onValue` to the string `'active'` and the `offValue` to the string `'inactive'`:

### Example: On / Off Values

#### togglebuttons-basic-values.react.jsx

```jsx
<FormKit
            type="togglebuttons"
            name="airplane_mode"
            label="Airplane mode"
            onValue="active"
            offValue="inactive"
          />
```

### Standalone On/Off labels

Additionally, you may specify secondary labels by setting the `on-label` and the `off-label` props. These values are conditionally shown based on the on/off state of the toggle. The value labels render to the right of the toggle input. The "primary label" will be moved to input label position above the toggle when value labels are used:

### Example: On / Off Labels

#### togglebuttons-value-labels.react.jsx

```jsx
<FormKit
            type="togglebuttons"
            name="mode"
            offLabel="Light Mode"
            onLabel="Dark Mode"
          />
```

## Slots

### Toggle Button Slots

For multiple options you can use the `default` slot to set the toggle's content.

In React this is usually implemented with a <code>default</code> entry on the <code>slots</code> prop.

### Example: Toggle Buttons Options Slot

#### togglebuttons-options-slots.react.jsx

```jsx
<FormKit
            type="togglebuttons"
            name="social_network"
            label="Preferred social network"
            options={['Facebook', 'Twitter', 'Instagram']}
            slots={{
              default: ({ option }) => (
                <div className="w-5 h-5">
                  <FormKitIcon icon={String(option.value).toLowerCase()} />
                </div>
              ),
            }}
          />
```

### Standalone Toggle Slots

For a single toggle you can use the default slot for setting the toggle content. Also available are `on` and `off` slots to change the content based on whether the toggle is activated or not.

In React this uses <code>default</code>, <code>on</code>, and <code>off</code> entries on the <code>slots</code> prop, or children for simple label content.

### Example: Toggle Buttons Default Slot

#### togglebuttons-single-slots.react.jsx

```jsx
<FormKit type="togglebuttons">Airplane mode</FormKit>

      <FormKit
        type="togglebuttons"
        slots={{
          on: () => (
            <>
              <span className="text-xl">&#9745;</span> Enabled
            </>
          ),
          off: () => (
            <>
              <span className="text-xl">&#9744;</span> Disabled
            </>
          ),
        }}
      />
```

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `off-value` | `any` | `false` | The value when the toggle is unchecked. For use with standalone toggle buttons only. |
| `on-value` | `any` | `true` | The value when the toggle is checked. For use with standalone toggle buttons only. |
| `off-label` | `String` | `undefined` | The text of the button label when the toggle is unchecked. For use with standalone toggle buttons only. |
| `on-label` | `String` | `undefined` | The text of the button label when the toggle is checked. For use with standalone toggle buttons only. |
| `options` | `Array/Object` | `[]` | An object of value/label pairs or an array of strings, or an array of objects that must contain a label and value property. Additional props include: disabled, help, onLabel and offLabel |
| `multiple` | `Boolean` | `false` | Allows for selecting multiple options. For use with multiple toggle buttons only. |
| `enforced` | `Boolean` | `false` | Makes sure at least one selection remains selected once field is activated. For use with multiple toggle buttons only. |
| `vertical` | `Boolean` | `false` | Applies data attributes and styling to stack toggle buttons in a vertical orientation. For use with multiple toggle buttons only. |

## Sections & slot data

The toggle buttons input has a different construction depending on if it's a single or multiple configuration.

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

Additional slot data specific to the `togglebuttons` input:

| Property | Type | Description |
|----------|------|-------------|
| `options` | `FormKitOptionsList` | Array of option objects for multi-select mode. |
| `onLabel` | `string` | Label for the on state (single toggle). |
| `offLabel` | `string` | Label for the off state (single toggle). |
| `fns` | `Record<string, (...args: any[]) => any>` | Utility functions for the togglebuttons input. |
| `fns.isChecked` | `(option: FormKitOptionsProp) => boolean` | Returns true if the given option is currently selected. |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |
| `option` | `option`, `multiToggle`, `buttonInput` | `FormKitOptionsProp` | The current option object when iterating (multi-select mode). |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```

#### Single toggle button
A single toggle button without options.
- outer
  └─ wrapper
    └─ singleToggle
      └─ prefixIcon
      └─ prefix
      └─ buttonInput
      └─ suffix
      └─ suffixIcon
  └─ help
  └─ messages
    └─ message

#### Multiple toggle buttons
Toggle buttons with multiple options.
- outer
  └─ wrapper
    └─ label
    └─ options
      └─ option
        └─ multiToggle
          └─ buttonInput
  └─ help
  └─ messages
    └─ message
```

### Section Keys Reference

| Section Key | Element | Description |
|-------------|---------|-------------|
| `outer` | `<div>` | The outermost wrapping element. |
| `wrapper` | `<label>` | A label element wrapping the inner section and label text. Clicking anywhere toggles the checkbox/radio. |
| `singleToggle` | `<button>` | Container for a single toggle button. |
| `prefixIcon` | `<label>` | An element for outputting an icon before the prefix section. |
| `prefix` | (none) | Has no output by default, but allows content directly before an input element. |
| `buttonInput` | `<span>` | The actual button element containing the label. |
| `suffix` | (none) | Has no output by default, but allows content directly after an input element. |
| `suffixIcon` | `<span>` | An element for outputting an icon after the suffix section. |
| `help` | `<div>` | The element containing help text. |
| `messages` | `<ul>` | A wrapper around all the messages. |
| `message` | `<li>` | The element (or many elements) containing a message — most often validation and error messages. |
| `label` | `<span>` | A span containing the label text beside the checkbox/radio. |
| `options` | `<div>` | Container wrapping all toggle button options. |
| `option` | `<div>` | Wrapper for each individual toggle button option. |
| `multiToggle` | `<button>` | Container for a toggle button in multi-select mode. |

## Accessibility

All FormKit inputs are designed with the following accessibility considerations in mind. Help us continually improve accessibility for all by filing accessibility issues here:

- ✓ Semantic markup
- ✓ ARIA attributes
- ✓ Keyboard accessibility
- ✓ Focus indicators
- ✓ Color contrast with the provided theme
- ✓ Accessible labels, help text, and errors

### Accessibility attributes

### Single toggle button

| Section | Attribute | Value | Description |
|---------|-----------|-------|-------------|
| `singleToggle` | `aria-label` | `-` | Provides an accessible name. |
| `singleToggle` | `aria-pressed` | `-` | Indicates the pressed state of toggle button. |
| `singleToggle` | `role` | `checkbox` | Indicates to assistive technologies that this element functions as a checkbox. |

### Multiple toggle buttons

| Section | Attribute | Value | Description |
|---------|-----------|-------|-------------|
| `multiToggle` | `aria-label` | `-` | Provides an accessible name. |
| `multiToggle` | `aria-pressed` | `-` | Indicates the pressed state of toggle button. |
| `multiToggle` | `role` | `checkbox or radio` | Indicates to assistive technologies that this element functions as a checkbox if has options or radio if not. |
| `options` | `role` | `group` | Indicates to assistive technologies that this element functions as a group. |
| `options` | `aria-labelledby` | `-` | Associates this element as a label for the input. |
| `option` | `role` | `listitem` | Indicates to assistive technologies that this element functions as listitem. |

### Keyboard Interactions

| Key | Description |
|-----|-------------|
| `space` | Changes the state of the currently focused toggle button. |
