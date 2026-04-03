# Create a custom input

Follow this guide to learn how to create, register, and use a custom FormKit input in your project.

In this guide, we’ll walk through the process of creating, registering, and using a custom input. Specifically, we’re going create a "one-time password" input ("OTP" for short). OTPs are commonly used for two-factor authentication when a user is required to type in a code sent via SMS or authenticator app. Let’s get started!

> **Tip:** This guide assumes you are using a standard build tool that supports your framework’s component format.

## Creating a component

To get started, let's create our input’s component file. We'll call it <code>one-time-password.react.jsx</code>:

```
export default function OneTimePassword({ context }) {
  return <div>More to come here...</div>
}

```

FormKit provides a lot of input features out-of-the-box that we're going to want to preserve — like labels, help text, and showing error messages. All we really want to modify is the input section of our input. We can preserve these standard FormKit features by using the `createInput` utility function from <code>@formkit/react</code>.

As we build out our input, we’ll want to visualize its progress, so let’s create a sample form to:

1. Import <code>one-time-password.react.jsx</code>
2. Pass that imported component to `createInput()`
3. Use the return value (an [input definition](/essentials/custom-inputs#input-definition)) as the `type` prop of a `<FormKit>` component.

We’ll call this sample form <code>register.react.jsx</code>:

### Example: One-time password - register

#### register.react.jsx

```jsx
import { FormKit, createInput } from '@formkit/react'
import OneTimePassword from './_examples__otp-register__one-time-password.react.jsx'

const otp = createInput(OneTimePassword)

function RegisterExample() {
  const [values, setValues] = useState({})

  return (
    <>
      <FormKit
        type="form"
        modelValue={values}
        onUpdateModelValue={(value) => setValues(value ?? {})}
      >
        <FormKit
          type={otp}
          label="One-time password"
          name="two_factor_code"
          help="We’ve sent a code to your phone."
          validation="required"
          validationVisibility="live"
        />
      </FormKit>

      <pre>{JSON.stringify(values, null, 2)}</pre>
    </>
  )
}
```

#### one-time-password.react.jsx

```jsx
export default function OneTimePassword({ context }) {
  return <div>More to come here...</div>
}
```

Excellent! Now we can iterate on our component file and see the results. One of the first things to notice is how our input already supports labels, help text, validation, and other universal FormKit props. Those features come courtesy of `createInput()`.

Also, notice that `<pre>` tag in the above example? It is outputting the current state of the form’s data. We'll use this visualize the value of our custom input. Since our input currently has no value, it does not appear in the form’s data. Time to change that!

## Input & output

Let’s open up our component file again and change our `<div>` to an `<input>` tag. We’ll start with a single text input, and work our way up from there. But how do we actually set and display the value of our custom input?

All custom inputs are passed the almighty [context object](/essentials/configuration) as the `context` prop. In order for our input to *set* its value, it needs to call `context.node.input(value)`. To properly *display* the value of our input, we should set the input’s `:value` attribute to `context._value`.

### Example: One-time password - first value

#### register.react.jsx

```jsx
import { FormKit, createInput } from '@formkit/react'
import OneTimePassword from './_examples__otp-first-value__one-time-password.react.jsx'

const otp = createInput(OneTimePassword)

function FirstValueExample() {
  const [values, setValues] = useState({})

  return (
    <>
      <FormKit
        type="form"
        modelValue={values}
        onUpdateModelValue={(value) => setValues(value ?? {})}
      >
        <FormKit
          type={otp}
          label="One-time password"
          name="two_factor_code"
          help="We’ve sent a code to your phone."
          validation="required"
          validationVisibility="live"
        />
      </FormKit>

      <pre>{JSON.stringify(values, null, 2)}</pre>
    </>
  )
}
```

#### one-time-password.react.jsx

```jsx
export default function OneTimePassword({ context }) {
  function handleInput(event) {
    context.node.input(event.target.value)
  }

  return (
    <input
      onInput={handleInput}
      value={context._value}
      className="border border-gray-700"
    />
  )
}
```

Our little baby input is all grown up! It might not look pretty, but it now reads and writes values. As proof, try setting the initial value of the form’s `values` object to `{ two_factor_code: '12345' }` and you'll see the input gets auto-populated with the value.

## Requirements for our input

Ok, now that we understand how to create an input, how to use it, and how to read and write values — let’s tackle the actual "business logic" of our one-time password input. Here are our requirements:

- Users enter a series of digits, and each digit has its own `<input>` tag.
- The value of the input should always be all the digits concatenated.
- We only want the input to change its value if all digits have been completed (no need to commit and validate on each keystroke if the user is not done).
- It should allow a user to click on a given digit to edit it.
- When a user types a number, it should automatically focus on the next input.
- It should support copy/paste.

## Adding a prop

For our first requirement, we need `n` `<input>` tags. Perhaps it would be best to expose the number of digits as a prop. To do that, we need to inform our `createInput` function that we want to accept a new prop:

```
createInput(one-time-password, {
  props: ['digits'],
})

```

We now have access to `context.digits`. Back in `one-time-password.vue`, let's use that to output the correct number of `<input>` tags.

### Example: One-time password - input tags

#### register.react.jsx

```jsx
import { FormKit, createInput } from '@formkit/react'
import OneTimePassword from './_examples__otp-tags__one-time-password.react.jsx'

const otp = createInput(OneTimePassword, {
  props: ['digits'],
})

function OtpTagsExample() {
  const [values, setValues] = useState({})

  return (
    <>
      <FormKit
        type="form"
        modelValue={values}
        onUpdateModelValue={(value) => setValues(value ?? {})}
      >
        <FormKit
          type={otp}
          digits="4"
          label="One-time password"
          name="two_factor_code"
          help="We’ve sent a code to your phone."
          validation="required"
          validationVisibility="live"
        />
      </FormKit>

      <pre>{JSON.stringify(values, null, 2)}</pre>
    </>
  )
}
```

#### one-time-password.react.jsx

```jsx
export default function OneTimePassword({ context }) {
  const digits = Number(context.digits)

  function handleInput(event) {
    context.node.input(event.target.value)
  }

  return (
    <>
      {Array.from({ length: digits }, (_, index) => (
        <input
          key={index}
          maxLength={1}
          className={context.classes.digit}
          value={context._value}
          onInput={handleInput}
        />
      ))}
    </>
  )
}
```

#### formkit.config.react.jsx

```jsx
import { genesisIcons } from '@formkit/icons'
import { defineFormKitConfig } from '@formkit/react'

export default defineFormKitConfig({
  icons: {
    ...genesisIcons,
  },
  config: {
    classes: {
      digit:
        'text-xl w-10 h-10 border bg-transparent border-gray-300 rounded-md text-center mr-1 mb-2 last:mr-0 dark:border-gray-800',
    },
  },
})
```

OK — we have multiple inputs! Our first requirement is complete:

- Users enter a series of digits, and each digit has its own `<input>` tag.

> **Tip:** We’ve added a touch of CSS in the above example, but in general we’re not going to dive into styling in this guide. It is recommended to use `context.classes.yourKey` as the class name of elements in your input.

## Interactivity

Notice in the above example that when you type into one input all the other inputs are synced to the same value? Kinda neat, but not what we want. This is because we are still using the same input handler and `:value`. Here's a plan to improve our input:

- Each input should only modify the character at its respective index in the final string.
- The input handler should call `focus()` on the next input.
- When the string is the same length as `digits`, we update the value of the input by calling `context.node.input()`.

### Example: One-time password - input handlers

#### register.react.jsx

```jsx
import { FormKit, createInput } from '@formkit/react'
import OneTimePassword from './_examples__otp-handlers__one-time-password.react.jsx'

const otp = createInput(OneTimePassword, {
  props: ['digits'],
})

function OtpHandlersExample() {
  const [values, setValues] = useState({})

  return (
    <>
      <FormKit
        type="form"
        modelValue={values}
        onUpdateModelValue={(value) => setValues(value ?? {})}
      >
        <FormKit
          type={otp}
          digits="4"
          label="One-time password"
          name="two_factor_code"
          help="We’ve sent a code to your phone."
          validation="required"
          validationVisibility="live"
        />
      </FormKit>

      <pre>{JSON.stringify(values, null, 2)}</pre>
    </>
  )
}
```

#### one-time-password.react.jsx

```jsx
import { useEffect, useMemo, useState } from 'react'

export default function OneTimePassword({ context }) {
  const digits = Number(context.digits)
  const [tmp, setTmp] = useState(context.value || '')
  const inputRefs = useMemo(() => Array.from({ length: digits }, () => ({ current: null })), [digits])

  useEffect(() => {
    setTmp(context.value || '')
  }, [context.value])

  function handleInput(index, event) {
    const nextChar = event.target.value
    const prev = tmp
    let nextValue

    if (prev.length <= index) {
      nextValue = `${prev}${nextChar}`
    } else {
      nextValue = `${prev.slice(0, index)}${nextChar}${prev.slice(index + 1)}`
    }

    setTmp(nextValue)

    if (index < digits - 1 && nextValue.length >= prev.length) {
      inputRefs[index + 1]?.current?.focus()
    } else if (index > 0 && nextValue.length < prev.length) {
      inputRefs[index - 1]?.current?.focus()
    }

    if (nextValue.length === digits) {
      context.node.input(nextValue)
    } else if (nextValue.length < digits && context.value !== '') {
      context.node.input('')
    }
  }

  function handleFocus(event) {
    event.target.select()
  }

  return (
    <>
      {Array.from({ length: digits }, (_, index) => (
        <input
          key={index}
          ref={(element) => {
            inputRefs[index].current = element
          }}
          maxLength={1}
          className={context.classes.digit}
          value={tmp[index] || ''}
          onInput={(event) => handleInput(index, event)}
          onFocus={handleFocus}
        />
      ))}
    </>
  )
}
```

#### formkit.config.react.jsx

```jsx
import { genesisIcons } from '@formkit/icons'
import { defineFormKitConfig } from '@formkit/react'

export default defineFormKitConfig({
  icons: {
    ...genesisIcons,
  },
  config: {
    classes: {
      digit:
        'text-xl w-10 h-10 border bg-transparent border-gray-300 rounded-md text-center mr-1 mb-2 last:mr-0 dark:border-gray-800',
    },
  },
})
```

Great! This is starting to work like we expect. Let’s check our requirements again:

- Users enter a series of digits, and each digit has its own `<input>` tag.
- The value of the input should always be all the digits concatenated.
- We only want the input to change its value if all digits have been completed (no need to commit and validate on each keystroke if the user is not done).
- It should allow a user to click on a given digit to edit it.
- When a user types a number, it should automatically focus on the next input.
- It should support copy/paste.

### Copy & paste

Looks like we only have one thing left to do — copy & paste support. Fortunately, browsers have a paste event. To ensure our user experience is top notch, we’ll make an assumption: if a user is copy/pasting they are trying to copy and paste the entire code. Not a single digit of the code. Seems reasonable.

All we need to do is capture the copy/paste event on any of our input tags, get the text being pasted, and set the `tmp` value to that string of digits. Let’s whip up another event handler:

```
handlePaste(e) {
  const paste = e.clipboardData.getData('text')
  if (typeof paste === 'string') {
    // If it is the right length, paste it.
    this.tmp = paste.substr(0, this.max)
    const inputs = e.target.parentElement.querySelectorAll('input')
    // Focus on the last character
    inputs.item(this.tmp.length - 1).focus()
  }
}

```

### Example: One-time password - copy paste

#### register.react.jsx

```jsx
import { FormKit, createInput } from '@formkit/react'
import OneTimePassword from './_examples__otp-copy-paste__one-time-password.react.jsx'

const otp = createInput(OneTimePassword, {
  props: ['digits'],
})

function OtpCopyPasteExample() {
  const [values, setValues] = useState({})

  return (
    <>
      <FormKit
        type="form"
        modelValue={values}
        onUpdateModelValue={(value) => setValues(value ?? {})}
      >
        <FormKit
          type={otp}
          digits="4"
          label="One-time password"
          name="two_factor_code"
          help="We’ve sent a code to your phone."
          validation="required"
          validationVisibility="live"
        />
      </FormKit>

      <pre>{JSON.stringify(values, null, 2)}</pre>
    </>
  )
}
```

#### one-time-password.react.jsx

```jsx
import { useEffect, useMemo, useState } from 'react'

export default function OneTimePassword({ context }) {
  const digits = Number(context.digits)
  const [tmp, setTmp] = useState(context.value || '')
  const inputRefs = useMemo(() => Array.from({ length: digits }, () => ({ current: null })), [digits])

  useEffect(() => {
    setTmp(context.value || '')
  }, [context.value])

  function handleInput(index, event) {
    const nextChar = event.target.value
    const prev = tmp
    let nextValue

    if (prev.length <= index) {
      nextValue = `${prev}${nextChar}`
    } else {
      nextValue = `${prev.slice(0, index)}${nextChar}${prev.slice(index + 1)}`
    }

    setTmp(nextValue)

    if (index < digits - 1 && nextValue.length >= prev.length) {
      inputRefs[index + 1]?.current?.focus()
    } else if (index > 0 && nextValue.length < prev.length) {
      inputRefs[index - 1]?.current?.focus()
    }

    if (nextValue.length === digits) {
      context.node.input(nextValue)
    } else if (nextValue.length < digits && context.value !== '') {
      context.node.input('')
    }
  }

  function handleFocus(event) {
    event.target.select()
  }

  function handlePaste(event) {
    const paste = event.clipboardData.getData('text')
    if (typeof paste === 'string') {
      const nextValue = paste.substr(0, digits)
      setTmp(nextValue)
      inputRefs[nextValue.length - 1]?.current?.focus()
    }
  }

  return (
    <>
      {Array.from({ length: digits }, (_, index) => (
        <input
          key={index}
          ref={(element) => {
            inputRefs[index].current = element
          }}
          maxLength={1}
          className={context.classes.digit}
          value={tmp[index] || ''}
          onInput={(event) => handleInput(index, event)}
          onFocus={handleFocus}
          onPaste={handlePaste}
        />
      ))}
    </>
  )
}
```

#### formkit.config.react.jsx

```jsx
import { genesisIcons } from '@formkit/icons'
import { defineFormKitConfig } from '@formkit/react'

export default defineFormKitConfig({
  icons: {
    ...genesisIcons,
  },
  config: {
    classes: {
      digit:
        'text-xl w-10 h-10 border bg-transparent border-gray-300 rounded-md text-center mr-1 mb-2 last:mr-0 dark:border-gray-800',
    },
  },
})
```

Our requirements are all complete!

## Registration

Now that we've worked up an excellent input, let’s register it with our application so we can use it anywhere by just using the string `otp`. Open up your Vue application’s main file (where `app.use(formKit)` is). We’ll just add to it:

```
import { createApp } from 'Vue'
import App from 'App.vue'
import one-time-password from './one-time-password.vue'
import { plugin, defaultConfig, createInput } from '@formkit/vue'

const app = createApp(App)
app.use(
  plugin,
  defaultConfig({
    inputs: {
      otp: createInput(one-time-password, {
        props: ['digits'],
      }),
    },
  })
)
app.mount('#app')

```

Done! Now you can use your input anywhere in your application:

```
<FormKit type="otp" digits="4" />

```

## Next steps

Our one-time password input is working great! Here are some ideas for additional features we could flesh out even further:

- An accompanying validation rule to perform a two-factor authentication call to the backend.
- Additional styles to really make it pop.
- If the form only contains a one-time password input, you could auto-submit the form!
- Complete the [custom input checklist](/essentials/custom-inputs#input-checklist).
- Publish it! If this input (or any others you make) is useful to you, it's probably useful to other people too. You might consider open-sourcing it!

Hopefully this guide helped you understand how custom inputs are declared, written, and registered. If you want to dive in deeper, try reading about the [core internals of FormKit](/essentials/architecture) and [creating custom inputs](/essentials/custom-inputs)!
