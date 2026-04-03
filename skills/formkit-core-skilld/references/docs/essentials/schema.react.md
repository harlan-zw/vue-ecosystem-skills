# FormKit Schema

Harness all the power of FormKit in a serializable, JSON-compatible schema language.

# Schema

## Introduction

FormKit's schema is a JSON-serializable data format for storing DOM structures and component implementations, including FormKit forms. Although created specifically for implementing and generating forms, the format is capable of generating any HTML markup or using any third-party components.

Schemas are rendered using FormKit's `<FormKitSchema>` component, which is not registered globally by default. You will need to import it:

```
import { FormKitSchema } from '@formkit/vue'

```

## Form generation example

FormKit ships with first-class support for generating forms using schema. This makes it possible to store generated forms in databases, files, or even QR codes! To generate a form, pass your schema array to the `<FormKitSchema>` component using the `:schema` prop.

```
<FormKitSchema :schema="yourSchemaArray" />

```

Let’s look at a quick example:

### Example: Generating forms

#### generating.react.jsx

```jsx
const schema = [
  {
    $el: 'h1',
    children: 'Register',
    attrs: {
      class: 'text-2xl font-bold mb-4',
    },
  },
  {
    $formkit: 'text',
    name: 'email',
    label: 'Email',
    help: 'This will be used for your account.',
    validation: 'required|email',
  },
  {
    $formkit: 'password',
    name: 'password',
    label: 'Password',
    help: 'Enter your new password.',
    validation: 'required|length:5,16',
  },
  {
    $formkit: 'password',
    name: 'password_confirm',
    label: 'Confirm password',
    help: 'Enter your new password again to confirm it.',
    validation: 'required|confirm',
    validationLabel: 'password confirmation',
  },
  {
    $cmp: 'FormKit',
    props: {
      name: 'eu_citizen',
      type: 'checkbox',
      id: 'eu',
      label: 'Are you a european citizen?',
    },
  },
  {
    $formkit: 'select',
    if: '$get(eu).value',
    name: 'cookie_notice',
    label: 'Cookie notice frequency',
    options: {
      refresh: 'Every page load',
      hourly: 'Ever hour',
      daily: 'Every day',
    },
    help: 'How often should we display a cookie notice?',
  },
]
```

We see many features above including the `$el` and `$cmp` props, the `$formkit` prop shorthand, validation, conditional rendering, labels, help text, and multiple types of inputs. We'll unpack all these features in the remainder of this page.

## Schema array

A schema is an array of objects or strings (called "schema nodes"), where each array item defines a single schema node. There are 3 types of of schema nodes:

1. **Text nodes** — produced by strings.
2. [HTML elements](#html-elements-el) — defined by the `$el` property.
3. [Components](#components-cmp) — defined by the `$cmp` property.
4. [FormKit components](#shorthand) — defined by the `$formkit` property. Syntactic sugar for the full `$cmp` format.

Schemas support advanced features like [conditional logic](#conditionals), [boolean operators](#expressions), [loops](#loops), [slots](#slots), and [data scoping](#references) — all guaranteed to serialize to a string.

## HTML elements ($el)

HTML elements are defined using the `$el` property. You can use `$el` to render any HTML element. Attributes can be added with the `attrs` property, and content is assigned with the `children` property:

### Example: Schema - elements

#### schema-elements.react.jsx

```jsx
const schema = [
  {
    $el: 'div',
    attrs: {
      style: { color: 'red' },
      'data-foo': 'bar',
    },
    children: 'Hello world',
  },
]
```

> **Tip:** Notice in the above example that the `style` attribute is unique in that it should be defined as an object of style to value pairs rather than a string.

## Components ($cmp)

Components can be defined with the `$cmp` property. The `$cmp` property should be a string that references a globally defined component or a component passed
into `FormKitSchema` with the `library` prop:

### Example: Schema - components

#### schema-components.react.jsx

```jsx
import { FormKitSchema } from '@formkit/react'

function CustomComponent({ name }) {
  return <>Hello {name}</>
}

const library = {
  MyComponent: CustomComponent,
}

const schema = [
  {
    $cmp: 'MyComponent',
    props: {
      name: 'Jane',
    },
  },
]

function Example() {
  return <FormKitSchema schema={schema} library={library} />
}
```

> **Warning:** In order to pass concrete components via the `library` prop, it's best to pass stable component references through the <code>library</code> prop.

## References

In addition to the schema array (and optional library), the `FormKitSchema` object can also include a `data` prop. Values from the data object can then be referenced directly in your schema — and your schema will maintain the reactivity of the original data object.

To reference a value from the data object, you use a dollar sign `$` followed by the property name from the data object. References can be used in `attrs`, `props`, conditionals and as `children`:

### Example: Schema - data

#### schema-data.react.jsx

```jsx
import { useState } from 'react'
import { FormKit, FormKitSchema } from '@formkit/react'

const schema = [
  {
    $el: 'h1',
    children: ['Hello ', '$location'],
    attrs: {
      class: 'text-2xl font-bold mb-4',
    },
  },
]

function Example() {
  const [location, setLocation] = useState('World')
  const data = { location }

  function move() {
    setLocation((current) => (current === 'World' ? 'Mars' : 'World'))
  }

  return (
    <>
      <FormKitSchema schema={schema} data={data} />
      <FormKit type="button" onClick={move}>
        Change location
      </FormKit>
    </>
  )
}
```

> **Warning:** Notice in the above example that we used an array to concatenate "Hello" and "$location". We did this because data references and logical expressions in the schema must always begin with a dollar sign `$` — otherwise they are treated as unparsed string literals.

### Referencing functions

Schemas support calling functions that are in your original reference data — and you can even pass data references as arguments of that function!

### Example: Schema - functions

#### schema-functions.react.jsx

```jsx
import { useState } from 'react'
import { FormKit, FormKitSchema } from '@formkit/react'

const schema = [
  {
    $el: 'h1',
    children: ['$count', ' + 5 = ', '$add($count, 5)'],
    attrs: {
      class: 'text-2xl font-bold mb-4',
    },
  },
]

function Example() {
  const [count, setCount] = useState(3)
  const data = {
    count,
    add: (a, b) => a + b,
  }

  return (
    <>
      <FormKitSchema schema={schema} data={data} />
      <FormKit type="button" onClick={() => setCount((current) => current + 1)}>
        Add To Count
      </FormKit>
    </>
  )
}
```

### Deep references

Just like JavaScript — you can access properties of a deeply nested object using dot-syntax `object.property`:

### Example: Schema - functions

#### schema-dot-syntax.react.jsx

```jsx
import { FormKitSchema } from '@formkit/react'

const schema = [
  {
    $el: 'h1',
    children: '$orchard.tree.fruit',
    attrs: {
      class: 'text-2xl font-bold mb-4',
    },
  },
]

const data = {
  orchard: {
    tree: {
      fruit: 'apple',
    },
  },
}

function Example() {
  return <FormKitSchema schema={schema} data={data} />
}
```

> **Info:** Schema references can have any structure or properties, but at the root of the data reference object there are 2 reserved words: `$slots` and `$get`.

## Expressions

Schemas also support logic in the form of boolean logic, comparison, and arithmetic expressions. These expressions can be used anywhere a data reference can be used (`attrs`, `props`, conditionals, and `children`):

### Example: Schema - expressions

#### schema-expressions.react.jsx

```jsx
import { useMemo, useState } from 'react'
import { FormKit, FormKitSchema } from '@formkit/react'

const schema = [
  {
    $el: 'div',
    children: '$: "Qty: " + $count + " x " + $format($price)',
  },
  {
    $el: 'div',
    children: ['Shipping: ', '$format($ship)'],
  },
  {
    $el: 'div',
    children: ['Total: ', '$format(($count * $price) + $ship)'],
  },
]

function Example() {
  const [count, setCount] = useState(1)
  const format = useMemo(
    () =>
      Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format,
    []
  )
  const data = {
    count,
    price: 15.29,
    ship: 9.99,
    format,
  }

  return (
    <>
      <FormKitSchema schema={schema} data={data} />
      <FormKit
        type="button"
        onClick={() => setCount((current) => current + 1)}
        outerClass="mt-6"
      >
        Add to cart
      </FormKit>
    </>
  )
}
```

> **Tip:** Expressions must always begin with a `$`. If the first element of an expression is a data reference (ex: `$count + 2`), then it already begins with a `$` and no further labeling is required. However, often the first character of an expression is not a dollar sign — these expressions need to be "labeled" with `$:` — for example `$: ($count * 3) - 7`.

Although it looks very much like JavaScript — *schema expressions are not JavaScript*. They are better thought of as a templating language. Expressions are compiled down to functional JavaScript at `setup` but the syntax is not 1-1 compatible with JavaScript. This improves performance and provides a critical layer of security as only explicitly exposed data and functionality can be executed.

Schema expressions are limited to the following operators and parenthesis:

| Operator | Use case |
| --- | --- |
| + | Addition |
| - | Subtraction |
| * | Multiplication |
| / | Division |
| % | Modulus |
| && | Boolean AND |
| || | Boolean OR |
| === | Strict equals |
| !== | Strict not equals |
| == | Loose equals |
| != | Loose not equals |
| >= | Greater than or equal |
| <= | Less than or equal |
| > | Greater than |
| < | Less than |

## Conditionals

FormKit schema can leverage references and expressions to make schema nodes and attributes conditional. These conditionals can be added in two ways:

- The `if` property on `$el` and `$cmp` nodes.
- The `if/then/else` object

### The if property

Both `$el` and `$cmp` schema nodes can leverage an `if` property that roughly equates to conditional rendering in React. If the expression assigned to the `if` property is truthy, the node is rendered, otherwise it is not:

### Example: Schema - conditional

#### schema-conditional.react.jsx

```jsx
import { useState } from 'react'
import { FormKit, FormKitSchema } from '@formkit/react'

const schema = [
  {
    $el: 'h2',
    if: '$value >= 5 && $value <= 10',
    children: '$value + " is between 5-10!"',
  },
]

function Example() {
  const [value, setValue] = useState(0)
  const data = { value }

  return (
    <>
      <FormKit
        type="number"
        modelValue={value}
        onUpdateModelValue={setValue}
        label="Enter a number between 5-10"
      />
      <FormKitSchema schema={schema} data={data} />
    </>
  )
}
```

> **Tip:** Conditional or iterative (when using `if` or `for`) schema nodes should always include an explicit `key` prop. Without it, the rendering layer may reuse previous DOM nodes in ways that can lead to unexpected behavior, errors, and performance issues.

### The if/then/else object

The `if/then/else` object allows for more complex conditional logic. It can be used to conditionally render nodes, a list of schema nodes, values of the `attrs` object or values of the `props` object. It is also possible to nest `if/then/else` objects to create more complex structures — similar to an `else if` statement in JavaScript.

#### Using if/then/else on schema nodes

You can use the `if/then/else` object anywhere you would normally use a schema node. This includes the root schema array, or the `children` property of another schema node:

> **Tip:** Conditional or iterative (when using `if` or `for`) schema nodes should always include an explicit `key` prop. Without it, the rendering layer may reuse previous DOM nodes in ways that can lead to unexpected behavior, errors, and performance issues.

### Example: Schema - conditional object

#### schema-conditional-object.react.jsx

```jsx
import { useState } from 'react'
import { FormKit, FormKitSchema } from '@formkit/react'

const schema = [
  {
    $el: 'h2',
    children: {
      if: '$value < 5',
      then: '$value + " is less than 5"',
      else: {
        if: '$value >= 5 && $value <= 10',
        then: '$value + " is between 5 and 10"',
        else: '$value + " is more than 10"',
      },
    },
    attrs: {
      class: 'text-xl font-bold',
    },
  },
]

function Example() {
  const [value, setValue] = useState(0)
  const data = { value }

  return (
    <>
      <FormKit
        type="number"
        modelValue={value}
        onUpdateModelValue={setValue}
        label="Enter a number between 5-10"
      />
      <FormKitSchema schema={schema} data={data} />
    </>
  )
}
```

#### Using if/then/else on attrs and props

You can also use `if/then/else` statements to conditionally output the values of `attrs` or `props`:

### Example: Schema - conditional attrs

#### schema-conditional-attrs.react.jsx

```jsx
import { useState } from 'react'
import { FormKit, FormKitSchema } from '@formkit/react'

const schema = [
  {
    $el: 'h1',
    if: '$drink',
    attrs: {
      style: {
        color: {
          if: '$drink == Vodka',
          then: 'blue',
          else: {
            if: '$drink == Whisky',
            then: 'brown',
            else: 'tan',
          },
        },
      },
    },
    children: '$drink',
  },
]

function Example() {
  const [drink, setDrink] = useState(null)
  const data = { drink }

  return (
    <>
      <FormKit
        type="select"
        modelValue={drink}
        onUpdateModelValue={setDrink}
        label="Select a spirit"
        placeholder="Select a spirit"
        options={['Vodka', 'Whisky', 'Rum']}
        help="Select your favorite base for cocktails."
      />
      <FormKitSchema schema={schema} data={data} />
    </>
  )
}
```

## Loops

Both `$el` and `$cmp` schema nodes support looping. The loop syntax is similar to mapping over an array in React. It expects an object or array to iterate over and a property to assign the current iteration value to. Optionally, you can also capture the index or property of the current iteration:

> **Tip:** Conditional or iterative (when using `if` or `for`) schema nodes should always include an explicit `key` prop. Without it, the rendering layer may reuse previous DOM nodes in ways that can lead to unexpected behavior, errors, and performance issues.

### Example: Schema - loops

#### schema-loops.react.jsx

```jsx
import { useState } from 'react'
import { FormKit, FormKitSchema } from '@formkit/react'

const schema = [
  {
    $el: 'ul',
    attrs: {
      class: 'city-list',
    },
    children: [
      {
        $el: 'li',
        for: ['item', 'key', '$cities'],
        children: '$: ($key + 1) + ": " + $item',
      },
    ],
  },
]

function Example() {
  const [cities, setCities] = useState(['Boston', 'Amsterdam', 'Nairobi'])
  const [city, setCity] = useState('')
  const data = { cities }

  function addCity() {
    setCities((current) => current.concat(city))
    setCity('')
  }

  return (
    <>
      <FormKit
        type="text"
        label="Add a city"
        help="Add a city and hit enter"
        modelValue={city}
        onUpdateModelValue={setCity}
        onKeyUp={(event) => {
          if (event.key === 'Enter') addCity()
        }}
      />
      <FormKitSchema schema={schema} data={data} />
    </>
  )
}
```

## Slots

Schemas can render the slot content of the `<FormKitSchema>` component anywhere within the schema that a normal schema node can be rendered. All scoped slots are automatically provided to the schema under the `$slots` reference object:

### Example: Schema - slots

#### schema-slots.react.jsx

```jsx
import { useEffect, useState } from 'react'
import { FormKitSchema } from '@formkit/react'

const schema = [
  {
    $el: 'h1',
    children: 'Fast click game',
    attrs: {
      class: 'text-2xl font-bold mb-4',
    },
  },
  {
    $formkit: 'button',
    onClick: '$handleClick',
    children: '$slots.default',
  },
  {
    $el: 'p',
    children: [
      {
        if: '$state === "won"',
        then: {
          $el: 'span',
          attrs: {
            style: { color: 'green' },
          },
          children: 'You won!!!!',
        },
        else: {
          if: '$state === "lost"',
          then: {
            $el: 'span',
            attrs: {
              style: { color: 'red' },
            },
            children: 'Sorry, you lost - try again!',
          },
          else: 'Try to click when the button reads between 500 and 600!',
        },
      },
    ],
  },
]

function Example() {
  const [state, setState] = useState('play')
  const [label, setLabel] = useState(0)

  function handleClick() {
    if (label >= 500 && label <= 600) {
      setState('won')
    } else {
      setState('lost')
    }
  }

  useEffect(() => {
    if (state !== 'play') return
    const timer = setTimeout(() => {
      setLabel((current) => (current >= 1000 ? 0 : current + 10))
    }, 10)
    return () => clearTimeout(timer)
  }, [label, state])

  useEffect(() => {
    if (state === 'play') return
    const timer = setTimeout(() => {
      setState('play')
    }, 2000)
    return () => clearTimeout(timer)
  }, [state])

  const data = {
    state,
    label,
    handleClick,
  }

  return (
    <FormKitSchema
      schema={schema}
      data={data}
      slots={{
        default: ({ label: slotLabel } = {}) => (
          <span style={{ width: '6em' }}>{slotLabel}</span>
        ),
      }}
    />
  )
}
```

> **Tip:** Inside of a `$formkit` schema node, it is also possible to pass content to preexisting FormKit slots like `label` or `prefix` inside of the node's `__raw__sectionsSchema` property. Read more about raw values [below](#raw-values), and `sectionsSchema` in the [inputs documentation](/essentials/inputs#sections-schema).

## Binding attrs and props

At times it may be necessary to pass an object of variable or unknown attributes or props to a `$cmp` or `$el`. In React you would typically do this with object spread props. In schema land, you use the `bind` property:

### Example: Schema - bind

#### schema-bind.react.jsx

```jsx
import { useState } from 'react'
import { FormKitSchema } from '@formkit/react'

const schema = [
  {
    $el: 'h1',
    bind: '$someAttributes',
    children: 'Click me!',
  },
]

function Example() {
  const [colorClass, setColorClass] = useState('!text-red-500')
  const data = {
    someAttributes: {
      class: colorClass,
      onClick: () => {
        setColorClass((current) =>
          current === '!text-red-500' ? '!text-blue-500' : '!text-red-500'
        )
      },
      'data-fruit': 'I like fruit',
    },
  }

  return <FormKitSchema schema={schema} data={data} />
}
```

## Raw values

At times it may be necessary to prevent a given attribute or prop from being parsed. This can be done by prefixing an attribute or prop with `__raw__`:

```
{
  $cmp: 'PriceComponent',
  props: {
    __raw__price: '$2.99'
  }
}

```

In the above example, the `__raw__` prefix will be removed, and the unparsed value of `$2.99` will be passed as the `price` prop to the `PriceComponent`.

Another scenario where this comes into play is rendering FormKit components. The `<FormKit>` component has a `sections-schema` prop that allows users to pass down schema partials to merge with various sections of their input. In this edge case, we want to pass the schema chunks to the `<FormKit>` component as a raw JavaScript object. To do so, we once again prefix the `sectionsSchema` prop with `__raw__`:

### Example: Schema - **raw**

#### schema-raw.react.jsx

```jsx
import { FormKitSchema } from '@formkit/react'

const data = {
  field: 'Username',
}

const schema = [
  {
    $cmp: 'FormKit',
    props: {
      type: 'text',
      label: '$field',
      __raw__sectionsSchema: {
        prefix: {
          $el: 'div',
          attrs: {
            class:
              '$classes.prefix + " py-0 px-2 text-sm stretch flex items-center bg-gray-200 mr-2 rounded dark:bg-gray-800"',
          },
          children: '$label',
        },
      },
    },
  },
]

function Example() {
  return <FormKitSchema data={data} schema={schema} />
}
```

Notice if you remove the `__raw__` prefix from the above example, the prefix no longer has effect — this is because the `sectionsSchema` prop’s value was parsed when creating the component instead of passed as a JavaScript object.

## FormKit Inputs

Although schemas can be used for almost any purpose — the primary objective is to empower developers to build complex and dynamic forms using a serializable data format. Using the schema with FormKit Inputs covers this use case well.

Assuming you globally registered the `FormKit` component — you can render your `FormKit` inputs from schema by using the `$cmp` type schema node:

### Example: Schema - formkit

#### schema-formkit.react.jsx

```jsx
import { FormKitSchema } from '@formkit/react'

const schema = [
  {
    $cmp: 'FormKit',
    props: {
      type: 'radio',
      label: 'Income',
      help: 'Select your household income',
      options: [
        { value: 20000, label: '<= $20,000' },
        { value: 40000, label: '$21k - $40k' },
        { value: 80000, label: '$41k - $80k' },
        { value: 130000, label: '$81k - $130k' },
        { value: 250000, label: '$131k - $250k' },
      ],
      validation: 'required|min:250000',
      validationVisibility: 'dirty',
      validationMessages: {
        min: 'Sorry, only wealthy people can get loans from the bank.',
      },
    },
  },
  {
    $cmp: 'FormKit',
    props: {
      type: 'select',
      label: 'Marital status',
      options: ['Married', 'Single', 'Divorced', 'Engaged'],
    },
  },
]

function Example() {
  return (
    <>
      <h2>Loan application</h2>
      <FormKitSchema schema={schema} />
    </>
  )
}
```

### Shorthand

While the `cmp` syntax is generalized and works for any framework component, it is somewhat verbose for FormKit Inputs. To make this easier, FormKit supports a fourth node type `$formkit`, which is syntactic sugar for the full `$cmp` format.

When using the `$formkit` shorthand, the `props` object is flattened with the top-level properties (siblings of `$formkit`) For example:

### Example: Generating forms - sugar

#### generating-sugar.react.jsx

```jsx
<FormKitSchema
        schema={[
          {
            $formkit: 'email',
            label: 'Email address',
            help: 'Please enter your email address.',
          },
        ]}
      />
```

### Accessing other inputs

The schema format has one built-in function specific to FormKit Inputs: the `$get` function. This builtin allows the schema to access the context object of any other FormKit Input (even outside the immediate form) — provided the input in question has an explicitly declared `id` prop. This allows the schema to respond conditionally to the state of your own inputs:

### Example: Schema - formkit

#### schema-get.react.jsx

```jsx
import { FormKitSchema } from '@formkit/react'

const schema = [
  {
    $cmp: 'FormKit',
    props: {
      type: 'select',
      id: 'drink',
      label: 'Drink',
      placeholder: 'Pick your drink',
      options: {
        coffee: 'Drip coffee',
        espresso: 'Espresso shot',
        tea: 'Tea',
      },
      validation: 'required',
    },
  },
  {
    $cmp: 'FormKit',
    if: '$get(drink).value',
    props: {
      type: 'radio',
      label: '$: "Drink options (" + $get(drink).value + ")"',
      options: {
        if: '$get(drink).value === coffee',
        then: ['Large', 'Medium', 'Small'],
        else: {
          if: '$get(drink).value === espresso',
          then: ['Single shot', 'Double shot'],
          else: ['Earl grey', 'Matcha', 'Green tea', 'Jasmine'],
        },
      },
    },
  },
]

function Example() {
  return (
    <>
      <h2 className="text-2xl font-bold mb-4">Order a beverage</h2>
      <FormKitSchema schema={schema} />
    </>
  )
}
```

### Forms

To render a form element, you can either use the `$formkit: 'form'` schema node, or wrap your `<FormKitSchema>` component in a `<FormKit type="form">` component:

### Example: Generating forms - form

#### generating-form.react.jsx

```jsx
import { FormKit, FormKitSchema } from '@formkit/react'

const schema = [
  {
    $formkit: 'email',
    label: 'Email address',
    validation: 'required',
  },
]

function Example() {
  return (
    <FormKit type="form" onSubmit={() => false}>
      <FormKitSchema schema={schema} />
    </FormKit>
  )
}
```
