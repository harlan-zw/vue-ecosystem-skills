# Toggle Input

The toggle input is used to choose one of two values; it is a good choice when you want the user to make a binary choice such as turning a feature on or off.

## Basic example

The `toggle` input — sometimes called a "switch" — offers a choice between one of two values; it's a great option when you want the user to toggle a feature on or off:

In React JSX props like <code>altLabelPosition</code>, <code>onValue</code>, <code>offValue</code>, <code>onValueLabel</code>, <code>offValueLabel</code>, and <code>thumbIcon</code> use the standard prop casing for that framework.

### Example: Toggle

#### toggle-base.react.jsx

```jsx
<FormKit type="toggle" name="toggle" label="Airplane mode" />
```

## Values

The values for the toggle are `undefined` if not-interacted with, `true` if checked, and `false` if unchecked. You can change these values by passing the `onValue` and `offValue` props. In this example, we will set the `onValue` to the string `'active'` and the `offValue` to the string `'inactive'`:

### Example: Toggle

#### toggle-values.react.jsx

```jsx
<FormKit
            type="toggle"
            name="toggle"
            onValue="active"
            offValue="inactive"
          />
```

## Labels

### Primary label

By default, the toggle input supports a primary label like the `label` prop on any other FormKit input. The primary label is displayed to the right of the toggle unless you use a `Value label`, which will then move it above the toggle:

### Example: Toggle

#### toggle-primary-label.react.jsx

```jsx
<FormKit label="Primary Label" type="toggle" />
```

### Alt label position

If you would like the label to be displayed above the toggle, you can use the `alt-label-position` prop:

### Example: Toggle

#### toggle-alt-label-position.react.jsx

```jsx
<FormKit label="Alt label position" type="toggle" altLabelPosition />
```

### Value label

Additionally, you may specify secondary labels by setting the `on-value-label` and the `off-value-label` props. These values are conditionally shown based on the on/off state of the toggle. The value labels render to the right of the toggle input. The "primary label" will be moved to the alternative label position above the toggle when value labels are used:

### Example: Toggle

#### toggle-value-labels.react.jsx

```jsx
<FormKit
        label="Primary Label"
        type="toggle"
        offValueLabel="Off value label"
        onValueLabel="On value label"
      />
```

### Inner value labels

Additionally, you can set the `value-label-display` prop to `inner` to render the value labels inside the toggle. The `Primary label` will return to being displayed to the right of the toggle:

### Example: Toggle

#### toggle-labels-inner.react.jsx

```jsx
<FormKit
        label="Primary Label"
        type="toggle"
        labelPosition="secondary"
        offValueLabel="OFF"
        onValueLabel="ON"
        valueLabelDisplay="inner"
      />
```

## Icons

The `thumb-icon` prop allows you to insert an icon into the `thumb` section of the `toggle` input. This prop accepts a string that's passed to FormKit's [icon plugin](/essentials/icons):

### Example: Toggle

#### toggle-icon.react.jsx

```jsx
<FormKit type="toggle" thumbIcon="star" />
```

## Colors

The toggle input supports color props for its various sections for easy styling. Each prop contains on and off states that are applied depending on whether the toggle is on or off. The following example uses some of these color props. See the [Props & Attributes](#props--attributes) section below for a full list of these props:

### Example: Toggle

#### toggle-icon-colors.react.jsx

```jsx
<FormKit
        type="toggle"
        defaultValue={true}
        thumbIcon="whatsapp"
        thumbColorOn="#4FCE5D"
        trackColorOn="#435A64"
        iconColorOn="white"
      />
```

The `toggle` input is built atop HTML's native checkbox input.

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `alt-label-position` | `Boolean` | `undefined` | Moves the label above the toggle. |
| `off-value` | `any` | `false` | The value when the toggle is unchecked. |
| `on-value` | `any` | `true` | The value when the toggle is checked. |
| `off-value-label` | `String` | `undefined` | The text of the Value label when the toggle is unchecked. |
| `on-value-label` | `String` | `undefined` | The text of the Value label when the toggle is checked. |
| `value-label-display` | `String` | `undefined` | The on and off value labels will always default to being displayed outside and to the right of the toggle. Other accepted values include inner to set the value labels inside of the toggle, and hidden which hides the value labels. |
| `value-label-color-off` | `String` | `undefined` | Used to set the color of the value label when the toggle is unchecked. |
| `value-label-color-on` | `String` | `undefined` | Used to set the color of the value label when the toggle is checked. |
| `thumb-icon` | `String` | `undefined` | This prop is used to set the icon that will be placed inside the thumb section. |
| `thumb-color-off` | `String` | `undefined` | Sets the background color of the thumb section when the toggle is unchecked. |
| `thumb-color-on` | `String` | `undefined` | Sets the background color of the thumb section when the toggle is checked. |
| `icon-color-off` | `String` | `undefined` | The color the icon should be set to when toggle-icon prop is set and the toggle is unchecked. |
| `icon-color-on` | `String` | `undefined` | The color the icon should be set to when toggle-icon prop is set and the toggle is checked. |
| `track-color-off` | `String` | `undefined` | Sets the background color of the track section when the toggle is unchecked. |
| `track-color-on` | `String` | `undefined` | Sets the background color of the track section when toggle is checked. |

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

Additional slot data specific to the `toggle` input:

| Property | Type | Description |
|----------|------|-------------|
| `onValue` | `any` | Value when toggle is on. |
| `offValue` | `any` | Value when toggle is off. |
| `onValueLabel` | `string` | Label text for on state. |
| `offValueLabel` | `string` | Label text for off state. |
| `isChecked` | `boolean` | Whether the toggle is currently on. |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the toggle input. |
| `handlers.toggle` | `() => void` | Toggles the on/off state. |

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
    └─ altLabel
    └─ inner
      └─ prefix
      └─ input
      └─ track
        └─ innerLabel
        └─ thumbWrapper
          └─ thumb
      └─ suffix
    └─ valueLabel
    └─ defaultLabel
  └─ help
  └─ messages
    └─ message
```

### Section Keys Reference

| Section Key | Element | Description |
|-------------|---------|-------------|
| `outer` | `<div>` | The outermost wrapping element. |
| `wrapper` | `<label>` | A label element wrapping the inner section and label text. Clicking anywhere toggles the checkbox/radio. |
| `altLabel` | `<span>` | Alternative label position (left of toggle). |
| `inner` | `<span>` | A span wrapping the input, decorator, prefix, and suffix sections. |
| `prefix` | (none) | Has no output by default, but allows content directly before an input element. |
| `input` | `<select>` | The native HTML select element. |
| `track` | `<label>` | The track (background) that the thumb slides on. |
| `innerLabel` | `<span>` | Label inside the track showing on/off state. |
| `thumbWrapper` | `<span>` | Wrapper around the thumb element. |
| `thumb` | `<span>` | The thumb element that slides on the track. |
| `suffix` | (none) | Has no output by default, but allows content directly after an input element. |
| `valueLabel` | `<span>` | Label showing current value (on/off text). |
| `defaultLabel` | `<span>` | Default label position (right of toggle). |
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
| `altLabel` | `for` | `-` | Associates the label to an input element. Users can click on the label to focus the input or to toggle between states. |
| `valueLabel` | `for` | `-` | Associates the label to an input element. Users can click on the label to focus the input or to toggle between states. |
| `inner` | `for` | `-` | Associates the label to an input element. Users can click on the label to focus the input or to toggle between states. |

### Keyboard Interactions

| Key | Description |
|-----|-------------|
| `space` | Changes the state of toggle input. |
