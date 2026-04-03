# Form

Collect all of your FormKit data, submit to your server, and handle server-side error messages.

While you’re free to use `FormKit` inputs by themselves, you’ll usually want to group them into a form. To do this, wrap your inputs in a `<FormKit type="form">`.

The `form` type will actively collect all the values from child inputs, using the `name` of each input as the property name in the resulting data object (just like [groups](/inputs/group)). You can also read and write to form values using <code>modelValue</code> and <code>onUpdateModelValue</code> just as you would on any input.

A `<FormKit type="form">` tracks the form's validation state and prevents users from submitting the form if any inputs are invalid.

### Provided submit button

As a convenience, the `form` outputs a submit [button](/inputs/button) automatically, and provided themes also include a loading spinner. You can alter this button with the `submitLabel` and `submitAttrs` props, or disable it with <code>actions={false}</code>. You can pass any FormKit props to `submitAttrs`. In the examples below, we pass classes, `data` attributes, help text, and even [tell the included submit button to be un-ignored](/inputs/submit#ignored-input):

```
<FormKit
  type="form"
  submitLabel="Update"
  submitAttrs={{
    inputClass: 'my-input-class',
    wrapperClass: 'my-wrapper-class',
    'data-theme': 'dark',
    help: 'My button help text',
    ignore: false,
  }}
/>

```

### Full example form

Excluding backend functionality, here is a fully featured form with inputs (`form`, `text`, `email`, `password`), help text, labels, validation with custom messages, and error and submission handling:

### Example: Register example

#### register.react.jsx

```jsx
import { useState } from 'react'
import { FormKit } from '@formkit/react'

const styles = `
  #registration-example {
    width: 420px;
    padding: 1.5em 1.5em 0 1.5em;
    border: 1px solid #e4e4e4;
    border-radius: 1em;
    margin: 0 auto 1em auto;
  }

  #registration-example.hide {
    display: none;
  }

  #registration-example pre {
    margin-bottom: 10px;
  }

  @media (min-width: 400px) {
    #registration-example .double {
      display: flex;
      justify-content: space-between;
    }

    #registration-example .double > * {
      width: calc(50% - 0.25em);
    }

    #registration-example .double > *:first-child {
      margin-right: 0.5em;
    }
  }
`

function RegisterExample() {
  const [submitted, setSubmitted] = useState(false)

  async function submitHandler() {
    await new Promise((resolve) => setTimeout(resolve, 1000))
    setSubmitted(true)
  }

  return (
    <>
      <style dangerouslySetInnerHTML={{ __html: styles }} />
      <FormKit
        type="form"
        id="registration-example"
        formClass={submitted ? 'hide' : 'show'}
        submitLabel="Register"
        onSubmit={submitHandler}
        actions={false}
      >
        {({ value }) => (
          <>
            <h1 className="text-2xl font-bold mb-2">Register!</h1>
            <p className="text-sm mb-4">
              You can put any type of element inside a form, not just FormKit
              inputs (although only FormKit inputs are included with the
              submission).
            </p>
            <FormKit
              type="text"
              name="name"
              label="Your name"
              placeholder="Jane Doe"
              help="What do people call you?"
              validation="required"
            />
            <FormKit
              type="text"
              name="email"
              label="Your email"
              placeholder="jane@example.com"
              help="What email should we use?"
              validation="required|email"
            />
            <div className="double">
              <FormKit
                type="password"
                name="password"
                label="Password"
                validation="required|length:6|matches:/[^a-zA-Z]/"
                validationMessages={{
                  matches: 'Please include at least one symbol',
                }}
                placeholder="Your password"
                help="Choose a password"
              />
              <FormKit
                type="password"
                name="password_confirm"
                label="Confirm password"
                placeholder="Confirm password"
                validation="required|confirm"
                help="Confirm your password"
              />
            </div>
            <FormKit type="submit" label="Register" />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
      {submitted ? (
        <div>
          <h2 className="text-xl text-green-500">Submission successful!</h2>
        </div>
      ) : null}
    </>
  )
}
```

## Populating

You can populate an entire form by providing a `value` prop to the `<FormKit type="form">`. The `value` prop should be an object of input name to input value pairs. If you require two-way data binding, use <code>modelValue</code> and <code>onUpdateModelValue</code>:

### Example: Text example

#### form-population.react.jsx

```jsx
<FormKit
        type="form"
        value={{
          location: 'New York City',
          duration: '2 weeks',
          price: 'average',
        }}
        submitLabel="Save"
        onSubmit={save}
      >
        <h2 className="text-xl font-bold mb-1">Edit request</h2>
        <p className="text-base mb-4">Edit your housing request below.</p>
        <FormKit
          type="text"
          name="location"
          label="Location"
          help="Where would you like to stay?"
          validation="required"
        />
        <FormKit
          type="text"
          name="duration"
          label="Duration"
          help="How long would you like to stay?"
          validation="required"
        />
        <FormKit
          type="radio"
          name="price"
          label="Pricing"
          help="How much are you able to pay"
          options={{
            low: 'Below average',
            average: 'Average',
            high: 'Super luxe',
          }}
        />
      </FormKit>
```

> **Tip:** When controlling a form in React, use `modelValue` together with `onUpdateModelValue`. Reserve the `value` prop for initial state only.

## Submitting

Forms are usually submitted through user actions like clicking a submit button or hitting the `enter` key on a text node within the form. Upon submission, the form (in sequence):

1. Ensures all inputs are settled (finished debouncing).
2. Emits the <code>onSubmitRaw</code> event.
3. Sets the `submitted` state to true on all inputs — displaying any remaining validation errors (regardless of the `validation-visibility`).
4. If the form has validation errors the <code>onSubmitInvalid</code> event is fired.
5. If all inputs are valid it fires the <code>onSubmit</code> handler.
6. If the submit handler returns a `Promise`, sets the form’s state to `loading` until it resolves.

> **Warning:** Using <code>modelValue</code> data directly in your submit handler can lead to unintended form mutations. FormKit *automatically* collects form data for you, so use the unbound copy of your form’s data that is passed to your submission handler instead.

### Submitting via XHR/Fetch request

The most common method of form submission in a modern SPA is an XHR request (think axios or fetch). FormKit is well suited to this task:

- It hands your submit handler 1) the collected form data as a single request-ready object (no <code>modelValue</code> needed), and 2) the `form` input's core node, as a convenience.
- If you use an async submit handler, it will disable your form’s inputs and apply a loading state to your form (`loading` becomes true at `context.state.loading` and a spinner is displayed on the `genesis` theme).
- It handles [backend errors](#error-handling) by placing error messages directly on the failing inputs.

### Example: Text example

#### form-xhr.react.jsx

```jsx
import { FormKit } from '@formkit/react'

const axios = {
  post: () => new Promise((resolve) => setTimeout(resolve, 2000)),
}

async function login(credentials) {
  await axios.post(credentials)
  alert('Logged in!')
}

function FormXhrExample() {
  return (
    <FormKit type="form" submitLabel="Login" onSubmit={login}>
      <FormKit name="email" label="Email address" validation="required|email" />
      <FormKit
        type="password"
        name="password"
        label="Password"
        validation="required"
      />
    </FormKit>
  )
}
```

### Submitting as a page request

To submit a form via page request, leave off the submit handler. Just like native HTML, you can also provide an `action` and optionally a `method` attribute.

### Example: Text example

#### form-page.react.jsx

```jsx
<FormKit
        type="form"
        submitLabel="Login"
        action="https://enpae7aofyxlml7.m.pipedream.net"
        method="post"
      >
        <FormKit
          name="email"
          label="Email address"
          validation="required|email"
        />
        <FormKit
          type="password"
          name="password"
          label="Password"
          validation="required"
        />
      </FormKit>
```

### Submitting forms programmatically

While submitting a form using any standard HTML method is valid (like clicking a `submit` button, or hitting `enter` on a text input) — you may also submit a form programmatically. There are 2 ways to do this:

- Using <code>submitForm('form-id')</code>.
- Using a [core node](/essentials/architecture#node) object.

#### Submitting with a helper

### Example: Text example

#### form-submit.react.jsx

```jsx
import { FormKit, submitForm } from '@formkit/react'

function handleSubmitForm() {
  submitForm('newsletter')
}

function submitToMailchimp(data) {
  alert(`Submitted ${data.email} successfully``

#### Submitting with node.submit()

You can also submit a form programmatically by calling `node.submit()` on the form’s (or any input inside the form) core node. To do this you need to [retrieve an instance of the core node](/essentials/architecture#getting-a-components-node).

### Example: Text example

#### node-submit.react.jsx

```jsx
import { useRef } from 'react'
import { FormKit } from '@formkit/react'

function submitHandler() {
  alert('Submitted successfully!')
}

function NodeSubmitExample() {
  const myForm = useRef(null)

  function submitForm() {
    const node = myForm.current
    node?.submit()
  }

  return (
    <>
      <FormKit
        ref={myForm}
        type="form"
        actions={false}
        onSubmit={submitHandler}
      >
        <FormKit
          type="checkbox"
          label="Computer accessories"
          decoratorIcon="heart"
          validation="required|min:2"
          options={{
            mouse: 'Mouse',
            keyboard: 'Keyboard',
            monitor: 'Display',
            storage: 'Storage',
            laptop_bag: 'Laptop bag',
          }}
          help="Pick some accessories you need for your job."
        />
      </FormKit>
      <p className="text-xs font-italic mb-2">
        This button is not part of the above form:
      </p>
      <FormKit type="button" onClick={submitForm}>
        Submit request
      </FormKit>
    </>
  )
}
```

## Disabling

To disable all the inputs in a given form, including the submit button, you can use the `disabled` prop.

### Example: Disabled example

#### form-disabled.react.jsx

```jsx
<FormKit type="form" disabled>
        <FormKit label="Username" value="@vue-lover" />
        <FormKit label="Password" type="password" value="i-love-formkit" />
      </FormKit>
```

> **Tip:** When using an async submit handler, FormKit will automatically disable the form (and set the state to `loading`) while the submit handler is pending.

## Resetting

You can reset your form (or any input) back to its initial state by calling <code>reset(formId)</code>.

### Example: Reset example

#### reset-form.react.jsx

```jsx
import { useState } from 'react'
import { FormKit, reset } from '@formkit/react'

function ResetFormExample() {
  const [complete, setComplete] = useState(false)

  async function handleSubmit() {
    await new Promise((resolve) => setTimeout(resolve, 1000))
    setComplete(true)
    reset('newsletterForm')
  }

  return (
    <FormKit type="form" id="newsletterForm" onSubmit={handleSubmit}>
      <h2 className="text-xl font-bold mb-2">Newsletter</h2>
      <p className="text-base mb-4">
        When this form is submitted the form is reset.
      </p>
      {complete ? <div className="success">Submitted successfully!</div> : null}
      <FormKit
        name="email"
        validation="required|email"
        label="Email address"
        help="What email address would you like to receive our newsletter at?"
      />
      <FormKit
        type="radio"
        name="email_pref"
        label="Email frequency"
        validation="required"
        help="How often should we send you a newsletter?"
        options={{ daily: 'Daily', weekly: 'Weekly', monthly: 'Monthly' }}
      />
    </FormKit>
  )
}
```

> **Tip:** You can import `reset` directly from <code>@formkit/react</code>.

### Initial values

It’s important to note that the "initial state" of a form is not necessarily an empty form. If you have a default `value` prop or use <code>modelValue</code> on the form or on individual inputs in the form, FormKit automatically merges these together to produce your initial value, and will restore to this merged state on reset.

Optionally you can provide a second argument to `reset(formId, initialState)` if you would prefer an alternative reset state.

## Validation

Forms will not submit until all the inputs in the form are passing their validation rules.

### Validation incomplete message

In addition to not firing the submit event, a message is displayed above the submit button indicating the form is still incomplete. You can customize this message using the `incomplete-message` prop or disable it by setting the prop to `false`.

### Example: Text example

#### incomplete-message.react.jsx

```jsx
import { FormKit } from '@formkit/react'

const nextMonday = new Date()
nextMonday.setDate(
  nextMonday.getDate() + ((((7 - nextMonday.getDay()) % 7) + 1) % 7)
)

function IncompleteMessageExample() {
  return (
    <FormKit
      type="form"
      onSubmit={() => false}
      incompleteMessage="Achtung! We can not service your Deutsche automobil without all the fields being filled out correctly."
    >
      <h2 className="text-xl font-bold mb-4">Schedule service</h2>
      <FormKit
        type="date"
        name="dropoff_date"
        label="Appointment day"
        help="When can you bring your car in?"
        validation={[['required'], ['date_after', nextMonday]]}
      />
      <FormKit
        type="select"
        name="vehicle"
        label="Vehicle type"
        placeholder="Select a brand"
        options={['Audi', 'BMW', 'Mercedes', 'Volkswagen']}
        validation="required|is:Audi,Volkswagen"
        validationMessages={{
          is: ({ node: { value } }) =>
            `Sorry, we don't service ${value} anymore.`,
        }}
      />
      <FormKit
        type="text"
        name="model"
        label="Model"
        placeholder="ID-6"
        validation="required"
      />
    </FormKit>
  )
}
```

> **Tip:** If you want to change the incomplete message across all forms on your project, you can modify the i18n locale message for `ui.incomplete`.

### Submit invalid event

When a user attempts to submit a form containing inputs that have failing validations, the <code>onSubmitInvalid</code> event is fired.

For example, we could use this event to alert our users of the failing validation rules.

### Example: Submit invalid

#### submit-invalid.react.jsx

```jsx
import { useState } from 'react'
import { getValidationMessages } from '@formkit/validation'
import { FormKit } from '@formkit/react'

const styles = `
  .validation-errors {
    padding: 1rem;
    margin-bottom: 1.5rem;
    border-radius: 0.375rem;
    background: rgb(254 226 226);
    color: rgb(153 27 27);
  }
`

function SubmitInvalidExample() {
  const [messages, setMessages] = useState([])

  function showErrors(node) {
    const validations = node ? getValidationMessages(node) : []
    const nextMessages = []

    validations.forEach((inputMessages) => {
      nextMessages.push(...inputMessages.map((message) => message.value))
    })

    setMessages(nextMessages)
  }

  return (
    <>
      <style>{styles}</style>
      <h2 className="text-xl font-bold mb-4">Support ticket</h2>
      <FormKit type="form" onSubmitInvalid={showErrors}>
        {messages.length ? (
          <ul className="validation-errors">
            {messages.map((message, index) => (
              <li key={`${message}-${index}`}>{message}</li>
            ))}
          </ul>
        ) : null}
        <FormKit
          name="title"
          label="Ticket title"
          help="A short sentence that describes your problem."
          validation="required"
        />
        <FormKit
          name="issue"
          type="textarea"
          label="Issue"
          help="Please describe your issue in detail."
          validation="required|length:50,500"
        />
      </FormKit>
    </>
  )
}
```

### Validity state

The validity of all inputs within a form is tracked automatically in the [context object](/essentials/configuration). This can be useful when creating various interfaces. For example, if you wanted a submit button to be disabled until all inputs are valid, you could use the `state.valid` property to do so.

### Example: Text example

#### form-validity.react.jsx

```jsx
import { FormKit } from '@formkit/react'

function handleSubmit() {
  alert('Password reset!')
}

function FormValidityExample() {
  return (
    <FormKit type="form" actions={false} onSubmit={handleSubmit}>
      {({ state: { valid } }) => (
        <>
          <h2 className="text-xl font-bold mb-4">Password reset</h2>
          <FormKit
            type="email"
            label="Email address"
            help="Enter your email address to reset your password"
            validation="required|email"
          />
          <FormKit type="submit" disabled={!valid} />
          <pre>{`Form validity: ${String(valid)}`}</pre>
        </>
      )}
    </FormKit>
  )
}
```

> **Tip:** In the above example we extract the context object from the render-prop child function, but there are other ways as well. The context object is available on each input’s core node on the `node.context` property, and you can fetch an input’s node [a number of ways](/essentials/architecture#getting-a-components-node).

## Error handling

With FormKit, adding front-end validation to your form is easy — but what about errors produced by your backend framework, or ones you want to manually assign? There are two types of errors you can assign to a form:

- [Form errors](#form-errors). These are displayed at the bottom of the form above the submit button. An example would be a global message like "Sorry, our server isn’t working right now”.
- [Input errors](#input-errors). Errors to be placed on specific inputs within your form, typically these are validation errors from your backend, like "Sorry this username is already taken".

### Form errors

Form errors (ones that apply to the entire form) can be set three ways.

- Using the `errors` prop on a `<FormKit type="form">`.
- Using a core node `node.setErrors()`.
- Using <code>setErrors()</code>.

#### Using the errors prop

Like with any FormKit input, you can directly assign errors using the `errors` prop. These errors are always visible (not subject to `validation-visibility`).

### Example: Form errors prop example

#### form-errors.react.jsx

```jsx
<FormKit
        type="form"
        onSubmit={() => false}
        submitLabel="Login"
        errors={['Our server is not working.', "But we don't like you anyway!"]}
      >
        <FormKit type="email" label="Email address" />
        <FormKit type="password" label="Password" />
      </FormKit>
```

#### Using node.setErrors()

Setting your form’s errors using `node.setErrors` is convenient since your submit handler is passed the form’s `node` object as its second argument. `node.setErrors()` takes 2 arguments — an array for form errors, and a keyed object for input errors:

### Example: setErrors

#### node-set-errors.react.jsx

```jsx
import { FormKit } from '@formkit/react'

function submitHandler(data, node) {
  if (data.username !== 'formkit4life') {
    node.setErrors(['There was an error in this form'], {
      username: 'Sorry, that username is not available.',
    })
  } else {
    alert('Great, you are registered')
  }
}

function NodeSetErrorsExample() {
  return (
    <FormKit type="form" onSubmit={submitHandler}>
      <FormKit
        name="username"
        label="Username"
        help="What username would you like?"
        validation="required|length:5"
      />
    </FormKit>
  )
}
```

#### Using setErrors()

Alternatively, you can set errors directly on a form by giving the form an `id` and then calling <code>setErrors('id', ['Form error here'])</code>. The `setErrors` method must be passed the `id` of the form, and then can handle 1 or 2 additional arguments — the form errors, and the input errors:

### Example: setErrors

#### set-errors.react.jsx

```jsx
import { FormKit, setErrors } from '@formkit/react'

async function order(data) {
  try {
    await fakeApiCall(data)
  } catch (inputErrors) {
    setErrors(
      'order-form',
      ['There was an error with your order!'],
      inputErrors
    )
  }
}

function fakeApiCall() {
  return new Promise((_, reject) => {
    setTimeout(
      () =>
        reject({
          flavor: 'Sorry, that type is now sold out!',
        }),
      1000
    )
  })
}

function SetErrorsExample() {
  return (
    <FormKit
      type="form"
      id="order-form"
      submitLabel="Order chips"
      onSubmit={order}
    >
      <h2 className="text-xl font-bold mb-4">Bulk order</h2>
      <FormKit
        type="select"
        name="flavor"
        label="Chip flavor"
        validation="required"
        options={{
          bbq: 'Barbecue',
          pickle: 'Dill pickle',
          habanero: 'Habanero',
          boring: 'Original',
          vinegar: 'Salt & Vinegar',
        }}
      />
      <FormKit
        type="number"
        step="1"
        name="quantity"
        label="Quantity"
        value="500"
        validation="required|min:100"
        validationMessages={{
          min: 'Minimum order is 100 units.',
        }}
      />
    </FormKit>
  )
}
```

### Clearing errors

By default errors that were set on inputs using `setErrors()` are automatically cleared when a user changes the value of that input. You can change this default behavior by setting the `preserve-errors` prop.

To clear all the errors on the form (regardless of the `preserve-errors` prop) call `node.clearErrors()`.

### Example: clearErrors

#### auto-clear-errors.react.jsx

```jsx
import { useEffect } from 'react'
import { FormKit, setErrors } from '@formkit/react'

function AutoClearErrorsExample() {
  useEffect(() => {
    setErrors('my-form', ['This form has some errors'], {
      first_input: 'This error will clear when you type.',
      second_input: 'This error will remain even after typing.',
    })
  }, [])

  function clearErrors(_formData, node) {
    node.clearErrors()
  }

  return (
    <FormKit
      id="my-form"
      type="form"
      onSubmit={clearErrors}
      submitLabel="Submit to clear all errors"
    >
      <FormKit
        name="first_input"
        label="Auto-clearing error"
        value="Change me!"
        help="When you edit this input the error will clear"
      />
      <FormKit
        name="second_input"
        preserveErrors
        label="Preserved error"
        value="Or change me!"
        help="Sometimes it is best to keep an error until a user submits the form."
      />
    </FormKit>
  )
}
```

If you prefer to preserve errors by default, you can change the default behavior by modifying the `preserveErrors` config option. This can be done globally or for a single form:

### Example: preserveErrors

#### preserve-errors-config.react.jsx

```jsx
<FormKit
        type="form"
        onSubmit={() => false}
        id="register"
        config={{ preserveErrors: true }}
      >
        <FormKit
          name="username"
          label="Username"
          help="Select a new username"
        />
        <FormKit name="password" label="Password" />
      </FormKit>
```

> **Info:** You can access `setErrors` and `clearErrors` by importing them directly from your framework package.
```
import { setErrors, clearErrors } from '@formkit/react'

```

### Input errors

Input errors (ones to be displayed with specific inputs in a form) can be applied three ways:

- Manually using the `errors` prop on each individual input.
- Using the `input-errors` prop on the form (also works with groups and lists).
- Using <code>setErrors()</code> (see [example above](#using-seterrors)).

#### Manually using errors prop

The most basic way to display errors on a form is using the `errors` prop that is available on each `FormKit` input.

### Example: errors prop

#### errors-prop.react.jsx

```jsx
<FormKit type="form" onSubmit={() => false}>
        <FormKit
          type="checkbox"
          label="Shirt style"
          disabled
          options={['Hawaiian', 'V-Neck', 'Blouse', 'Chambrey']}
          errors={['Sorry, we are out of shirts.']}
        />
      </FormKit>
```

#### Using input-errors prop

You can also conveniently set error messages for all inputs in your form (or [group](/inputs/group) or [list](/inputs/list)) using the `input-errors` prop. The prop accepts an object of errors, where the keys are input names ([relative node addresses](/essentials/architecture#traversal) are supported) and the value is an error or array of errors to apply to that input.

### Example: input errors prop

#### input-errors-prop.react.jsx

```jsx
<FormKit
        type="form"
        onSubmit={() => false}
        submitLabel="Send"
        inputErrors={{
          to: 'Make sure you use the right address.',
          value: 'Are you sure you have this much?',
          gasLimit: 'Just put a giant number in here.',
        }}
      >
        <h2 className="text-xl font-bold mb-4">Donate to FormKit</h2>
        <FormKit
          name="to"
          label="Ethereum address"
          placeholder="0x8204Dd0ac307B777D8e19F3e5cbAD3C0B2488dbe"
          help="Where do you want to send your eth?"
        />
        <FormKit
          label="Quantity"
          name="value"
          placeholder="2.11"
          type="number"
          help="How much eth do you want to send"
        />
        <FormKit
          label="Gas limit"
          name="gasLimit"
          type="number"
          placeholder="50000"
          help="What is the maximum amount of gas that should be consumed?"
        />
      </FormKit>
```

## Validation and error summary

It can be helpful for accessibility to provide a summary of validation and error messages at the top of your form. FormKit provides a `<FormKitSummary />` component to render this summary for you.

This component will automatically render all of a form’s validation and error messages with jump links to the inputs they apply to. These errors are only shown *after* submitting the form, but they are wrapped in an `aria-live` region to ensure screen readers will be notified when the errors present themselves. Additionally, the page will automatically scroll to the summary box and focus on the first error listed.

`<FormKitSummary />` is not a globally registered component — you must import it:

```
import { FormKitSummary } from '@formkit/react'

```

### Example: Summary component

#### summary.react.jsx

```jsx
import { FormKit, FormKitSummary } from '@formkit/react'

function submitApplication() {
  alert('Application submitted!')
}

function SummaryExample() {
  return (
    <>
      <h1 className="text-2xl font-bold mb-2">Apply to FormKit University</h1>
      <p className="text-base mb-4">Submit this form to see the summary.</p>
      <FormKit
        id="fk-univ-app"
        type="form"
        formClass="fk-univ-app"
        submitLabel="Submit application"
        incompleteMessage="Sorry. The application was not submitted because not all fields are filled out correctly."
        onSubmit={submitApplication}
      >
        {({ value: formData }) => (
          <>
            <FormKitSummary />

            <h2 className="text-xl font-bold my-4">Personal Information</h2>
            <FormKit name="contact_info" type="group">
              <FormKit
                name="first_name"
                label="First name"
                type="text"
                validation="required"
                help="Enter your first name only."
                outerClass="side-by-side"
              />
              <FormKit
                name="last_name"
                label="Last name"
                type="text"
                validation="required"
                help="Enter your last name only."
                outerClass="side-by-side"
                errors={['Foobar son, foobar i tell you.']}
              />
              <FormKit
                name="date_of_birth"
                type="date"
                label="Date of birth"
                help="Enter your birthday."
                validation="required|date_between:1990-01-01:00:01:00,1999-12-31:23:59:59"
                validationMessages={{
                  date_between: 'Only 90s kids please.',
                }}
              />
              <FormKit
                name="email"
                type="email"
                label="Email address"
                validation="required|email"
                placeholder="example@example.com"
              />
              <FormKit
                name="favorite_color"
                type="color"
                value="#0062cc"
                label="Favorite color"
                outerClass="triple"
                help="What color gets you jazzed?"
              />
              <FormKit
                name="favorite_month"
                type="select"
                placeholder="Select a month"
                label="Favorite month"
                value="August"
                outerClass="triple"
                help="Choose your favorite month."
                validation="is:June,July,August,September"
                validationMessages={{
                  is: 'Only Summer months allowed.',
                }}
                validationVisibility="dirty"
                options={[
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
                ]}
              />
              <FormKit
                name="favorite_number"
                type="number"
                value="10"
                label="Favorite number"
                outerClass="triple"
                help="What are your favorite digits?"
              />

              <h3 className="text-lg font-bold my-2">Emergency contacts</h3>
              <FormKit type="list" name="emergency_contacts">
                <FormKit type="group" name="emergency_contact_1">
                  <FormKit
                    name="emergency_1_name"
                    label="Emergency contact 1: Full name"
                    type="text"
                    validation="required"
                    outerClass="side-by-side"
                  />
                  <FormKit
                    name="emergency_1_email"
                    label="Emergency contact 1: Email address"
                    type="email"
                    validation="required"
                    outerClass="side-by-side"
                  />
                </FormKit>

                <FormKit type="group" name="emergency_contact_2">
                  <FormKit
                    name="emergency_2_name"
                    label="Emergency contact 2: Full name"
                    type="text"
                    outerClass="side-by-side"
                  />
                  <FormKit
                    name="emergency_2_email"
                    label="Emergency contact 2: Email address"
                    type="email"
                    outerClass="side-by-side"
                  />
                </FormKit>
              </FormKit>
            </FormKit>

            <h2 className="text-xl font-bold my-4">Application</h2>

            <FormKit
              name="why_apply"
              type="textarea"
              label="Why do you want to attend FormKit University?"
              help="Serious applicants only."
              validation="required|length:300,1000"
              validationLabel="Your answer"
              validationVisibility="blur"
              rows="6"
              slots={{
                help: (context) => (
                  <div className={context.classes.help}>
                    {context.help}
                    <br />
                    <span>
                      {1000 - (context._value ? context._value.length : 0)} /
                      1000 characters remaining.
                    </span>
                  </div>
                ),
              }}
            />

            <FormKit
              type="file"
              label="Your resume"
              accept=".pdf,.doc,.md,.jpg,.jpeg,.png"
              help="Upload your resume if you have one."
              multiple
            />

            <FormKit
              name="interests"
              label="What are your areas of interest?"
              type="checkbox"
              validation="required|min:2"
              options={[
                'Accessibility',
                'Form error handling',
                'Form generation from schema',
                'Form styles and theming',
                'Validation',
                'Internationalization',
              ]}
            />

            <FormKit
              name="hear_about"
              label="How did you hear about FormKit University?"
              type="radio"
              value="A lot"
              options={[
                'A friend',
                'The radio',
                'TV commercial',
                'Thoughts on Forms podcast',
                'Google search',
                'Other',
              ]}
            />
            {formData?.hear_about === 'Other' ? (
              <FormKit
                name="hear_about_other"
                label="Other way you heard about FormKit University:"
                type="text"
              />
            ) : null}

            <FormKit
              type="select"
              multiple
              label="What free merch would you like to receive?"
              name="merch"
              options={[
                { label: 'T-shirt', value: 'shirt' },
                { label: 'Hat', value: 'hat' },
                { label: 'Beanie', value: 'beanie' },
                { label: 'Mug', value: 'mug' },
              ]}
              help="Select all the free merch you'd like to receive by holding command (macOS) or control (PC)."
            />

            {Array.isArray(formData?.merch) &&
            formData.merch.includes('shirt') ? (
              <FormKit
                name="t_shirt"
                type="select"
                placeholder="Select a shirt size"
                label="T-shirt size"
                options={['Small', 'Medium', 'Large']}
              />
            ) : null}

            <div className="flex items-center">
              <FormKit
                name="years_experience"
                label="Years of experience"
                help="How many years of experience building forms do you have?"
                type="range"
                value="5"
                min="0"
                max="10"
              />
              <strong className="ml-3 mb-3">
                {formData?.years_experience || 0} years
              </strong>
            </div>

            <h2 className="text-xl font-bold my-4">Next steps</h2>

            <FormKit
              name="zoom_meeting"
              type="datepicker"
              label="Date and time of Zoom interview"
              help="Schedule a date and we'll send you a calendar invite."
              validation="required"
              validationLabel="The interview"
            />

            <FormKit
              name="zoom_backup"
              type="time"
              label="Backup time for Zoom interview"
              help="Select a backup time of day for the Zoom interview."
              validation="required"
            />

            <FormKit
              type="month"
              name="tuition_start"
              label="Tuition start month"
              help="If accepted, choose which month you'd like your tuition cycle to begin."
              min="2022-08"
              max="2022-10"
            />

            <FormKit
              name="access_pin"
              label="Access Pin"
              help="Set your numeric Access Pin to retrieve your application data later."
              type="password"
              validation="required|length:16|matches:/^\\d+$/"
              validationMessages={{
                matches: 'Access Pin can only contain numbers.',
              }}
              outerClass="side-by-side"
            />

            <FormKit
              type="password"
              name="access_pin_confirm"
              label="Confirm Access Pin"
              help="Must match the Access Pin exactly as entered in the last step."
              validation="required|confirm"
              validationLabel="Access Pin confirmation"
              outerClass="side-by-side"
            />
          </>
        )}
      </FormKit>
    </>
  )
}
```

> **Tip:** The summary component should generally be nested in the form it is summarizing. If you would like to move the summary to a different location on the page, you can do so by providing the form’s core node as the `node` prop.

## Moving validation and error messages

By default, a form’s validation and error messages are placed directly above the form’s actions section. However, you can choose to render these anywhere on your page by using the `<FormKitMessages />` component. `<FormKitMessages />` is not a globally registered component — you must import it:

```
import { FormKitMessages } from '@formkit/react'

```

There are two ways to use `<FormKitMessages />`:

- [Automatically](#move-messages-automatically)
- [Manually by node](#move-messages-by-node)

### Move messages automatically

Place a `<FormKitMessages />` component anywhere *inside* your form, and the form’s messages will automatically be moved to that location:

### Example: input errors prop

#### automatic.react.jsx

```jsx
import { FormKit, FormKitMessages } from '@formkit/react'

async function submitHandler(_data, node) {
  await new Promise((resolve) => setTimeout(resolve, 1000))
  node.setErrors(["The server doesn't like your name. Sorry."])
}

function AutomaticMessagesExample() {
  return (
    <FormKit type="form" onSubmit={submitHandler}>
      <FormKitMessages />
      <FormKit type="text" label="Your Name" validation="required" />
      <FormKit
        type="checkbox"
        label="Top 3 headphones"
        validationLabel="Headphones"
        options={[
          'Galaxy buds',
          'Bowers & Wilkins PX8',
          'AirPods Pro',
          'AirPods Max',
          'Sony WH1000-XM4',
          'Bose 700',
        ]}
        validation="required|min:2"
      />

      <p>
        <em>
          <small className="mb-4">
            Submit to see moved messages. Normally messages are at the bottom.
          </small>
        </em>
      </p>
    </FormKit>
  )
}
```

### Move messages by node

To move messages anywhere in the DOM — even *outside* the form — you can pass the form’s core node as a prop to `<FormKitMessages />`. In this example, we use the messages to create a toast-style popup:

### Example: input errors prop

#### toast.react.jsx

```jsx
import { useState } from 'react'
import { FormKit, FormKitMessages } from '@formkit/react'

const toastStyle = {
  position: 'absolute',
  top: 0,
  right: 0,
  width: '300px',
  padding: '1rem',
}

const toastPanelStyle = {
  padding: '0.75em',
  borderRadius: '0.25em',
  boxShadow: '0 0 1em rgba(0, 0, 0, 0.1)',
  backgroundColor: '#8d2c2c',
  color: 'white',
}

async function submitHandler(_data, node) {
  await new Promise((resolve) => setTimeout(resolve, 1000))
  node.setErrors([
    'Gambling is illegal.',
    'Your crime has been reported to the authorities.',
  ])
}

function ToastMessagesExample() {
  const [formNode, setFormNode] = useState(undefined)
  const [showToast, setShowToast] = useState(false)

  async function handleSubmit(data, node) {
    setShowToast(false)
    await submitHandler(data, node)
    setShowToast(true)
  }

  return (
    <div style={{ position: 'relative', width: '100%' }}>
      <FormKit type="form" onSubmit={handleSubmit} onNode={setFormNode}>
        <FormKit
          type="checkbox"
          label="Soccer nations"
          validationLabel="countries"
          options={[
            'Brazil',
            'Germany',
            'Italy',
            'Argentina',
            'Uruguay',
            'France',
            'England',
            'Spain',
          ]}
          help="Which 4 countries will be in the semi finals of the next world cup?"
          validation="required|*min:2"
        />
        <FormKit
          type="mask"
          label="Bet amount"
          showMask={false}
          mask="{#,##|repeat}{#.##}"
          prefix="$"
          reverse
          unmaskValue
          allowIncomplete
          validation="required|length:4"
          validationMessages={{
            length: 'Minimum bet is $10.00',
          }}
          help="How much do you want to bet?"
        />
      </FormKit>

      {showToast ? (
        <div style={toastStyle}>
          <div style={toastPanelStyle}>
            <FormKitMessages node={formNode} />
          </div>
        </div>
      ) : null}
    </div>
  )
}
```

### FormKitMessages props

The `<FormKitMessages />` component has a few additional configuration options:

| Prop | Default | Description |
| --- | --- | --- |
| node | inherited | The core node to render messages for. By default this is inherited from the node’s parent (if it exists). |
| sectionsSchema | {} | Override the internal messages and message sections (same default structure as other input’s messages section). |
| defaultPosition | false | By default, FormKitMessages moves the rendered messages to a new location. If you would like to render the messages in both locations, set this prop to true. |

## Unmounting inputs

When an input is unmounted from a form — for example when using conditional rendering — its key and value are removed from the form’s data. However, in some circumstances it may be preferable to keep the key/value pair even after the input has been removed. This can be accomplished by using the `preserve` prop:

### Example: input errors prop

#### preserve-prop.react.jsx

```jsx
<FormKit
            type="checkbox"
            value={true}
            name="beverage"
            label="Include a beverage?"
            help="Select a beverage, then uncheck me to see if data is preserved."
          />
          {value?.beverage ? (
            <FormKit
              preserve
              type="radio"
              name="beverage_type"
              options={['Tea', 'Coffee']}
              label="Beverage"
              help="Select a beverage please."
            />
          ) : null}

          <pre>{JSON.stringify(value, null, 2)}</pre>
```

## Composables 

FormKit provides a few composables to help you access the form’s data and context. These are available to be imported from <code>@formkit/react</code>.

### useFormKitContext

The `useFormKitContext` composable returns the form’s context object whenever it becomes available. In Vue it is returned as a `Ref`; in React the hook returns the context object directly. This must be used in a component that is a child of a `<FormKit>` component (like the form). The first argument is an optional [traversal path](/essentials/architecture#traversal) that allows you to navigate to any node within your form tree. The second argument is an optional effect callback that will be invoked whenever the context becomes available.

### Example: useFormKitContext

#### my-form.react.jsx

```jsx
import { FormKit } from '@formkit/react'
import Address from './_examples__form__use-formkit-context__address.react.jsx'

function MyFormExample() {
  return (
    <FormKit type="form" onSubmit={() => false}>
      <FormKit name="name" label="Name" help="Enter your name" />
      <Address />
    </FormKit>
  )
}
```

#### address.react.jsx

```jsx
import { FormKit, useFormKitContext } from '@formkit/react'

export default function Address() {
  const form = useFormKitContext()
  const name = useFormKitContext('name')

  useFormKitContext('address.city', () => {
    alert('Showing city!')
  })

  return (
    <>
      <h2>Address</h2>
      <FormKit type="group" name="address">
        <div className="flex gap-4">
          <FormKit name="street" label="Street" />
          <FormKit name="street_2" label="Street 2" />
        </div>
        <FormKit
          type="checkbox"
          name="usa"
          label="Are you in the United States?"
        />
        {form?.value?.address?.usa ? (
          <div className="flex gap-4">
            <FormKit name="city" label="City" />
            <FormKit
              type="select"
              name="state"
              label="State"
              options={{ va: 'Virginia', nc: 'North Carolina' }}
            />
          </div>
        ) : null}
      </FormKit>
      Your name: {name?.value}
    </>
  )
}
```

### useFormKitContextById

Similar to `useFormKitContext`, this composable finds any `<FormKit>` context object if that component has been given an explicit `id`. Optionally you can provide an effect callback that will be invoked whenever the context becomes available.

### Example: useFormKitContextById

#### my-form.react.jsx

```jsx
import { FormKit, useFormKitContextById } from '@formkit/react'

const initialValues = {
  a: 2,
  b: 3,
}

function UseFormKitContextByIdExample() {
  const formContext = useFormKitContextById('myForm')
  const values = formContext?.value ?? initialValues
  const sum = (values.a ?? 0) + (values.b ?? 0)

  return (
    <FormKit type="form" id="myForm" value={initialValues}>
      <div className="flex gap-4 items-center">
        <FormKit type="number" name="a" number />
        <FormKit type="number" name="b" number />
        <div className="whitespace-nowrap">= {sum}</div>
      </div>
    </FormKit>
  )
}
```

### useFormKitNodeById

Fetches any FormKit node that has an explicit `id`. In Vue it returns a `Ref` that will populate with the core node whenever it is mounted; in React the hook returns the node directly. Optionally you can provide an effect callback that will be invoked whenever the node becomes available.

### Example: useFormKitNodeById

#### my-form.react.jsx

```jsx
import { FormKit, useFormKitNodeById } from '@formkit/react'

function UseFormKitNodeByIdExample() {
  useFormKitNodeById('student_id', (node) => {
    node.input('edu-445-1232')
  })

  return (
    <FormKit type="form" onSubmit={() => false}>
      <FormKit
        id="student_id"
        type="mask"
        mask="edu-###-####"
        name="student_id"
        validation="required"
      />
    </FormKit>
  )
}
```

> **Info:** The node itself is not reactive and should be used for imperative actions like `node.submit()`. The context object is reactive and should be used for reading and reacting to the form’s state.

## Autofill

In order to prevent password managers such as 1Password and LastPass from autofilling your email and password input fields, set the respective props `data-1p-ignore` and `data-lpignore` to `true` on the inputs themselves. If you would like for this to be done automatically, check out the [adds attributes to prevent autofill](/essentials/examples) plugin.

## Props & Attributes

Forms are technically considered `input` types — so they share many of the universal props that standard inputs use.

## Sections

### Section Keys Reference

| Section Key | Element | Description |
|-------------|---------|-------------|
