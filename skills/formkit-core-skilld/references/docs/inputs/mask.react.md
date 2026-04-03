# Mask Input

An input that formats text to a given pattern as a user types.

## Introduction

The `mask` input automatically transforms user input to match a provided format. Used appropriately, mask inputs can provide an improved user experience by removing any ambiguity for the desired value (for example a phone number or social security number).

In React JSX props like <code>showMask</code>, <code>selectDirection</code>, and <code>selectFill</code> use the standard prop casing for that framework. When registering tokens globally in React, use `defineFormKitConfig()` in the same way the paired config example does.

## Basic example

### Example: Mask input

#### basic.react.jsx

```jsx
<FormKit
        type="mask"
        name="phone"
        mask="+1 (###) ###-####"
        label="Phone number"
        help="Please enter a phone number"
      />
```

## Masks

The mask is the desired format of the input. It is passed to the `mask` prop where it is parsed for tokens. The mask is comprised of:

- **Tokens** - A string representation of a user-editable region. Shown in white below.
- **String literals** - Any character that is not a token. Not user-editable. Shown in orange below.

### Built-in tokens

The mask input comes with 4 built-in tokens:

- `h` - Accepts a hexadecimal character (`0-9a-fA-F`).
- `#` - Accepts a digit character.
- `a` - Accepts an alphabetical character.
- `*` - Accepts any character.

### Example: Mask input

#### simple.react.jsx

```jsx
const [color, setColor] = useState('')

  const boxStyle = {
    width: 30,
    height: 30,
  }

  return (
    <>

      <FormKit
        type="mask"
        name="favorite_color"
        modelValue={color}
        onUpdateModelValue={(value) =>
          setColor(typeof value === 'string' ? value : '')
        }
        mask="\\#hhhhhh"
        label="Favorite Color in Hex"
        help="Enter your favorite color in hexadecimal format. Or try FFA500."
      />
      <div style={{ ...boxStyle, backgroundColor: color || undefined }} />
```

### Escaping built-ins

If you need to use one of the built-in tokens as a string literal in your mask, you can escape them with `\`. Here we are escaping the pound sign `#` to use in our hex color:

```
<FormKit mask="\#hhhhhh" type="mask" />

```

## Modes

The mask input supports 3 entry modes:

- Shift (default)
- Replace
- Select

### Shift & replace mode

By default, the characters of a mask are automatically shifted forward when typing. This is notable when a mask is already populated and you place the cursor at or near the beginning of the input and begin typing. The characters following your cursor are "shifted" forward as you type. In replace mode, however, subsequent characters are overwritten with a new value:

### Example: Mask input - shift vs replace

#### shift-replace.react.jsx

```jsx
<FormKit
        type="mask"
        mask="###-###-####"
        defaultValue="123-456-7890"
        label="(Shift mode) Social security number"
        help="Notice when you type new numbers the characters shift to the right."
      />
      <FormKit
        type="mask"
        mode="replace"
        mask="###-###-####"
        defaultValue="123-456-7890"
        label="(Replace mode) Social security number"
        help="Notice when you type new numbers the characters are replaced."
      />
```

### Select mode

In select mode, equivalent `char` type tokens are grouped into selectable text ranges. FormKit automatically selects these text ranges when clicking or focusing the input. These selection ranges are maintained as the user is typing. When used tastefully, this produces a clear UX as the user is aware of what value they are expected to enter.

Additionally, when an input is in select mode, the user can use the arrow or tab keys to shift their focus from one selection range to another:

### Example: Mask input - select

#### select.react.jsx

```jsx
<FormKit
        type="mask"
        mode="select"
        mask="###-###-####"
        label="(Select mode) Social security number"
        help="In select mode the active range is always highlighted."
      />
```

> **Tip:** The `selectDirection` token property controls which direction new
characters flow into the selected range. You can fill "empty" selection characters with a predetermined value (like leading zeros "0") by using the `selectFill` property. See [token properties](#creating-new-tokens).

## Tokens

### Creating new tokens

What if a pattern can accept letters *or* numbers in the same position? It’s relatively simple to create new tokens. There are 2 types of tokens:

- `char` accepts a single character.
- `enum` accepts any strings from an array of possible values.

The following properties must be defined to create a new token:

```
{
  /**
   * The type of token. Can be a `char` or `enum`.
   */
  type: 'char',
  /**
   * The token to parse out of the mask.
   */
  token: 'z',
  /**
   * A placeholder character to display in the input when `show-mask` is
   * enabled.
   */
  placeholder: '_',
  /**
   * When using `select` mode, determines which direction do new characters flow
   * in.
   */
  selectDirection: 'left',
  /**
   * (Only for `char` type). A regular expression that describes the types of
   * characters that can appear in this slot. This pattern will be evaluated
   * against individual characters — not in the context of the entire string.
   */
  pattern: /[A-Za-z0-9]/,
  /**
   * (Only for `char` type, optional). An optional character to "fill" the
   * selection range with when in select mode. For example, a selectFill set to
   * "0" can be helpful with numbers to produce leading zeros like "001".
   */
  selectFill: "0",
  /**
   * (Only for `enum` type). An array of possible values.
   */
  values: [
    'March',
    'April',
    'May'
  ],
}

```

For example, a new token that accepts letters and numbers, and is represented by the letter `z` in the mask string would look like this:

```
{
  type: 'char',
  token: 'z',
  pattern: /[A-Za-z0-9]/,
  placeholder: '_',
  selectDirection: 'left',
}

```

> **Warning:** Any `placeholder` you define should not match the Regex `pattern` provided in the token definition.

#### Add tokens via prop

To pass a new token to the mask input, you can use the `tokens` prop which
expects an object with keys that match the `token` property. For example, our new token in the above example can be applied directly:

### Example: Mask input

#### tokens-prop.react.jsx

```jsx
<FormKit
        type="mask"
        name="promo_code"
        mask="zzz-#### ####"
        tokens={{
          z: {
            type: 'char',
            token: 'z',
            pattern: /[A-Za-z0-9]/,
            placeholder: '_',
            selectDirection: 'left',
          },
        }}
        defaultValue="a6d-7789 4398"
        label="Promo code"
        help="Enter a promo code in the format: fkt-1234 5678"
      />
```

#### Add tokens globally

To register your mask tokens globally, extend the `config` property of your global FormKit configuration:

### Example: Mask input global

#### tokens-global.react.jsx

```jsx
<FormKit
        type="mask"
        name="tracking"
        mask="usps-zzz-zzzz-zzzz-zzzz"
        defaultValue="usps-mk6-8d2z-8fggy-921x"
        label="Tracking number"
      />
```

#### formkit.config.react.jsx

```jsx
import { genesisIcons } from '@formkit/icons'
import { defineFormKitConfig } from '@formkit/react'
import { createProPlugin, inputs as proInputs } from '@formkit/pro'

const pro = createProPlugin('fk-52971f34220', proInputs)

export default defineFormKitConfig({
  plugins: [pro],
  icons: {
    ...genesisIcons,
  },
  config: {
    tokens: {
      z: {
        type: 'char',
        token: 'z',
        pattern: /[A-Za-z0-9]/,
        placeholder: '_',
        selectDirection: 'left',
      },
    },
  },
})
```

### Modify tokens

In addition to creating new tokens, the `tokens` prop can also modify existing tokens. Any value provided to the `tokens` prop will be merged into the existing tokens for that input. For example, the digit token’s (`#`) has no `selectFill` by default. To add one, extend it:

### Example: Mask input - select fill

#### select-fill.react.jsx

```jsx
<FormKit
        type="mask"
        mode="select"
        name="year"
        mask="####"
        label="What year were you born?"
        help="You must be at least 21 to enter this site."
        tokens={{
          '#': {
            selectFill: '0',
          },
        }}
        validation={`required|max:${new Date().getFullYear() - 21}|min:${
          new Date().getFullYear() - 120
        }`}
        validationLabel="Birth year"
        validationVisibility="live"
        validationMessages={{
          min: "Alright gramps, you're too old for this site.",
        }}
      />
```

### Char tokens

`char` tokens accept a single character. In order for a character to be accepted, it must match the `token.pattern` regular expression. The four built in tokens (`h`, `#`, `a`, and `*`) are all `char` type tokens.

In `select` mode, `char` tokens are grouped together into a selection range.

> **Tip:** A `char` token should only ever represent 1 character, and its placeholder should also only be a single character in length.

### Enum Tokens

Enum tokens allow for variable length masks within a predefined set of options. As a user begins to type, the enum token’s value will change to the first matching value, and the selection range will reflect the currently unmatched characters. In practice, this operates much like an autocomplete for that specific token. Additionally, users can cycle through available options for a given token by hitting the up/down arrow keys.

A date with auto-completing month names could be well represented with enums:

### Example: Mask input – enum

#### enum.react.jsx

```jsx
const tokens = {
  month: {
    type: 'enum',
    token: 'month',
    placeholder: 'month',
    selectDirection: 'left',
    values: [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ],
  },
  day: {
    type: 'enum',
    token: 'day',
    placeholder: 'day',
    selectDirection: 'left',
    values: Array.from({ length: 31 }, (_, index) =>
      `${index}`.padStart(2, '0')
    ),
  },
  year: {
    type: 'enum',
    token: 'year',
    placeholder: 'year',
    selectDirection: 'left',
    values: Array.from({ length: 200 }, (_, index) => `${1900 + index}`),
  },
}

export default function App() {
  return (
    <>

      <FormKit
        type="mask"
        mode="select"
        mask="month day, year"
        tokens={tokens}
        label="(Enums) Birthday"
        help="Select a token and then type to autocomplete, or use the up/down arrows to select a value."
      />
```

> **Warning:** Enums are only supported in `select` mode. When any `enum` token is found in a mask string, the `mode` of the input is forcibly set to `select`.

## Groups

Groups are a way to to treat multiple mask characters as a single unit. You create a group by surrounding the desired mask characters in `{}`:

```
<FormKit mask="id{-a#a}" type="mask" />
<!-- "-a#a" is the group -->

```

On their own, groups don't do anything unless you define group options.

### Group options

Group options allow you to apply functionality to an entire group using a pipe `|` followed by the option name and any arguments. The available options are:

- **repeat** — allows a group to be repeated an infinite number of times.
- **placeholder** — A character to hold space prior to user input.

> **Info:** A placeholder defined within a group has a higher specificity than a placeholder defined in the token definition and will override it.

#### Option parameters

Arguments can be passed to a group option by using a colon, such as `placeholder:+`, where the plus symbol `+` is passed to the `placeholder` option.

You can string group options together:

### Example: Mask input

#### groups.react.jsx

```jsx
<FormKit
        type="mask"
        name="school_id"
        mask="id{-a#a|repeat|placeholder:+}"
        label="Id number"
        help="Id number in the format: id-b4b-b4b-b4b-b4b"
      />

      {/* "-a#a" is the group, "repeat" and "placeholder" are the options */}
```

> **Warning:** Groups cannot be used in select mode. An exception will be thrown.

## Prefix & suffix

You can ensure certain characters always appear at the beginning or end of an input by using the `prefix` and `suffix` props, respectively:

### Example: Mask input

#### prefix-suffix.react.jsx

```jsx
<FormKit
        type="mask"
        name="years_old"
        prefix="I am "
        suffix=" years old."
        mask="##"
        mode="select"
        validation="required"
        tokens={{
          '#': {
            selectFill: '0',
          },
        }}
        label="Age"
        help="How old are you?"
      />
```

> **Warning:** Your prefix and suffix content can't match the mask. For instance, if your mask has a digit token `#`, your prefix/suffix can't contain numbers.

## Running the mask in reverse

In specific circumstances, you may want to run your mask in reverse. The mask will test if user input fulfills the mask from right to left. This is common in currency-type inputs and can be applied by adding the `reverse` prop:

### Example: Mask input

#### reverse.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              type="mask"
              reverse
              prefix="\u20ac"
              name="bid"
              mask="{#,##|repeat}#.##"
              label="Bid"
              showMask={false}
              allowIncomplete
              help="Enter your bid for the art piece."
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

> **Warning:** Running a mask in reverse only works in shift mode.

## Mask values

### Incomplete values

A mask’s value is not considered "complete" until the user has filled the entire pattern. Until that point, FormKit will consider the value of the input "empty". This makes it convenient to use with validation rules like `required`. However, if you’d like to accept incomplete values, you can via the `allow-incomplete` prop:

### Example: Mask input - allow incomplete

#### allow-incomplete.react.jsx

```jsx
<FormKit type="form">
        {({ value }) => (
          <>
            <FormKit
              type="mask"
              name="phone"
              mask="(###) ###-####"
              label="Phone number"
              help="Enter a phone number. See the value change as you type."
              allowIncomplete
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

### Unmasked values

By default, the value of a mask input includes the formatting provided via the `mask` prop. However, if you'd like the raw unmasked value with the string literals removed, you can use the `unmask-value` prop:

### Example: Mask input - unmask value

#### unmask-value.react.jsx

```jsx
<FormKit type="form">
        {({ value }) => (
          <>
            <FormKit
              type="mask"
              name="phone"
              mask="(###) ###-####"
              label="Phone number"
              help="Enter a full phone number. See the value has no string literals."
              unmaskValue
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

## Hiding the mask

By default, the `mask` input displays each token’s placeholder character. You can disable this behavior (except in select mode) while still applying formatting automatically via the `show-mask` prop:

### Example: Mask input - show mask

#### show-mask.react.jsx

```jsx
<FormKit
        type="mask"
        name="phone"
        mask="+39 ###.######"
        label="N\u00famero de tel\u00e9fono"
        help="Inserisci il tuo numero di cellulare."
        showMask={false}
      />
```

## Overlay (colorizing a mask)

By default, a mask’s value is displayed via the value of its input element. Although this works "out of the box" it does now allow for the text be stylistically differentiated. For example it would be nice if the "literal" portions of the mask looked different than the "placeholder" portions.

To achieve this effect, you can enable an `overlay` which renders DOM elements that are positioned directly over the input itself. The text inside the input is still there, but it will be transparent. In general the necessary overlay positioning styles are automatically applied for you.

The overlay contains 4 possible sections you can target your styles at:

- Literal (`.formkit-overlay-literal` or `overlay-literal-class`)
- Placeholder (`.formkit-overlay-placeholder` or `overlay-placeholder-class`)
- Enum (`.formkit-overlay-enum` or `overlay-enum-class`)
- Char (`.formkit-overlay-char` or `overlay-char-class`)

The default genesis theme automatically supports the overlay and applies light gray colors to the placeholder. If you are not using Genesis, please ensure the `inner` section is positioned (like `position: relative`).

### Example: Mask input - overlay

#### overlay.react.jsx

```jsx
const tokens = {
  month: {
    type: 'enum',
    token: 'month',
    placeholder: 'month',
    selectDirection: 'left',
    values: [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ],
  },
  day: {
    type: 'enum',
    token: 'day',
    placeholder: 'day',
    selectDirection: 'left',
    values: Array.from({ length: 31 }, (_, index) =>
      `${index}`.padStart(2, '0')
    ),
  },
  year: {
    type: 'enum',
    token: 'year',
    placeholder: 'year',
    selectDirection: 'left',
    values: Array.from({ length: 200 }, (_, index) => `${1900 + index}`),
  },
}

const overlayStyles = `
.red {
  color: red;
}
.yellow {
  color: #d1c813;
}
.blue {
  color: blue;
}
`

export default function App() {
  return (
    <>

      <style>{overlayStyles}</style>
      <FormKit
        type="mask"
        mode="select"
        mask="month day, year"
        tokens={tokens}
        label="Birthday (with overlay)"
        help="Notice the placeholder text is a lighter gray color."
        overlay
      />
      <FormKit
        type="mask"
        name="phone"
        mask="+1 (###) ###-####"
        label="Phone number (with overlay)"
        help="Let's add some crazy colors to the overlay."
        overlayPlaceholderClass="yellow"
        overlayLiteralClass="blue"
        overlayCharClass="red"
        overlay
      />
```

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `allow-incomplete` | `boolean` | `false` | By default, the value of a mask input is empty until the pattern is complete. This prop allows the input to use incomplete values. |
| `mask` | `string` | `none` | The mask to apply. This is a string composed of tokens (like “#”) and literal string values. |
| `mode` | `string` | `shift` | Determines how the mask input operates. Options are shift, replace and select. |
| `overlay` | `boolean` | `false` | Renders DOM elements that mimic the text input to allow the differentiation in the stylization of the mask. |
| `prefix` | `string` | `none` | Characters that will always appear at the beginning of the input. |
| `reverse` | `boolean` | `false` | Runs the mask in reverse — from right to left. |
| `show-mask` | `boolean` | `true` | Displays a live representation of the pattern’s placeholder as the internal value of the input. |
| `suffix` | `string` | `none` | Characters that will always appear at the end of the input. |
| `tokens` | `Object` | `{}` | Add new tokens or modify existing ones. |
| `unmask-value` | `boolean` | `false` | By default, the value of the input is the same as what is displayed (with formatting). The string literals will removed from the value if this prop is set to true. |

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

Additional slot data specific to the `mask` input:

| Property | Type | Description |
|----------|------|-------------|
| `mask` | `string` | The mask pattern string. |
| `mode` | `any` | The current mask input mode. |
| `showMask` | `boolean` | Whether placeholders are displayed. |
| `allowIncomplete` | `boolean` | Whether incomplete values are allowed. |
| `unmaskValue` | `boolean` | Whether the value should be unmasked (literals removed). |
| `reverse` | `boolean` | Whether the mask runs in reverse (right to left). |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the mask input. |
| `handlers.DOMInput` | `(e: InputEvent) => void` | Handles input events and applies the mask. |
| `handlers.blur` | `(e: FocusEvent) => void` | Handles blur events. |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |
| `part` | `overlayParts`, `overlayPlaceholder`, `overlayLiteral`, `overlayChar`, `overlayEnum` | `{ type: string; value: string }` | The current mask part being rendered (placeholder, literal, char, or enum). |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```

#### Basic structure
The mask input follows the standard text-family structure.
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

#### Overlay structure
When overlay is enabled, additional sections render styled text over the input.
- inner
  └─ prefixIcon
  └─ prefix
  └─ overlay
    └─ overlayInner
      └─ overlayParts
        └─ overlayPlaceholder
        └─ overlayLiteral
        └─ overlayChar
        └─ overlayEnum
  └─ input
  └─ suffix
  └─ suffixIcon
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
| `overlay` | `<div>` | Outer wrapper for the overlay used to style different parts of the mask text. |
| `overlayInner` | `<div>` | Inner wrapper immediately inside the overlay section. |
| `overlayParts` | `<div>` | Container for all overlay part elements (iterates over mask parts). |
| `overlayPlaceholder` | `<span>` | Overlay characters of type placeholder (unfilled positions). |
| `overlayLiteral` | `<span>` | Overlay characters of type literal (separators like /, -, etc.). |
| `overlayChar` | `<span>` | Overlay characters of type char (user-entered characters). |
| `overlayEnum` | `<span>` | Overlay characters of type enum (e.g., month names). |

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
| `tab` | While in select mode, moves forward through available mask selection ranges. If at the end of available selection ranges the focus will be moved to the next focusable element on the page. |
| `shift` + `tab` | While in select mode, moves backward through available mask selection ranges. if at the beginning of available selection ranges the focus will be moved to the previous focusable element on the page. |
| `up` + `down` | While in select mode, navigates through available options for selection ranges that are enum tokens. |
