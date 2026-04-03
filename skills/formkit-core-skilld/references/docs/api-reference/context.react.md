# The Context Object

FormKit provides a reactive context object to expose data to slots, rules, and the underlying schema that defines an input.

# Context object

## Introduction

FormKit inputs use a reactive object to expose data to template slots, rules, and the [schema](/essentials/schema) that defines each input. This is called the `context` object and is found in the each input's [core node object](/essentials/architecture#node) at `node.context`.

The context object, in general, can be thought of as a general purpose data store for each input. In almost all cases props passed to the `<FormKit>` component end up in the context object. The context object is the also the slot data passed to all section slots.

The context object always (unless noted) has the following properties:

## Properties

### _value

**Type:** Property

FormKit inputs have two values — the committed value (`node.value`) and the uncommitted value (`node._value`). At rest, these two values are equivalent, but the uncommitted value is the undebounced raw value of the input.
#### Signature
```
_value: any

```


### attrs

**Type:** Property

An object containing any attributes that will be passed to the internal input element.
#### Signature
```
attrs: Record<string, any>

```


### fns

**Type:** Property

A small object of utility functions that are useful when writing schemas.
#### Signature
```
fns: {
  // Returns the length of a given object
  length: (obj: Record<PropertyKey, any>) => number
  // Casts a value to a number
  number: (value: any) => number
  // Casts a value to a string
  string: (value: any) => string
  // Returns the JSON representation of a value
  json: (value: any) => string | false
}

```


### handlers

**Type:** Property

A small object of common input handlers for use in the schema. Keep in mind that input "features" can replace or add to handlers on an input by input basis.
#### Signature
```
handlers: {
  // sets the state.blurred value to true
  blur: () => void
  // sets the state.touched value to true
  touch: () => void
  // Sets the value of the input
  DOMInput: (e: Event) => void
}

```


### help

**Type:** Property

The help text of the input provided by the `help` prop.
#### Signature
```
help: string | undefined

```


### id

**Type:** Property

The unique identifier of the input. This value is auto-generated unless the `id` prop is set.
#### Signature
```
id: string

```


### label

**Type:** Property

The label of the input provided by the `label` prop.
#### Signature
```
label: string | undefined

```


### messages

**Type:** Property

An object of *visible* messages (where the type is not `ui`). The key of this object is the message name, and the value is a core message object.
#### Signature
```
messages: Record<string, FormKitMessage>

```
#### Example
For an input displaying a single failing validation message, this object would look like:
```
{
  rule_required: {
    // Determines if the message prevents form submission
    blocking: true,
    // The unique key of this message
    key: 'rule_required',
    // Additional details about the message
    meta: {
      // The name of the validation message (used in message lookups)
      messageKey: 'required',
      // Arguments that can be used in i18n translation
      i18nArgs: [{
        node,
        name: 'email',
        args: []
      }]
    },
    // The "type" of message — generally the plugin that generated it.
    type: 'validation',
    // The value of the message
    value: 'Email is required',
    // If this message is intended to be displayed to end users
    visible: true
  }
}

```


### node

**Type:** Property

The underlying [core node](/essentials/architecture) of the current input. This object is not reactive (within the context of Vue).
#### Signature
```
node: FormKitNode

```


### options

**Type:** Property

For inputs that accept an options prop, this is a normalized array of option objects.
#### Signature
```
options: Array<{ label: string; value: any; attrs?: Record<string, any> }> | undefined

```


### option

**Type:** Property

For inputs that accept an options prop, this object is available to [section keys](/essentials/inputs#sections) that are inside the iteration (i.e., the `label` section key on a `checkbox` input with multiple checkboxes).
#### Signature
```
option: {
  value: any
  label: string
  attrs?: Record<string, any>
}

```
#### Example
```
{
  value: 'foo',
  label: 'Foo',
  attrs: {
    disabled: true
  }
}

```


### state

**Type:** Property

Current state of the input.
#### Signature
```
state: {
  // If the input has been blurred
  blurred: boolean

  // True when the input is "complete" - either:
  // - Has validation rules, all passing, no errors
  // - Or: no validation rules, no errors, is dirty and has a value
  complete: boolean

  // If the owning component has mounted to the DOM
  didMount: boolean

  // Controlled by dirty-behavior prop. By default true after any mutation.
  // With dirty-behavior="compare", compares current vs initial value.
  dirty: boolean

  // If the input has explicit errors, or any children have errors
  errors: boolean

  // Loading state - only present while loading, removed when complete
  loading: true | undefined

  // If the input has the "required" validation rule
  required: boolean

  // True when the input has validation rules (regardless of state)
  rules: boolean

  // True when debounce cycle is complete and value was committed
  settled: boolean

  // If the form has been submitted
  submitted: boolean

  // If passing all validation rules (includes children for groups/forms/lists)
  valid: boolean

  // If currently validating (including async rules) - from @formkit/validation
  validating?: boolean

  // If validation-visibility is satisfied and messages should display
  validationVisible: boolean
}

```


### type

**Type:** Property

The type of the input provided by the `type` prop. This is the value that should be referenced when looking up definitions in a library of inputs.
#### Signature
```
type: string

```
#### Examples
`text`, `select`, `autocomplete`


### ui

**Type:** Property

An object of visible messages (keyed by the `key`) of type `ui` that can be used in the interface. This allows for localized text for use on interface elements.
#### Signature
```
ui: Record<string, FormKitMessage>

```


### classes

**Type:** Property

A Proxy object for requesting classes. This object allows schema authors to request any [section](/essentials/inputs#sections) and get a generative class name.
#### Signature
```
classes: Proxy<Record<string, string>>

```
#### Examples
- `$classes.input` returns `formkit-input` (by default)
- `$classes.foobar` returns `formkit-foobar`

