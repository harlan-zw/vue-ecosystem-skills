# Currency Input

The currency input is used to create locale/currency specific parsed content

## Basic example

The `currency` input allows for restricted input of values based on the provided currency and locale.

When controlling this input in React, prefer `modelValue` and `onUpdateModelValue`. Currency-specific props like `displayLocale` and `valueFormat` also use standard camelCase JSX prop names.

### Example: Currency input defaults

#### currency-default.react.jsx

```jsx
<FormKit type="currency" name="currency" defaultValue={12345678.9} />
```

## Props

### Currency

The `currency` prop is the three letter currency code and sets the proper formatting for the specified currency. For a full list of supported currency types check: https://en.wikipedia.org/wiki/ISO_4217#List_of_ISO_4217_currency_codes

### Locale

By default, the locale used will be that of what is set in your `formkit.config.ts`. This can be overriden with the `display-locale` prop. For example, `en`, `de`, `en-IN`, `zh-CN`, etc, etc.

### Example: Currency and Locale settings

#### currency-simple-locale.react.jsx

```jsx
<FormKit
            type="currency"
            currency="USD"
            displayLocale="en"
            name="usd"
            defaultValue={12345678.9}
          />

          <FormKit
            type="currency"
            currency="EUR"
            displayLocale="de"
            name="eur"
            defaultValue={12345678.9}
          />

          <FormKit
            type="currency"
            currency="INR"
            displayLocale="en-IN"
            name="inr"
            defaultValue={12345678.9}
          />

          <FormKit
            type="currency"
            currency="CNY"
            displayLocale="zh-CN"
            name="cny"
            defaultValue={12345678.9}
          />
```

## Currency Additional Props

### Decimals

If you would like to prevent decimals from being displayed, set `decimals` to `false` or `0`.

You can also choose to set a minimum number of decimals with the `min-decimals` prop. For example, setting the prop `min-decimals="2"` will always show 2 decimal points.

### Minimum and Maximum Values

Setting the props `min` or `max` will prevent entry of a higher or lower value.

### Step

Values can be incremented and decremented by use of the up/down keys. The degree by which the value changes is determined by the `step` prop.

### Example: Currency Prop Exploration

#### currency-props-explore.react.jsx

```jsx
<FormKit
            type="currency"
            name="currency"
            min={-10}
            max={1000}
            step={0.0001}
            currency="USD"
            displayLocale="en-US"
            decimals={4}
            minDecimals={2}
            defaultValue={123.1234}
          />
```

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `currency` | `string` | `USD` | Set the specified currency to use for this input |
| `displayLocale` | `string` | `en-US` | Set the desired display locale to use for this input |
| `decimals` | `boolean|number` | `null` | Choose to either completely disallow decimals or override the maximum number of decimals for the input |
| `minDecimals` | `number` | `null` | Choose to show a minimum number of decimals should your input require this |
| `min` | `number` | `null` | Minimum numeric value allowed. If zero or above, negatives will not be allowed |
| `max` | `number` | `null` | Maximum numeric value allowed for this input |
| `step` | `number` | `1` | When using the up/down keys, how much to modify the current value. |
| `valueFormat` | `string` | `number` | Choose between number and string whether you want a numeric value or a parsed string value |

## Sections

You can target specific sections of an input using the `section-key` attribute or slots. Each section can be styled or customized independently.

### Currency input diagram

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

Additional slot data specific to the `currency` input:

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
