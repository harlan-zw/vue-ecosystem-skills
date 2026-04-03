# Hidden Input

A native HTML hidden input.

> **Warning:** Since `hidden` inputs are not intended for display to end users, FormKit does not render common user-facing features such as the `label`, `help` , or `messages`.

Validation rules can still be applied to a hidden input that will prevent a form from submitting, but please note that the errors will not be displayed on this hidden input.

The `hidden` input uses HTML's native hidden input. It is not a visible element, and should only be used to provide data that is not entered by a user.

In React, hidden values are still best controlled through `modelValue`, `onUpdateModelValue`, or a parent form value object rather than by mutating the DOM directly.

## Basic example

### Example: Hidden input

#### hidden.react.jsx

```jsx
<FormKit name="user_id" type="hidden" value="user_32135" />
```

## Cast to number

By default all native HTML `<input>` elements return a string value. The `number` prop allows you to cast the value to a true `number` type. There are two valid values for the `number` prop: `float` and `integer`.

These options use `parseFloat` (default) or `parseInt` respectively. If the value cannot be parsed by the respective function it will set the value to `undefined`. Additionally applying the `number` prop will constrain the `value` of the input to be exclusively `number | undefined` in TypeScript.

### Example: Hidden cast input

#### hidden-cast.react.jsx

```jsx
<FormKit
            type="hidden"
            number="integer"
            name="account_id"
            value="98213321"
          />
          <pre>{JSON.stringify(value, null, 2)}</pre>
```

## Props & Attributes

The `hidden` input has only one unique prop, `number`, which can be used to cast the value of the input to a `number` type.

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `number` | `String` | `float` | Specifies how to cast a value to a number. Valid values are float and integer. |

## Sections

Hidden inputs do not render all of the surrounding markup typical of other inputs. As such, most section keys do not apply.

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
