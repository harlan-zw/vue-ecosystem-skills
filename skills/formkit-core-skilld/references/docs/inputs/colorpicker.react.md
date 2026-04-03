# Colorpicker Input

A colorpicker with support for alpha transparency, pre-loaded swatches, and multiple color output formats.

The `colorpicker` input allows for advanced color selection — including alpha channel support. It supports colors in `Hex`, `HSLA` and `RGBA` formats and can be configured to provide a preset list of colors.

Most importantly, unlike the native `color` input, the `colorpicker` provides a consistent, predictable, and accessible user experience across browsers and operating systems.

The `colorpicker` input is fully keyboard navigable and ships with accessible markup.

In React JSX props like <code>valueFormat</code>, <code>panelControls</code>, <code>eyeDropper</code>, and <code>allowPaste</code> use the standard prop casing for that framework.

## Basic example

### Example: Color input

#### intro.react.jsx

```jsx
<FormKit
        type="colorpicker"
        defaultValue="#DE1B1B"
        label="A default colorpicker input"
        popover
        help="Just the way it comes out of the box."
      />

      <FormKit
        type="colorpicker"
        inline
        defaultValue="hsla(240, 75%, 35%, 0.75)"
        label="An inline colorpicker input"
        help="Shows the colorpicker inline."
      />
```

## Color formats

### Supported formats

The `colorpicker` supports formats in `Hex`, `HSLA` and `RGBA` formats. You can set your desired format with the `format` prop and color values from the `colorpicker` will be returned in that format. Your chosen format will also be the default setting for the input field(s) which show up in the `colorpicker` panel.

### Example: Color input

#### format.react.jsx

```jsx
<FormKit
        type="colorpicker"
        format="hex"
        modelValue={color}
        onUpdateModelValue={setColor}
        delay={0}
        popover
      />
      <FormKit
        type="colorpicker"
        format="hsla"
        modelValue={color}
        onUpdateModelValue={setColor}
        delay={0}
        popover
      />
      <FormKit
        type="colorpicker"
        format="rgba"
        modelValue={color}
        onUpdateModelValue={setColor}
        delay={0}
        popover
      />
```

### Value format

There may be times where you wish to show one format to users as a default but return a different format. You can use the `value-format` prop to specify a return value format independent of the `format` prop.

### Example: Color input

#### value-format.react.jsx

```jsx
<FormKit
            type="colorpicker"
            name="color"
            defaultValue="hsla(324, 62%, 58%, 1)"
            format="hex"
            popover
            valueFormat="rgba"
          />
```

## Swatches

Swatches are provided using the `options` prop and use the same `options` API as the `select`, `dropdown`, `autocomplete` and `taglist` inputs from FormKit.

### Simple swatches

Here is a simple set of swatches using the `options` prop and providing it with a flat array of color values. Your provided values can be in any supported color format (`Hex`, `HSLA`, and `RGBA`) and will be automatically converted to the `colorpicker`s speficied `format` which defaults to `Hex`.

### Example: Color input

#### simple-swatches.react.jsx

```jsx
<FormKit type="colorpicker" inline options={swatches} />
```

### Grouped swatches

The `colorpicker` also supports grouped `options`. This allows you to create sets of swatches within the color picker grouped under a common heading.

### Example: Color input

#### grouped-swatches.react.jsx

```jsx
<FormKit
        type="colorpicker"
        defaultValue="#FF985D"
        inline
        options={groupedSwatches}
      />
```

### Swatch-only

You can create a "swatch-only" `color-picker` by using the `panel-controls` and `panel-format` props and setting them to `false`.

When showing only swatches in pop-over mode (the default) adding the `close-on-select` prop will close the pop-over when a swatch is selected.

### Example: Color input

#### swatch-only.react.jsx

```jsx
<FormKit
        type="colorpicker"
        label="Swatch-only in inline mode"
        defaultValue="#CF021D"
        inline
        options={swatches}
        panelControls={false}
        panelFormat={false}
      />

      <FormKit
        type="colorpicker"
        label="Swatch-only in pop-over mode"
        defaultValue="#B955CB"
        options={swatches}
        panelControls={false}
        panelFormat={false}
        popover
        closeOnSelect
      />
```

### Inputting by swatch name

If your provided swatches via the `options` prop have `label`s then you can call `node.input()` with a swatch name and the associated color will be set for you.

In React, the paired example looks up the input node with `useFormKitNodeById()` before calling `node.input()`.

### Example: Color input

#### input-swatch-name.react.jsx

```jsx
<div className="input-color-name">
        <FormKit
          id="textInput"
          type="text"
          label="Input a named CSS color"
          help="Try 'red', 'blue', or 'papayawhip'"
          onKeydown={(event) => {
            if (event.key === 'Enter') {
              event.preventDefault()
              applyColorInput()
            }
          }}
          slots={{
            suffix: () => (
              <FormKit
                type="button"
                label="Set color"
                onClick={applyColorInput}
                outerClass="!mb-0"
                inputClass="!mb-0 whitespace-nowrap"
              />
            ),
          }}
        />
      </div>

      <FormKit
        id="colorpickerInput"
        type="colorpicker"
        inline
        options={htmlNamedColors}
      />
```

## Eyedropper

The `colorpicker` input supports the browser-native EyeDropper API. If the EyeDropper is supported in your browser and you have not disabled the EyeDropper by setting the `eye-dropper` prop to `false` then you will see an eyedropper button to the right of the hue and alpha sliders.

### Example: Color input

#### eye-dropper.react.jsx

```jsx
<FormKit
        type="colorpicker"
        label="Eyedropper enabled (default, when available)"
        inline
        defaultValue="#B955CB"
      />

      <FormKit
        type="colorpicker"
        label="Eyedropper disabled"
        inline
        eyeDropper={false}
        defaultValue="#B955CB"
      />
```

## Pasting values

By default a `colorpicker` input will allow the pasting of any valid color values while user focus is anywhere in the input. Values will be converted immediately to your desired `format`.

You can disable the ability to paste a value by setting the `allow-paste` prop to `false`.

### Example: Color input

#### paste.react.jsx

```jsx
<FormKit
        type="colorpicker"
        label="I accept pasted values"
        help="This is a big timesaver."
        popover
        defaultValue="#68B9CD"
      />

      <FormKit
        type="colorpicker"
        label="I do NOT accept pasted values"
        help="Which is useful for cases such as a swatch-only picker"
        defaultValue="hsla(288, 56%, 52%, 1)"
        allowPaste={false}
        panelControls={false}
        panelFormat={false}
        popover
        options={swatches}
      />
```

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `format` | `string` | `hex` | The format that the colorpicker input should show in the input preview and be the default setting for the picker panel input. Can be set to hex, hsla or rgba. |
| `value-format` | `string` | `undefined` | The format that should be returned from the colorpicker input regardless of the displayed format. If not specified the value of the format prop will be used. |
| `panel-controls` | `boolean` | `true` | Used to control the display of the Lightness/Saturation gradient and the Hue and Alpha sliders. |
| `panel-format` | `boolean` | `true` | Used to control whether the display of the color input fields and format switcher button. |
| `eye-dropper` | `boolean` | `true` | Used to control the display of the eye-dropper control. Requires a browser that supports the EyeDropper API. If enabled in an unsupported browser the control will behave as if set to false. |
| `inline` | `boolean` | `false` | When set to true the colorpicker will render its panel as an inline element rather than as a pop-over. |
| `options` | `Array/Object` | `[]` | An object of value/label pairs or an array of strings, or an array of objects that must contain a label and value property. Supports grouped options via an array of objects that contain group and options keys where options is a nested options definition. Grouping is only supported at one level of depth. |
| `show-value` | `boolean` | `true` | Used to control the display of the current color value in the input preview. Uses the format prop to determine which value to display. |
| `close-on-select` | `boolean` | `false` | When set to true the colorpicker panel will close when a preset swatch option is chosen. |
| `allow-paste` | `boolean` | `true` | Allows pasting any valid color string of Hex, HSLA, or RGBA format into a colorpicker that contains the user's focus. The pasted string will immediately be set as the value of the colorpicker and converted to the desired format. |
| `popover` | `boolean` | `false` | Renders the input's UI panel using the browser Popover API. |

## Sections & slot data

You can target specific sections of an input using the `section-key` attribute or slots. Each section can be styled or customized independently.

The `colorpicker` input's structure changes depending on the existence of the `inline` prop:

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

Additional slot data specific to the `colorpicker` input:

| Property | Type | Description |
|----------|------|-------------|
| `format` | `any` | The color format for the input value. |
| `valueFormat` | `any` | The format of the actual value (may differ from display). |
| `panelActiveFormat` | `any` | Currently active format in the panel inputs. |
| `inline` | `boolean` | Whether the panel is shown inline (not pop-over). |
| `expanded` | `boolean` | Whether the pop-over panel is currently open. |
| `color` | `{ h: number; s: number; l: number; a: number }` | Current color in HSLA format. |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the colorpicker input. |
| `handlers.open` | `() => void` | Opens the color picker panel. |
| `handlers.close` | `() => void` | Closes the color picker panel. |
| `handlers.setColor` | `(color: string) => void` | Sets the color value. |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |
| `swatch` | `swatch` | `{ color: string; label?: string }` | The current swatch option being rendered. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```

#### Input preview (pop-over mode)
The colorpicker trigger showing the current color.
- outer
  └─ wrapper
    └─ label
    └─ inner
      └─ prefixIcon
      └─ prefix
      └─ swatchPreview
        └─ canvasSwatchPreview
        └─ valueString
      └─ suffix
      └─ suffixIcon
  └─ help
  └─ messages
    └─ message

#### Panel controls
The colorpicker panel with color selection area, sliders, and preview.
- panel
  └─ panelClose
    └─ closeIcon
  └─ controlGroup
    └─ LS
      └─ canvasLS
      └─ controlLS
    └─ preview
      └─ canvasPreview
    └─ hue
      └─ canvasHue
      └─ controlHue
    └─ alpha
      └─ canvasAlpha
      └─ controlAlpha
    └─ eyeDropper
      └─ eyeDropperIcon

#### Format fields and swatches
Color value inputs and preset swatch buttons.
- panel
  └─ formatField
    └─ colorInputGroup
      └─ hexField
    └─ formatSwitcher
      └─ switchIcon
  └─ swatches
    └─ swatch
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
| `swatchPreview` | `<button>` | Button that shows current color and opens the panel. |
| `canvasSwatchPreview` | `<canvas>` | Canvas element showing the color preview swatch. |
| `valueString` | `<span>` | Text showing the current color value. |
| `suffix` | (none) | Has no output by default, but allows content directly after an input element. |
| `suffixIcon` | `<span>` | An element for outputting an icon after the suffix section. |
| `help` | `<div>` | The element containing help text. |
| `messages` | `<ul>` | A wrapper around all the messages. |
| `message` | `<li>` | The element (or many elements) containing a message — most often validation and error messages. |
| `panel` | `<div>` | The color picker panel containing all controls. |
| `panelClose` | `<button>` | Close button for the panel (shown on small screens). |
| `closeIcon` | `<span>` | Icon for the search clear button. |
| `controlGroup` | `<div>` | Container for the color selection controls. |
| `LS` | `<div>` | Lightness/Saturation selection area. |
| `canvasLS` | `<canvas>` | Canvas for the LS gradient. |
| `controlLS` | `<div>` | Draggable control point for LS selection. |
| `preview` | `<div>` | Preview area showing selected color. |
| `canvasPreview` | `<canvas>` | Canvas showing the color preview. |
| `hue` | `<div>` | Hue slider area. |
| `canvasHue` | `<canvas>` | Canvas for the hue gradient. |
| `controlHue` | `<div>` | Draggable control for hue selection. |
| `alpha` | `<div>` | Alpha/opacity slider area. |
| `canvasAlpha` | `<canvas>` | Canvas for the alpha gradient. |
| `controlAlpha` | `<div>` | Draggable control for alpha selection. |
| `eyeDropper` | `<button>` | Button to activate native eye dropper. |
| `eyeDropperIcon` | `<div>` | The eyeDropperIcon section. |
| `formatField` | `<div>` | Container for color format input fields. |
| `colorInputGroup` | `<div>` | Group of color component inputs. |
| `hexField` | `<input>` | Input for hex color value. |
| `formatSwitcher` | `<button>` | Button to switch between color formats. |
| `switchIcon` | `<div>` | The switchIcon section. |
| `swatches` | `<div>` | Container for preset color swatches. |
| `swatch` | `<button>` | A single preset color swatch button. |

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
| `swatchPreview` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `swatchPreview` | `role` | `button` | Indicates to assistive technologies that this element functions as a button. |
| `swatchPreview` | `aria-valuetext` | `-` | Defines the human-readable text of the value. |
| `panel` | `aria-role` | `dialog` | When layout is set to popover it adds this attribute. |
| `panel` | `aria-modal` | `true` | When layout is set to popover it adds this attribute. |
| `panel` | `aria-label` | `-` | Provides an accessible name. |
| `panelClose` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when panel is closed and 0 when openned. |
| `panelClose` | `aria-label` | `-` | Provides an accessible name. |
| `controlGroup` | `role` | `group` | Indicates to assistive technologies that this element functions as a group. |
| `canvasLS` | `aria-hidden` | `true` | Makes this element not exposed to the accessibility API. |
| `controlLS` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `controlLS` | `role` | `slider` | Indicates to assistive technologies that this element functions as a slider. |
| `controlLS` | `aria-valuemin` | `-` | Defines the minimum allowed value. |
| `controlLS` | `aria-valuemax` | `-` | Defines the maximum allowed value. |
| `controlLS` | `aria-valuetext` | `-` | Defines the human-readable text of the value. |
| `canvasHue` | `aria-hidden` | `true` | Makes this element not exposed to the accessibility API. |
| `controlHue` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `controlHue` | `role` | `slider` | Indicates to assistive technologies that this element functions as a slider. |
| `controlHue` | `aria-valuemin` | `-` | Defines the minimum allowed value. |
| `controlHue` | `aria-valuemax` | `-` | Defines the maximum allowed value. |
| `controlHue` | `aria-valuenow` | `-` | Defines the human-readable text of the value. |
| `canvasAlpha` | `aria-hidden` | `true` | Makes this element not exposed to the accessibility API. |
| `controlAlpha` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `controlAlpha` | `role` | `slider` | Indicates to assistive technologies that this element functions as a slider. |
| `controlAlpha` | `aria-valuemin` | `-` | Defines the minimum allowed value. |
| `controlAlpha` | `aria-valuemax` | `-` | Defines the maximum allowed value. |
| `controlAlpha` | `aria-valuenow` | `-` | Defines the human-readable text of the value. |
| `canvasPreview` | `aria-hidden` | `true` | Makes this element not exposed to the accessibility API. |
| `canvasSwatchPreview` | `aria-hidden` | `true` | Makes this element not exposed to the accessibility API. |
| `eyeDropper` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `eyeDropper` | `role` | `button` | Indicates to assistive technologies that this element functions as a button. |
| `colorInputGroup` | `aria-role` | `group` | Indicates to assistive technologies that this element functions as a group. |
| `hexField` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `hexField` | `for` | `-` | Associates the label to an input element. Users can click on the label to focus the input or to toggle between states. |
| `rField` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `rField` | `for` | `-` | Associates the label to an input element. Users can click on the label to focus the input or to toggle between states. |
| `gField` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `gField` | `for` | `-` | Associates the label to an input element. Users can click on the label to focus the input or to toggle between states. |
| `bField` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `bField` | `for` | `-` | Associates the label to an input element. Users can click on the label to focus the input or to toggle between states. |
| `aField` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `aField` | `for` | `-` | Associates the label to an input element. Users can click on the label to focus the input or to toggle between states. |
| `hField` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `hField` | `for` | `-` | Associates the label to an input element. Users can click on the label to focus the input or to toggle between states. |
| `sField` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `sField` | `for` | `-` | Associates the label to an input element. Users can click on the label to focus the input or to toggle between states. |
| `lField` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `lField` | `for` | `-` | Associates the label to an input element. Users can click on the label to focus the input or to toggle between states. |
| `formatSwitcher` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `formatSwitcher` | `role` | `button` | Indicates to assistive technologies that this element functions as a button. |
| `formatSwitcher` | `aria-label` | `-` | Provides an accessible name. |
| `swatch` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `swatch` | `role` | `button` | Indicates to assistive technologies that this element functions as a button. |
| `swatch` | `aria-label` | `-` | Provides an accessible name. |

### Keyboard Interactions

| Key | Description |
|-----|-------------|
| `enter` | Toggles the state of the color picker panel when input is focused. |
| `space` | Toggles the state of the color picker panel when input is focused. Invokes color picker panel UI buttons when focused. |
| `esc` | Closes the color picker panel. |
| `up` + `down` + `left` + `right` | Adjusts selection of UI elements in the color picker panel. |
| `Shift` + `up` | Adjusts selection of UI elements in the color picker panel at 10x rate. |
| `Shift` + `down` | Adjusts selection of UI elements in the color picker panel at 10x rate. |
| `Shift` + `left` | Adjusts selection of UI elements in the color picker panel at 10x rate. |
| `Shift` + `right` | Adjusts selection of UI elements in the color picker panel at 10x rate. |
| `PageUp` | Adjusts selection of UI elements in the color picker panel at 10x rate. |
| `PageDown` | Adjusts selection of UI elements in the color picker panel at 10x rate. |
| `Home` | Snaps UI selection element to beginning of range |
| `End` | Snaps UI selection element to end of range |
| `Command` + `v` | Pastes a color value into the input when focused. Its format is adjusted automatically. |
