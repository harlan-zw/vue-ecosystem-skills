# Unit Input

The unit input allows for restricted input of values based on the provided unit (distance, weight, temperature, etc.) and locale.

## Unit Input

The `unit` input allows for restricted input of values based on the provided unit (distance, weight, temperature, etc.) and locale.

In React JSX props like <code>displayLocale</code>, <code>minDecimals</code>, <code>valueFormat</code>, <code>valueUnit</code>, and <code>unitDisplay</code> use the standard prop casing for that framework.

### Example: Unit input defaults

#### unit.react.jsx

```jsx
<FormKit
            type="unit"
            unit="kilometer"
            name="distance"
            label="Distance in meters"
            defaultValue={100}
          />
          <FormKit
            type="unit"
            unit="celsius"
            name="temperature"
            label="Temperature in Celsius"
            defaultValue={100}
          />
          <FormKit
            type="unit"
            unit="nanosecond"
            name="time"
            label="Time in nanoseconds"
            defaultValue={100}
          />
          <FormKit
            type="unit"
            unit="fluid-ounce"
            name="volume"
            label="Volume in fluid ounces"
            defaultValue={100}
          />
          <FormKit
            type="unit"
            unit="megabyte"
            name="digital-unit"
            label="Digital unit in megabytes"
            defaultValue={100}
          />
          <pre>{JSON.stringify(value, null, 2)}</pre>
```

## Props

### Unit

The `unit` prop is the type of unit you want to display. A full list of allowed unit types are listed below:

`acre`, `bit`, `byte`, `celsius`, `centimeter`, `day`, `degree`, `fahrenheit`, `fluid-ounce`, `foot`, `gallon`, `gigabit`, `gigabyte`, `gram`, `hectare`, `hour`, `inch`, `kilobit`, `kilobyte`, `kilogram`, `kilometer`, `liter`, `megabit`, `megabyte`, `meter`, `microsecond`, `mile`, `mile-scandinavian`, `milliliter`, `millimeter`, `millisecond`, `minute`, `month`, `nanosecond`, `ounce`, `percent`, `petabyte`, `pound`, `second`, `stone`, `terabit`, `terabyte`, `week`, `yard`, `year`

### Unit display

The display length can be modified by the `unitDisplay` property. Accepted values are `short`, `narrow`, and `long`.

### Example: Unit input defaults

#### unit-display.react.jsx

```jsx
<FormKit
        type="unit"
        unit="kilogram"
        name="narrow"
        unitDisplay="narrow"
        label="Narrow"
        defaultValue={100}
      />
      <FormKit
        type="unit"
        unit="kilogram"
        name="short"
        unitDisplay="short"
        label="Short"
        defaultValue={100}
      />
      <FormKit
        type="unit"
        unit="kilogram"
        name="long"
        unitDisplay="long"
        label="Long"
        defaultValue={100}
      />
```

### Locale

By default the locale will use what you have set in your `formkit.config.ts` as the desired locale. However you can override this with the `displayLocale` prop. For example, `en-US`, `de-DE`, `en-IN`, `zh-CN`, etc, etc.

### Example: Unit input defaults

#### unit-locale.react.jsx

```jsx
<FormKit
        type="unit"
        unit="kilogram"
        name="input_1"
        unitDisplay="long"
        displayLocale="en-US"
        defaultValue={100}
      />
      <FormKit
        type="unit"
        unit="kilogram"
        name="input_2"
        unitDisplay="long"
        displayLocale="de-DE"
        defaultValue={100}
      />
      <FormKit
        type="unit"
        unit="kilogram"
        name="input_3"
        unitDisplay="long"
        displayLocale="zh-CN"
        defaultValue={100}
      />
```

### Decimals

By default the decimals will display when the value contains the unit/locale decimal separator and will show default formatting decimal places to display for the given unit, however you can override this. By setting `decimals` to `false` or `0`, the value will not allow decimals or setting decimals to a numeric value will limit the maximum decimal places to that value.

You can also choose to set a minimum number of decimals with the `minDecimals` prop. For example, you always want to show 2 decimal places you would set `minDecimals="2"`.

### Example: Unit input defaults

#### unit-decimals.react.jsx

```jsx
<FormKit
        type="unit"
        unit="liter"
        name="input_1"
        label="5 decimals allowed"
        decimals={5}
        defaultValue={100}
      />
      <FormKit
        type="unit"
        unit="liter"
        name="input_2"
        label="Minimum of 2 decimals"
        minDecimals={2}
        defaultValue={100}
      />
```

### Minimum and Maximum Values

Similar to a number input, you can set a `min` and `max` value.

### Example: Unit input defaults

#### unit-min-max.react.jsx

```jsx
<FormKit
        type="unit"
        unit="millisecond"
        name="input_1"
        label="Min of 100"
        min={100}
        defaultValue={100}
      />
      <FormKit
        type="unit"
        unit="millisecond"
        name="input_2"
        label="Max of 100"
        max={100}
        defaultValue={0}
      />
```

### Step

Again, similar to a number input you can use the up/down keys to step the value. By default the step is `1` but you can override that with this prop.

### Example: Unit input defaults

#### unit-step.react.jsx

```jsx
<FormKit
        type="unit"
        unit="centimeter"
        name="input_1"
        label="Step of 100"
        step={100}
        defaultValue={0}
      />
```

### Value Formatting

The value of the input itself defaults to a number but can be formatted as a string to include information about the unit itself.

### Example: Unit input defaults

#### unit-value-format.react.jsx

```jsx
<FormKit
            type="unit"
            unit="year"
            name="input_1"
            label="Default formatting"
            defaultValue={100}
          />
          <FormKit
            type="unit"
            unit="year"
            name="input_2"
            label="Formatting as string"
            valueFormat="string"
            defaultValue={100}
          />
          <pre>{JSON.stringify(value, null, 2)}</pre>
```

### Value unit

The unit input also allows for first-party conversion of one unit type to another. In this example, we will use `unit` of type `mile`, but the value
itself will be converted to `kilometers` when setting `value-unit` to `kilometer`.

### Example: Unit type examples

#### value-unit.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="unit"
              unit="mile"
              label="Miles"
              name="value"
              valueUnit="kilometer"
            />
            <pre>In kilometers: {value && value.value}</pre>
          </>
        )}
      </FormKit>
```

### Unitless

The `unit` prop is optional, allowing for unitless values.

### Example: Unit type examples

#### unitless.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit type="unit" label="No units" name="value" />
            <pre>{value && value.value}</pre>
          </>
        )}
      </FormKit>
```

> **Warning:** In order to convert one unit to another, they must be in the same taxonomy (so for example, you can not convert kilometers to liters).

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `unit` | `string | undefined` | `-` | Set the specified unit to use for this input. If undefined, will allow for unitless values. |
| `displayLocale` | `string` | `en-US` | Set the desired display locale to use for this input |
| `decimals` | `boolean|number` | `null` | Choose to either completely disallow decimals or override the maximum number of decimals for the input |
| `minDecimals` | `number` | `null` | Choose to show a minimum number of decimals should your input require this |
| `min` | `number` | `null` | Minimum numeric value allowed. If zero or above, negatives will not be allowed |
| `max` | `number` | `null` | Maximum numeric value allowed for this input |
| `step` | `number` | `1` | When using the up/down keys, how much to modify the current value. |
| `valueDecimals` | `string | number` | `undefined` | Determines the allowed number of decimals for the valueUnit. |
| `valueFormat` | `string` | `number` | Choose between number and string whether you want a numeric value or a parsed string value |
| `valueUnit` | `string` | `undefined` | Used to convert the user-inputted value from one unit to another |
| `unitDisplay` | `string ('narrow' | 'short' | 'long')` | `short` | Determines the length of the how the unit is represented. |

## Sections

You can target specific sections of an input using the `section-key` attribute or slots. Each section can be styled or customized independently.

### Unit input diagram

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

Additional slot data specific to the `unit` input:

| Property | Type | Description |
|----------|------|-------------|
| `_value` | `number` |  |
| `value` | `number` |  |

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
| `up` + `down` | Increments through input value by current step amount. |
