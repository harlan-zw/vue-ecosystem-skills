# Meta Input

A hidden input that stores arbitrary data.

> **Warning:** The `meta` input does not render any output to the DOM. It is used exclusively for including arbitrary data in your forms without displaying it to end users.

The `meta` input is meant to store arbitrary data that is not intended for display to end users. This input is hidden by default and can be used to store data that is not part of the form's schema.

Unlike the [hidden](/inputs/hidden) input (which renders an `<input type="hidden">` element), `meta` does not render *any* DOM elements so it’s value is in memory only and as such it can store any value type. In TypeScript its value is defined as `any`.

In React, you can still provide and read this value through `modelValue`, `onUpdateModelValue`, or the parent form's value object even though no DOM element is rendered.

## Basic example

### Example: Meta input

#### meta.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit name="name" label="Name" />
            <FormKit type="meta" name="metaDetails" value={extraData} />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

## Props & Attributes

The `meta` input has no unique props but can make use of the following universal
FormKit props.

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `config` | `Object` | `{}` | Configuration options to provide to the <a href= |
| `delay` | `Number` | `20` | Number of milliseconds to debounce an input’s value before the commit <a href= |
| `dirtyBehavior` | `string` | `touched` | Determines how the |
| `errors` | `Array` | `[]` | Array of strings to show as error messages on this field. |
| `help` | `String` | `-` | Text for help text associated with the input. |
| `id` | `String` | `input_{n}` | The unique id of the input. Providing an id also allows the input’s node to be globally accessed. |
| `ignore` | `Boolean` | `false` | Prevents an input from being included in any parent (group, list, form etc). Useful when using inputs for UI instead of actual values. |
| `index` | `Number` | `undefined` | Allows an input to be inserted at the given index if the parent is a list. If the input’s value is undefined, it inherits the value from that index position. If it has a value it inserts it into the lists’s values at the given index. |
| `label` | `String` | `-` | Text for the label element associated with the input. |
| `name` | `String` | `input_{n}` | The name of the input as identified in the data object. This should be unique within a group of fields. |
| `parent` | `FormKitNode` | `contextual` | By default the parent is a wrapping group, list or form — but this props allows explicit assignment of the parent node. |
| `prefix-icon` | `String` | `-` | Specifies <a href= |
| `preserve` | `Boolean` | `false` | Preserves the value of the input on a parent group, list, or form when the input unmounts. |
| `preserve-errors` | `Boolean` | `false` | By default errors set on inputs using setErrors are automatically cleared on input, setting this prop to true maintains the error until it is explicitly cleared. |
| `sections-schema` | `Object` | `{}` | An object of section keys and schema partial values, where each schema partial is applied to the respective section. |
| `suffix-icon` | `String` | `-` | Specifies <a href= |
| `type` | `String` | `text` | The type of input to render from the library. |
| `validation` | `String, Array` | `[]` | The <a href= |
| `validation-visibility` | `String` | `blur` | Determines when to show an input |
| `validation-label` | `String` | `{label prop}` | Determines what label to use in validation error messages, by default it uses the label prop if available, otherwise it uses the name prop. |
| `validation-rules` | `Object` | `{}` | Additional custom validation rules to make available to the validation prop. |
| `value` | `Any` | `undefined` | Seeds the initial value of an input and/or its children. Not reactive. Can seed <a href= |

## Sections

The `meta` input renders no output to the DOM so there are no sections to display. The `meta` input is used exclusively for including arbitrary data in your forms without displaying it to end users.
