# Inputs

FormKit ships with turbocharged inputs for developing production-ready forms in your project.

FormKit Inputs are similar to HTML inputs but turbocharged with much needed features like labels, help text, validation, and error messages (and much more). Similar to how HTML’s `<input>` tag uses various `type` attributes (i.e., `<input type="text">` vs `<input type="checkbox">`), FormKit uses the `type` prop for *all* inputs. In fact, with FormKit, **there is only 1 component you have to learn**:

### Example: Text input

#### single-component.react.jsx

```jsx
<FormKit type="text" />
      <FormKit type="textarea" />
```

FormKit Inputs are not confined to what is available in "native" HTML. Our seperate [FormKit Pro](/pro) package provides access to "synthetic" input types such as `repeater`, `autocomplete`, `mask`, `rating` and more. Of course, you can write your own inputs too by creating [custom inputs](/guides/create-a-custom-input).

### Example: Text input

#### single-component-pro.react.jsx

```jsx
<FormKit type="repeater" label="My Movies" addLabel="Add Movie">
        <FormKit
          name="movie"
          type="autocomplete"
          label="Search for a movie"
          placeholder="Ex: Interstellar"
          options={searchMovies}
        />
        <FormKit type="rating" label="My rating" />
      </FormKit>
```

## The Form Input

While you’re free to use FormKit inputs by themselves, you’ll usually want to [group them into a form](/inputs/form):

```
<FormKit type="form">
  <!-- ... your form inputs -->
</FormKit>

```

The [form type](/inputs/form) provides a host of features including value collection, initial value setting, form submission, error handling, loading states, and more.

## Setting values

There are 4 ways to set the value of an input:
- Using the `value` prop (Note: only sets *initial* value).
- Using `modelValue` together with `onUpdateModelValue`.
- Using FormKit's node `node.input()` method.
- Setting the value of a parent `FormKit` component.

### Using value prop

You can set the *initial* value of a single input or a group of inputs using the `value`
prop.

### Example: Value prop

#### value-prop.react.jsx

```jsx
<FormKit
        label="Username"
        type="text"
        help="Pick a new username"
        validation="required|matches:/^@[a-zA-Z]+$/|length:5"
        value="@FormKit"
      />
```

> **Warning:** The `value` prop should only be used for setting the *initial* value of an input. It will not react to changes after the component has been created.

### Using modelValue
In React, controlled FormKit inputs use the `modelValue` prop together with the `onUpdateModelValue` callback.
### Example: Input modelValue

#### v-model.react.jsx

```jsx
import { useState } from 'react'
import { FormKit } from '@formkit/react'

function VModelExample() {
  const [city, setCity] = useState('Florence')
  const cities = [
    'Prague',
    'Rome',
    'Berlin',
    'Amsterdam',
    'Barcelona',
    'London',
  ]

  function randomCity() {
    const index = Math.floor(Math.random() * (cities.length - 1))
    if (cities[index] !== city) {
      setCity(cities[index])
    } else {
      randomCity()
    }
  }

  return (
    <>
      <FormKit
        type="text"
        label="European city"
        help="What is your favorite European city?"
        modelValue={city}
        onUpdateModelValue={setCity}
      />
      <FormKit type="button" onClick={randomCity}>
        Random City
      </FormKit>
      <pre>{`City: ${city}`}</pre>
    </>
  )
}
```

### Using node.input()

At the heart of every FormKit input is an instance of [FormKit’s node
object](/essentials/architecture#node), and using the `node.input()` method is the most efficient mechanism to modify any input’s value (read more about [getting an instance of the node object](/essentials/architecture#getting-a-components-node)).

### Example: Node input

#### node-input.react.jsx

```jsx
import { useEffect } from 'react'
import { FormKit, useFormKitNodeById } from '@formkit/react'

function NodeInputExample() {
  const node = useFormKitNodeById('coffee')

  useEffect(() => {
    if (!node) return
    let index = 0
    const coffee = ['Latte', 'Americano', 'Doppio', 'Allonge', 'Macchiato']
    const interval = setInterval(() => {
      node.input(coffee[index])
      if (index < coffee.length - 1) index++
      else index = 0
    }, 250)
    return () => clearInterval(interval)
  }, [node])

  return (
    <FormKit
      label="Favorite type of coffee type?"
      id="coffee"
      help="What is your favorite type of coffee?"
    />
  )
}
```

> **Tip:** Calls to `node.input()` are debounced, and thus asynchronous (use the `delay` prop to change the length of the debounce). You can `await node.input(val)` to determine when the input has settled.

### Using a parent

Parent inputs like `list`, `group`, and `form` are also able to directly set the values of any of their children. In fact, the value of a parent is just the aggregate value of its children. You can use any of the above methods (`value`, `modelValue`, or `node.input()`) to set the value of the children.

### Example: Parent input

#### parent-input.react.jsx

```jsx
<FormKit
        type="group"
        name="address"
        value={{
          street: '456 Mangrove St',
          city: 'Franklin',
          state: 'ny',
        }}
      >
        <FormKit label="Street" name="street" />
        <FormKit name="city" label="City" />
        <FormKit
          type="select"
          name="state"
          label="State"
          options={{
            ca: 'California',
            ny: 'New York',
            va: 'Virginia',
          }}
        />
      </FormKit>
```

## Setting attributes

In nearly all cases, attributes set on the `<FormKit>` component will be passed through to the actual `<input>` element at the heart of the component, rather than any wrapping DOM elements. For example:

### Example: Text input

#### attributes.react.jsx

```jsx
<FormKit type="text" label="Favorite flavor" data-category="pizza" />
```

## Validation

We discuss validation in more detail on its [own documentation page](/essentials/validation) — but suffice to say adding validation rules to inputs in FormKit is as easy as adding the `validation` prop:

### Example: Simple validation

#### simple-validation.react.jsx

```jsx
<FormKit
        type="text"
        label="Username"
        validation="required|alpha|length:10"
      />
      {/* The input above has 3 validation rules:
          "required", "alpha", and "length" */}
```

## Debouncing

For performance, all FormKit inputs support debouncing as a first-class feature. While the value of an input changes on every keystroke (technically the `input` event), this newly updated value is only set internally — validation rules, groups, lists, forms, and (most) plugins are not yet “aware” a change has been made.

Internally, FormKit debounces the `input` event. When the debounce has "settled", the new value is “committed” and the rest of the application is then notified via the [input node’s commit event](/essentials/architecture#events). The default debounce delay is 20 milliseconds and can be adjusted with the `delay` prop or config option.

To illustrate this, let's get the `group`'s `value` from the `#default` slot prop and observe how it is not updated until after our 1000ms `delay`:

### Example: Delay prop

#### delay-prop.react.jsx

```jsx
<FormKit type="group">
        {({ value }) => (
          <>
            <FormKit
              name="email"
              type="email"
              label="Email"
              help="Notice it takes a full second for the data to update."
              delay={1000}
              validation="required|length:5|email"
              validationVisibility="live"
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

> **Info:** The delay prop’s default is `20` milliseconds. However, `group` and `list` inputs use `0` milliseconds by default to prevent the debounce delay from “building up” at each level of depth.

## Explicit errors

Validation errors are not the only way to set errors on an input. You can also explicitly set error messages on an input by using the `errors` prop.

### Example: Simple validation

#### simple-errors.react.jsx

```jsx
import { useState } from 'react'
import { FormKit } from '@formkit/react'

function SimpleErrorsExample() {
  const [fruit, setFruit] = useState('')
  const errors = fruit ? [`Sorry, we are sold out of ${fruit}`] : []

  return (
    <FormKit
      type="select"
      label="Fruit"
      placeholder="Select a fruit"
      modelValue={fruit}
      onUpdateModelValue={setFruit}
      options={['Apple', 'Peach', 'Pear']}
      errors={errors}
    />
  )
}
```

> **Info:** Explicitly set errors are non-blocking, meaning they do not prevent the form from submitting the way validation errors do. You can read more about error handling on the [form documentation](/inputs/form#error-handling).

## Props & attributes

FormKit inputs accept both *universal* props (ones that apply to all FormKit inputs), and *input-specific* props. The following table is a comprehensive list of props available to all FormKit inputs.

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

## Events

FormKit inputs emit both *universal* events (ones that are emitted from all inputs), and *input-specific* events. The following table is a comprehensive list of events emitted by all FormKit inputs.

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

> **Info:** The above are framework-level events emitted by FormKit's UI bindings. `@formkit/core` also emits [its own events](/essentials/architecture#core-events) as part of the lifecycle of [core nodes](/essentials/architecture#node).

## Sections

Inputs are composed of chunks of HTML called "sections". Each section has a "key" that can be used to target the section for a variety of purposes, like:

- Modifying the section's [classes](/essentials/styling#custom-classes) via `{section-key}-class="your-class"` props
- Overriding the section's structure with [slots](#slots): `<template #{section-key}>`
- Extending each [sections’s schema](#sections-schema)

Many section keys are universally available while others are specific to a given input type (you can define your own for custom inputs as well). The following table is a comprehensive list of those that are generally available in all inputs:

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

## Restructure markup

At times you may find it necessary to restructure the HTML inside a FormKit input, such as adding, editing, moving, or removing sections. This can be done by exporting the input (using the CLI tool), making the desired changes, and then using the modified input in your project. Read the [guide on exporting inputs](/guides/export-and-restructure-inputs) to learn how.

## Slots

Inputs can have their structure overridden with slots. You can precisely target where your slot content goes with [section keys](#sections). Slots are then are passed the [context object](/essentials/configuration) for use in their template.

For example, if we wanted to use a slot to define the label of an input, we could use a `label` slot to do so:

### Example: Label slot

#### label-slot.react.jsx

```jsx
import { FormKit } from '@formkit/react'

const airlines = {
  american: 'American Airlines',
  delta: 'Delta',
  easyjet: 'easyJet',
  jetblue: 'JetBlue',
  klm: 'KLM',
  lufthansa: 'Lufthansa',
}

function LabelSlotExample() {
  return (
    <FormKit
      label="Airlines"
      help="Which airlines do you prefer to fly on?"
      type="checkbox"
      options={airlines}
      optionClass="!mb-0"
      slots={{
        label: ({ option }) => (
          <img
            src={`https://cdn.formk.it/example-assets/airlines/${option.value}.png`}
            width="120"
            alt={option.label}
          />
        ),
      }}
    />
  )
}
```

> **Warning:** A disadvantage of using slots is you often need to re-create unrelated features to make the change you desire. For example, using slots would require you to re-implement any classes applied to those sections (which can be done by using `context.classes.sectionName`).

To help address this shortcoming, FormKit is also able to [selectively override/extend the underlying schema](#sections-schema) of each section allowing complex structural modification often with no loss of functionality.

## Sections schema

FormKit provides an additional mechanism to change the structure of a FormKit input called “sections schema”. Under the hood, all FormKit inputs are powered by [FormKit’s schema](/essentials/schema) — a JSON compatible data format for creating and storing DOM structure and logic. This allows tremendous structural flexibility because all inputs can have pieces of their schema extended via section keys without wholesale replacement of the template.

### Changing HTML tags

For example, by default FormKit uses an unordered list (`<ul>` and `<li>`) to output validation messages — but perhaps you need to use `<div>` tags. You can change these tags using the `schema` prop without having to re-create any functionality:

### Example: Sections schema

#### schema-overrides.react.jsx

```jsx
<FormKit
        label="Full name"
        help="Please provide your full name."
        sectionsSchema={{
          messages: { $el: 'div' },
          message: { $el: 'span' },
        }}
        validation="required|length:5"
        validationVisibility="live"
      />
      {/* Remove the sectionsSchema prop to see validation
          messages revert to their default HTML. */}
```

### Unwrapping or removing HTML tags

For accessibility and flexibility, FormKit uses several wrapper elements like the ones in the `wrapper` and `inner` [sections](#sections). However, perhaps on some inputs you need to remove a wrapper element to ensure other elements are adjacent. You can do this by providing a `null` value as the schema element:

### Example: No wrappers

#### schema-wrappers.react.jsx

```jsx
<FormKit
        type="checkbox"
        sectionsSchema={{
          outer: { $el: null },
          inner: { $el: null },
          messages: { $el: null },
          message: { $el: 'div' },
        }}
        validation="+accepted"
        validationVisibility="live"
        label="Terms and conditions"
        help="Do you accept our terms and conditions?"
      />
      {/* Remove the "inner" property of the schema object
          and see the inner wrapper reappear. */}
```

### Schema logic

Section schemas can also change the content being output using advanced schema logic. You could, for example, output a special value when your input’s value matches a particular string:

### Example: No wrappers

#### schema-content.react.jsx

```jsx
<FormKit
        type="text"
        label="Your name"
        help='Try entering the name "formkit".'
        sectionsSchema={{
          label: {
            children: [
              '$label',
              {
                if: '$value == "formkit"',
                then: {
                  $el: 'span',
                  attrs: {
                    style: { color: 'green' },
                  },
                  children: [
                    {
                      $el: 'span',
                      children: "That's our name too!",
                      attrs: {
                        class: 'ml-2',
                      },
                    },
                  ],
                },
              },
            ],
          },
        }}
        validationVisibility="live"
      />
```
