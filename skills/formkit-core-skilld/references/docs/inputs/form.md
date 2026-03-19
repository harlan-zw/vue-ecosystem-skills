# Form

Collect all of your FormKit data, submit to your server, and handle server-side error messages.

While you’re free to use `FormKit` inputs by themselves, you’ll usually want to group them into a form. To do this, wrap your inputs in a `<FormKit type="form">`.

The `form` type will actively collect all the values from child inputs, using the `name` of each input as the property name in the resulting data object (just like [groups](/inputs/group)). You can also read and write to form values using v-model just as you would on any input.

A `<FormKit type="form">` tracks the form's validation state and prevents users from submitting the form if any inputs are invalid.

### Provided submit button

As a convenience, the `form` outputs a submit [button](/inputs/button) automatically, and provided themes also include a loading spinner. You can alter this button with the `submit-label` and `submit-attrs` props, or disable with `:actions="false"`. You can pass any FormKit props to `submit-attrs`. In the example below, we pass classes, `data` attributes, help text, and even [tell the included submit button to be un-ignored](/inputs/submit#ignored-input):

```
<FormKit
  type="form"
  submit-label="Update"
  :submit-attrs="{
    inputClass: 'my-input-class',
    wrapperClass: 'my-wrapper-class',
    'data-theme': `dark`,
    help: 'My button help text',
    ignore: false
  }"
></FormKit>

```

### Full example form

Excluding backend functionality, here is a fully featured form with inputs (`form`, `text`, `email`, `password`), help text, labels, validation with custom messages, and error and submission handling:

### Example: Register example

#### register.vue

```vue
<script setup>
import { ref } from 'vue'
const submitted = ref(false)
const submitHandler = async () => {
  // Let's pretend this is an ajax request:
  await new Promise((r) => setTimeout(r, 1000))
  submitted.value = true
}
</script>

<template>
  <FormKit
    type="form"
    id="registration-example"
    :form-class="submitted ? 'hide' : 'show'"
    submit-label="Register"
    @submit="submitHandler"
    :actions="false"
    #default="{ value }"
  >
    <h1 class="text-2xl font-bold mb-2">Register!</h1>
    <p class="text-sm mb-4">
      You can put any type of element inside a form, not just FormKit inputs
      (although only FormKit inputs are included with the submission).
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
    <div class="double">
      <FormKit
        type="password"
        name="password"
        label="Password"
        validation="required|length:6|matches:/[^a-zA-Z]/"
        :validation-messages="{
          matches: 'Please include at least one symbol',
        }"
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
    <pre wrap>{{ value }}</pre>
  </FormKit>
  <div v-if="submitted">
    <h2 class="text-xl text-green-500">Submission successful!</h2>
  </div>
</template>
```

## Populating

You can populate an entire form by providing a `value` prop to the `<FormKit type="form">`. The `value` prop should be an object of input name to input value pairs. You may also use `v-model` to populate a form if you require two-way data binding:

### Example: Text example

#### form-population.vue

```vue
<FormKit
    type="form"
    :value="{
      location: 'New York City',
      duration: '2 weeks',
      price: 'average',
    }"
    submit-label="Save"
    @submit="save"
  >
    <h2 class="text-xl font-bold mb-1">Edit request</h2>
    <p class="text-base mb-4">Edit your housing request below.</p>
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
      :options="{
        low: 'Below average',
        average: 'Average',
        high: 'Super luxe',
      }"
    />
  </FormKit>
```

> **Danger:** Be sure to either v-model a ref or a property of a reactive object. Do not v-model the reactive object itself as it leads to unexpected behavior.

## Submitting

Forms are usually submitted through user actions like clicking a submit button or hitting the `enter` key on a text node within the form. Upon submission, the form (in sequence):

1. Ensures all inputs are settled (finished debouncing).
2. Emits the `@submit-raw` event.
3. Sets the `submitted` state to true on all inputs — displaying any remaining validation errors (regardless of the `validation-visibility`).
4. If the form has validation errors the `@submit-invalid` event is fired.
5. If all inputs are valid it fires the `@submit` event.
6. If the `@submit` handler returns a `Promise`, sets the form’s state to `loading` until it resolves.

> **Warning:** Using v-model data in your submit handler can lead to unintended form mutations. FormKit automatically collects form data for you, so use the unbound copy of your form’s data that is passed to your submission handler instead.

### Submitting via XHR/Fetch request

The most common method of form submission in a modern SPA is an XHR request (think axios or fetch). FormKit is well suited to this task:

- It hands your `@submit` handler 1) the collected form data as a single request-ready object (no `v-model` needed), and 2) the `form` input's core node, as a convenience.
- If you use an async submit handler, it will disable your form’s inputs and apply a loading state to your form (`loading` becomes true at `context.state.loading` and a spinner is displayed on the `genesis` theme).
- It handles [backend errors](#error-handling) by placing error messages directly on the failing inputs.

### Example: Text example

#### form-xhr.vue

```vue
<script setup>
// This is just a mock of an actual axios instance.
const axios = {
  post: () => new Promise(r => setTimeout(r, 2000))
}

async function login (credentials) {
  const res = await axios.post(credentials)
  // do some login things now
  alert('Logged in!')
}
</script>

<template>
  <FormKit
    type="form"
    submit-label="Login"
    @submit="login"
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
</template>
```

### Submitting as a page request

To submit a form via page request, leave off the `@submit` handler. Just like native HTML, you can also provide an `action` and optionally a `method` attribute.

### Example: Text example

#### form-page.vue

```vue
<template>
  <FormKit
    type="form"
    submit-label="Login"
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
</template>
```

### Submitting forms programmatically

While submitting a form using any standard HTML method is valid (like clicking a `submit` button, or hitting `enter` on a text input) — you may also submit a form programmatically. There are 2 ways to do this:

- Using `this.$formkit.submit('form-id')` (`submitForm('form-id')` for the composition API).
- Using a [core node](/essentials/architecture#node) object.

#### Submitting with $formkit.submit()

### Example: Text example

#### form-submit.vue

```vue
<script>
export default {
  methods: {
    submitForm() {
      this.$formkit.submit('newsletter')
    },
    submitToMailchimp(data) {
      alert(`Submitted ${data.email} successfully!`)
    },
  },
}
</script>

<template>
  <FormKit
    type="form"
    id="newsletter"
    :actions="false"
    @submit="submitToMailchimp"
  >
    <FormKit
      type="email"
      name="email"
      validation="required|email"
      label="Email address"
      help="What email address should we send our newsletter to?"
    />
  </FormKit>
  <p class="text-xs font-italic mb-2">
    This button is not part of the above form:
  </p>
  <!-- 👀 Look, this is not part of the form. -->
  <FormKit type="button" @click="submitForm">Signup for newsletter</FormKit>
</template>
```

#### Submitting with node.submit()

You can also submit a form programmatically by calling `node.submit()` on the form’s (or any input inside the form) core node. To do this you need to [retrieve an instance of the core node](/essentials/architecture#getting-a-components-node).

### Example: Text example

#### node-submit.vue

```vue
<script setup>
import { ref } from 'vue'
const myForm = ref(null)

function submitForm() {
  // retrieve the core node (several ways to do this):
  const node = myForm.value.node
  // submit the form!
  node.submit()
}

function submitHandler() {
  alert('Submitted successfully!')
}
</script>

<template>
  <FormKit ref="myForm" type="form" :actions="false" @submit="submitHandler">
    <FormKit
      type="checkbox"
      label="Computer accessories"
      decorator-icon="heart"
      validation="required|min:2"
      :options="{
        mouse: '🐭 Mouse',
        keyboard: '⌨️ Keyboard',
        monitor: '🖥 Display',
        storage: '💾 Storage',
        laptop_bag: '👝 Laptop bag',
      }"
      help="Pick some accessories you need for your job."
    />
  </FormKit>
  <p class="text-xs font-italic mb-2">
    This button is not part of the above form:
  </p>
  <!-- 👀 Look, this is not part of the form. -->
  <FormKit type="button" @click="submitForm">Submit request</FormKit>
</template>
```

## Disabling

To disable all the inputs in a given form, including the submit button, you can use the `disabled` prop.

### Example: Disabled example

#### form-disabled.vue

```vue
<template>
  <!-- try removing the "disabled" attribute below -->
  <FormKit type="form" disabled>
    <FormKit
      label="Username"
      value="@vue-lover"
    />
    <FormKit
      label="Password"
      type="password"
      value="i-love-formkit"
    />
  </FormKit>
</template>
```

> **Tip:** When using an async @submit handler, FormKit will automatically disable the form (and set the state to loading) while the submit handler is pending.

## Resetting

You can reset your form (or any input) back to its initial state by calling `$formkit.reset(formId)`.

### Example: Reset example

#### reset-form.vue

```vue
<script>
export default {
  data() {
    return {
      complete: false,
    }
  },
  methods: {
    async handleSubmit() {
      // Our api request:
      await new Promise((r) => setTimeout(r, 1000))
      this.complete = true
      this.$formkit.reset('newsletterForm')
    },
  },
}
</script>

<template>
  <FormKit type="form" id="newsletterForm" @submit="handleSubmit">
    <h2 class="text-xl font-bold mb-2">Newsletter</h2>
    <p class="text-base mb-4">When this form is submitted the form is reset.</p>
    <div class="success" v-if="complete">Submitted successfully!</div>
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
      :options="{ daily: 'Daily', weekly: 'Weekly', monthly: 'Monthly' }"
    />
  </FormKit>
</template>
```

> **Tip:** When using the composition API, you can directly access the reset function by importing it from core: import { reset } from '@formkit/core'.

### Initial values

It’s important to note that the "initial state" of a form is not necessarily an empty form. If you have a default `:value` or `v-model` on the form or on individual inputs in the form, FormKit automatically merges these together to produce your initial value, and will restore to this merged state on reset.

Optionally you can provide a second argument to `reset(formId, initialState)` if you would prefer an alternative reset state.

## Validation

Forms will not submit until all the inputs in the form are passing their validation rules.

### Validation incomplete message

In addition to not firing the submit event, a message is displayed above the submit button indicating the form is still incomplete. You can customize this message using the `incomplete-message` prop or disable it by setting the prop to `false`.

### Example: Text example

#### incomplete-message.vue

```vue
<script setup>
const nextMonday = new Date()
nextMonday.setDate(
  nextMonday.getDate() + ((((7 - nextMonday.getDay()) % 7) + 1) % 7)
)
</script>

<template>
  <FormKit
    type="form"
    @submit="() => false"
    incomplete-message="Achtung! We can not service your Deutsche automobil without all the fields being filled out correctly."
  >
    <h2 class="text-xl font-bold mb-4">Schedule service</h2>
    <FormKit
      type="date"
      name="dropoff_date"
      label="Appointment day"
      help="When can you bring your car in?"
      :validation="[['required'], ['date_after', nextMonday]]"
    />
    <FormKit
      type="select"
      name="vehicle"
      label="Vehicle type"
      placeholder="Select a brand"
      :options="['Audi', 'BMW', 'Mercedes', 'Volkswagen']"
      validation="required|is:Audi,Volkswagen"
      :validation-messages="{
        is: ({ node: { value } }) =>
          `Sorry, we don’t service ${value} anymore.`,
      }"
    />
    <FormKit
      type="text"
      name="model"
      label="Model"
      placeholder="ID-6"
      validation="required"
    />
  </FormKit>
</template>
```

> **Tip:** If you want to change the incomplete message across all forms on your project, you can modify the i18n locale message for ui.incomplete.

### Submit invalid event

When a user attempts to submit a form containing inputs that have failing validations, the `@submit-invalid` event is fired.

For example, we could use this event to alert our users of the failing validation rules.

### Example: Submit invalid

#### submit-invalid.vue

```vue
<script setup>
import { getValidationMessages } from '@formkit/validation'
import { ref } from 'vue'

const messages = ref([])

function showErrors(node) {
  const validations = getValidationMessages(node)
  messages.value = []
  validations.forEach((inputMessages) => {
    messages.value = messages.value.concat(
      inputMessages.map((message) => message.value)
    )
  })
}
</script>

<template>
  <h2 class="text-xl font-bold mb-4">Support ticket</h2>
  <FormKit type="form" @submit-invalid="showErrors">
    <ul class="validation-errors" v-if="messages.length">
      <li v-for="message in messages">{{ message }}</li>
    </ul>
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
</template>
```

### Validity state

The validity of all inputs within a form is tracked automatically in the [context object](/essentials/configuration). This can be useful when creating various interfaces. For example, if you wanted a submit button to be disabled until all inputs are valid, you could use the `state.valid` property to do so.

### Example: Text example

#### form-validity.vue

```vue
<script setup>
const handleSubmit = () => alert('Password reset!')
</script>

<template>
  <FormKit
    type="form"
    :actions="false"
    @submit="handleSubmit"
    #default="{ state: { valid } }"
  >
    <h2 class="text-xl font-bold mb-4">Password reset</h2>
    <FormKit
      type="email"
      label="Email address"
      help="Enter your email address to reset your password"
      validation="required|email"
    />
    <FormKit type="submit" :disabled="!valid" />
    <pre wrap>Form validity: {{ valid }}</pre>
  </FormKit>
</template>
```

> **Tip:** In the above example we extract the context object from the #default slot, but there are other ways as well. The context object is available on each input’s core node on the node.context property, and you can fetch an input’s node a number of ways.

## Error handling

With FormKit, adding front-end validation to your form is easy — but what about errors produced by your backend framework, or ones you want to manually assign? There are two types of errors you can assign to a form:

- [Form errors](#form-errors). These are displayed at the bottom of the form above the submit button. An example would be a global message like "Sorry, our server isn’t working right now”.
- [Input errors](#input-errors). Errors to be placed on specific inputs within your form, typically these are validation errors from your backend, like "Sorry this username is already taken".

### Form errors

Form errors (ones that apply to the entire form) can be set three ways.

- Using the `errors` prop on a `<FormKit type="form">`.
- Using a core node `node.setErrors()`.
- Using the `$formkit.setErrors()` Vue plugin method.

#### Using the errors prop

Like with any FormKit input, you can directly assign errors using the `errors` prop. These errors are always visible (not subject to `validation-visibility`).

### Example: Form errors prop example

#### form-errors.vue

```vue
<FormKit
    type="form"
    @submit="() => false"
    submit-label="Login"
    :errors="['Our server is not working.', 'But we don’t like you anyway!']"
  >
    <FormKit type="email" label="Email address" />
    <FormKit type="password" label="Password" />
  </FormKit>
```

#### Using node.setErrors()

Setting your form’s errors using `node.setErrors` is convenient since your submit handler is passed the form’s `node` object as its second argument. `node.setErrors()` takes 2 arguments — an array for form errors, and a keyed object for input errors:

### Example: setErrors

#### node-set-errors.vue

```vue
<script setup>
function submitHandler(data, node) {
  if (data.username !== 'formkit4life') {
    node.setErrors(
      // Arg 1 is form-wide errors
      ['There was an error in this form'],
      // Arg 2 is field-specific errors
      {
        username: 'Sorry, that username is not available.',
      }
    )
  } else {
    alert('Great, you are registered')
  }
}
</script>

<template>
  <FormKit type="form" @submit="submitHandler">
    <FormKit
      name="username"
      label="Username"
      help="What username would you like?"
      validation="required|length:5"
    />
  </FormKit>
</template>
```

#### Using $formkit.setErrors()

Alternatively, you can set errors directly on a form by giving the form an `id` and then calling `$formkit.setErrors('id', ['Form error here'])`. The `setErrors` method must be passed the `id` of the form, and then can handle 1 or 2 additional arguments — the form errors, and the input errors:

### Example: setErrors

#### set-errors.vue

```vue
<script>
export default {
  methods: {
    async order(data) {
      try {
        await fakeApiCall(data)
      } catch (inputErrors) {
        this.$formkit.setErrors(
          'order-form', // You must use the ID of the form
          ['There was an error with your order!'], // (optional) An array of form level errors
          inputErrors // (optional) input level errors
        )
      }
    },
  },
}

/**
 * This is just to illustrate how you might handle an XHR call with fetch or
 * with axios.
 */
function fakeApiCall(data) {
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
</script>

<template>
  <FormKit
    type="form"
    id="order-form"
    submit-label="Order chips"
    @submit="order"
  >
    <h2 class="text-xl font-bold mb-4">Bulk order</h2>
    <FormKit
      type="select"
      name="flavor"
      label="Chip flavor"
      validation="required"
      :options="{
        bbq: 'Barbecue',
        pickle: 'Dill pickle',
        habanero: 'Habanero',
        boring: 'Original',
        vinegar: 'Salt & Vinegar',
      }"
    />
    <FormKit
      type="number"
      step="1"
      name="quantity"
      label="Quantity"
      value="500"
      validation="required|min:100"
      :validation-messages="{
        min: 'Minimum order is 100 units.',
      }"
    />
  </FormKit>
</template>
```

### Clearing errors

By default errors that were set on inputs using `setErrors()` are automatically cleared when a user changes the value of that input. You can change this default behavior by setting the `preserve-errors` prop.

To clear all the errors on the form (regardless of the `preserve-errors` prop) call `node.clearErrors()`.

### Example: clearErrors

#### auto-clear-errors.vue

```vue
<script setup>
import { onMounted } from 'vue'
import { setErrors } from '@formkit/core'

onMounted(() => {
  setErrors('my-form', ['This form has some errors'], {
    first_input: 'This error will clear when you type.',
    second_input: 'This error will remain even after typing.',
  })
})

function clearErrors(formData, node) {
  // This will explicitly clear all errors on the form.
  node.clearErrors()
}
</script>

<template>
  <FormKit
    id="my-form"
    type="form"
    @submit="clearErrors"
    submit-label="Submit to clear all errors"
  >
    <FormKit
      name="first_input"
      label="Auto-clearing error"
      value="Change me!"
      help="When you edit this input the error will clear"
    />
    <FormKit
      name="second_input"
      preserve-errors="true"
      label="Preserved error"
      value="Or change me!"
      help="Sometimes it is best to keep an error until a user submits the form."
    />
  </FormKit>
</template>
```

If you prefer to preserve errors by default, you can change the default behavior by modifying the `preserveErrors` config option. This can be done globally or for a single form:

### Example: preserveErrors

#### preserve-errors-config.vue

```vue
<FormKit
    type="form"
    @submit="() => false"
    id="register"
    :config="{ preserveErrors: true }"
  >
    <FormKit
      name="username"
      label="Username"
      help="Select a new username"
    />
    <FormKit
      name="password"
      label="Password"
    />
  </FormKit>
```

> **Info:** When using Vue 3’s composition API, you can access setErrors and clearErrors by importing them directly from @formkit/vue.import { setErrors, clearErrors } from '@formkit/vue'

### Input errors

Input errors (ones to be displayed with specific inputs in a form) can be applied three ways:

- Manually using the `errors` prop on each individual input.
- Using the `input-errors` prop on the form (also works with groups and lists).
- Using the `$formkit.setErrors()` Vue plugin method (see [example above](#using-formkitseterrors)).

#### Manually using errors prop

The most basic way to display errors on a form is using the `errors` prop that is available on each `FormKit` input.

### Example: errors prop

#### errors-prop.vue

```vue
<template>
  <FormKit type="form" @submit="() => false">
    <FormKit
      type="checkbox"
      label="Shirt style"
      disabled
      :options="['Hawaiian', 'V-Neck', 'Blouse', 'Chambrey']"
      :errors="['Sorry, we are out of shirts.']"
    />
  </FormKit>
</template>
```

#### Using input-errors prop

You can also conveniently set error messages for all inputs in your form (or [group](/inputs/group) or [list](/inputs/list)) using the `input-errors` prop. The prop accepts an object of errors, where the keys are input names ([relative node addresses](/essentials/architecture#traversal) are supported) and the value is an error or array of errors to apply to that input.

### Example: input errors prop

#### input-errors-prop.vue

```vue
<template>
  <FormKit
    type="form"
    @submit="() => false"
    submit-label="Send"
    :input-errors="{
      to: 'Make sure you use the right address.',
      value: 'Are you sure you have this much?',
      gasLimit: 'Just put a giant number in here.',
    }"
  >
    <h2 class="text-xl font-bold mb-4">Donate to FormKit</h2>
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
</template>
```

## Validation and error summary

It can be helpful for accessibility to provide a summary of validation and error messages at the top of your form. FormKit provides a `<FormKitSummary />` component to render this summary for you.

This component will automatically render all of a form’s validation and error messages with jump links to the inputs they apply to. These errors are only shown *after* submitting the form, but they are wrapped in an `aria-live` region to ensure screen readers will be notified when the errors present themselves. Additionally, the page will automatically scroll to the summary box and focus on the first error listed.

`<FormKitSummary />` is not a globally registered component — you must import it:

```
import { FormKitSummary } from '@formkit/vue'

```

### Example: Summary component

#### summary.vue

```vue
<script setup lang="ts">
import { FormKitSummary } from '@formkit/vue'

function submitApplication() {
  alert('Application submitted!')
}
</script>

<template>
  <h1 class="text-2xl font-bold mb-2">Apply to FormKit University</h1>
  <p class="text-base mb-4">Submit this form to see the summary.</p>
  <FormKit
    id="fk-univ-app"
    v-slot="{ value: formData }"
    type="form"
    form-class="fk-univ-app"
    submit-label="Submit application"
    incomplete-message="Sorry. The application was not submitted because not all fields are filled out correctly."
    @submit="submitApplication"
  >
    <!-- 👀 notice the summary is inside the form -->
    <FormKitSummary />

    <h2 class="text-xl font-bold my-4">Personal Information</h2>
    <FormKit name="contact_info" type="group">
      <FormKit
        name="first_name"
        label="First name"
        type="text"
        validation="required"
        help="Enter your first name only."
        outer-class="side-by-side"
      />
      <FormKit
        name="last_name"
        label="Last name"
        type="text"
        validation="required"
        help="Enter your last name only."
        outer-class="side-by-side"
        :errors="['Foobar son, foobar i tell you.']"
      />
      <FormKit
        name="date_of_birth"
        type="date"
        label="Date of birth"
        help="Enter your birthday."
        validation="required|date_between:1990-01-01:00:01:00,1999-12-31:23:59:59"
        :validation-messages="{
          date_between: 'Only 90s kids please.',
        }"
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
        outer-class="triple"
        help="What color gets you jazzed?"
      />
      <FormKit
        name="favorite_month"
        type="select"
        placeholder="Select a month"
        label="Favorite month"
        value="August"
        outer-class="triple"
        help="Choose your favorite month."
        validation="is:June,July,August,September"
        :validation-messages="{
          is: 'Only Summer months allowed.',
        }"
        validation-visibility="dirty"
        :options="[
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
        ]"
      />
      <FormKit
        name="favorite_number"
        type="number"
        value="10"
        label="Favorite number"
        outer-class="triple"
        help="What are your favorite digits?"
      />

      <h3 class="text-lg font-bold my-2">Emergency contacts</h3>
      <FormKit type="list" name="emergency_contacts">
        <FormKit type="group" name="emergency_contact_1">
          <FormKit
            name="emergency_1_name"
            label="Emergency contact 1: Full name"
            type="text"
            validation="required"
            outer-class="side-by-side"
          />
          <FormKit
            name="emergency_1_email"
            label="Emergency contact 1: Email address"
            type="email"
            validation="required"
            outer-class="side-by-side"
          />
        </FormKit>

        <FormKit type="group" name="emergency_contact_2">
          <FormKit
            name="emergency_2_name"
            label="Emergency contact 2: Full name"
            type="text"
            outer-class="side-by-side"
          />
          <FormKit
            name="emergency_2_email"
            label="Emergency contact 2: Email address"
            type="email"
            outer-class="side-by-side"
          />
        </FormKit>
      </FormKit>
    </FormKit>

    <h2 class="text-xl font-bold my-4">Application</h2>

    <FormKit
      name="why_apply"
      type="textarea"
      label="Why do you want to attend FormKit University?"
      help="Serious applicants only."
      validation="required|length:300,1000"
      validation-label="Your answer"
      validation-visibility="blur"
      rows="6"
    >
      <template #help="context">
        <div :class="[context.classes.help]">
          {{ context.help }} <br />
          <span
            >{{ 1000 - (context._value ? context._value.length : 0) }} / 1000
            characters remaining.</span
          >
        </div>
      </template>
    </FormKit>

    <FormKit
      type="file"
      label="Your résumé"
      accept=".pdf,.doc,.md,.jpg,.jpeg,.png"
      help="Upload your résumé if you have one."
      multiple
    />

    <FormKit
      name="interests"
      label="What are your areas of interest?"
      type="checkbox"
      validation="required|min:2"
      :options="[
        'Accessibility',
        'Form error handling',
        'Form generation from schema',
        'Form styles and theming',
        'Validation',
        'Internationalization',
      ]"
    />

    <FormKit
      name="hear_about"
      label="How did you hear about FormKit University?"
      type="radio"
      value="A lot"
      :options="[
        'A friend',
        'The radio',
        'TV commercial',
        'Thoughts on Forms podcast',
        'Google search',
        'Other',
      ]"
    />
    <FormKit
      v-if="formData?.hear_about == 'Other'"
      name="hear_about_other"
      label="Other way you heard about FormKit University:"
      type="text"
    />

    <FormKit
      type="select"
      multiple
      label="What free merch would you like to receive?"
      name="merch"
      :options="[
        { label: 'T-shirt', value: 'shirt' },
        { label: 'Hat', value: 'hat' },
        { label: 'Beanie', value: 'beanie' },
        { label: 'Mug', value: 'mug' },
      ]"
      help="Select all the free merch you'd like to receive by holding command (macOS) or control (PC)."
    />

    <FormKit
      v-if="Array.isArray(formData?.merch) && formData?.merch.includes('shirt')"
      name="t_shirt"
      type="select"
      placeholder="Select a shirt size"
      label="T-shirt size"
      :options="['Small', 'Medium', 'Large']"
    />

    <div class="flex items-center">
      <FormKit
        name="years_experience"
        label="Years of experience"
        help="How many years of experience building forms do you have?"
        type="range"
        value="5"
        min="0"
        max="10"
      />
      <strong class="ml-3 mb-3"
        >{{ formData?.years_experience || 0 }} years</strong
      >
    </div>

    <h2 class="text-xl font-bold my-4">Next steps</h2>

    <FormKit
      name="zoom_meeting"
      type="datepicker"
      label="Date and time of Zoom interview"
      help="Schedule a date and we'll send you a calendar invite."
      validation="required"
      validation-label="The interview"
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
      validation="required|length:16|matches:/^\d+$/"
      :validation-messages="{
        matches: 'Access Pin can only contain numbers.',
      }"
      outer-class="side-by-side"
    />

    <FormKit
      type="password"
      name="access_pin_confirm"
      label="Confirm Access Pin"
      help="Must match the Access Pin exactly as entered in the last step."
      validation="required|confirm"
      validation-label="Access Pin confirmation"
      outer-class="side-by-side"
    />
  </FormKit>
</template>
```

> **Tip:** The summary component should generally be nested in the form it is summarizing. If you would like to move the summary to a different location on the page, you can do so by providing the form’s core node as the node prop.

## Moving validation and error messages

By default, a form’s validation and error messages are placed directly above the form’s actions section. However, you can choose to render these anywhere on your page by using the `<FormKitMessages />` component. `<FormKitMessages />` is not a globally registered component — you must import it:

```
import { FormKitMessages } from '@formkit/vue'

```

There are two ways to use `<FormKitMessages />`:

- [Automatically](#move-messages-automatically)
- [Manually by node](#move-messages-by-node)

### Move messages automatically

Place a `<FormKitMessages />` component anywhere *inside* your form, and the form’s messages will automatically be moved to that location:

### Example: input errors prop

#### automatic.vue

```vue
<script setup>
import { FormKitMessages } from '@formkit/vue'
async function submitHandler(_data, node) {
  await new Promise((resolve) => setTimeout(resolve, 1000))
  node.setErrors([
    'The server doesn’t like your name 😃. Sorry.'
  ])
}
</script>

<template>
  <FormKit type="form" @submit="submitHandler">
    <FormKitMessages /> <!-- 👀 form messages will appear here -->
    <FormKit
      type="text"
      label="Your Name"
      validation="required"
    />
    <FormKit
      type="checkbox"
      label="Top 3 headphones"
      validation-label="Headphones"
      :options="['Galaxy buds','Bowers & Wilkins PX8','AirPods Pro','AirPods Max','Sony WH1000-XM4','Bose 700']"
      validation="required|min:2"
    />

    <p><em><small class="mb-4">Submit to see moved messages. Normally messages are at the bottom.</small></em></p>
  </FormKit>
</template>
```

### Move messages by node

To move messages anywhere in the DOM — even *outside* the form — you can pass the form’s core node as a prop to `<FormKitMessages />`. In this example, we use the messages to create a toast-style popup:

### Example: input errors prop

#### toast.vue

```vue
<script setup>
import { ref } from 'vue'
import { FormKitMessages } from '@formkit/vue'

const form = ref(null)

async function submitHandler(_data, node) {
  await new Promise((resolve) => setTimeout(resolve, 1000))
  node.setErrors([
    'Gambling is illegal.',
    'Your crime has been reported to the authorities.',
  ])
}
</script>

<template>
  <FormKit type="form" @submit="submitHandler" ref="form">
    <FormKit
      type="checkbox"
      label="Soccer nations"
      validation-label="countries"
      :options="[
        '🇧🇷 Brazil',
        '🇩🇪 Germany',
        '🇮🇹 Italy',
        '🇦🇷 Argentina',
        '🇺🇾 Uruguay',
        '🇫🇷 France',
        '🏴󠁧󠁢󠁥󠁮󠁧󠁿 England',
        '🇪🇸 Spain',
      ]"
      help="Which 4 countries will be in the semi finals of the next world cup?"
      validation="required|*min:2"
    />
    <FormKit
      type="mask"
      label="Bet amount"
      :show-mask="false"
      mask="{#,##|repeat}{#.##}"
      prefix="$"
      reverse
      unmask-value
      allow-incomplete
      validation="required|length:4"
      :validation-messages="{
        length: 'Minimum bet is $10.00',
      }"
      help="How much do you want to bet?"
    />
  </FormKit>

  <div class="toast">
    <FormKitMessages :node="form?.node" />
  </div>
</template>

<style scoped>
.toast {
  position: fixed;
  top: 0;
  right: 0;
  width: 300px;
  padding: 1rem;
}

.toast > * {
  padding: 0.75em;
  border-radius: 0.25em;
  box-shadow: 0 0 1em rgba(0, 0, 0, 0.1);
  background-color: #8d2c2c;
}

.toast li {
  margin-bottom: 0 !important;
  color: white !important;
}
</style>
```

### FormKitMessages props

The `<FormKitMessages />` component has a few additional configuration options:

| Prop | Default | Description |
| --- | --- | --- |
| node | inherited | The core node to render messages for. By default this is inherited from the node’s parent (if it exists). |
| sectionsSchema | {} | Override the internal messages and message sections (same default structure as other input’s messages section). |
| defaultPosition | false | By default, FormKitMessages moves the rendered messages to a new location. If you would like to render the messages in both locations, set this prop to true. |

## Unmounting inputs

When an input is unmounted from a form — for example when using `v-if` — its key and value are removed from the form’s data. However, in some circumstances it may be preferable to keep the key/value pair even after the input has been removed. This can be accomplished by using the `preserve` prop:

### Example: input errors prop

#### preserve-prop.vue

```vue
<FormKit type="form" #default="{ value }" :actions="false">
    <FormKit
      type="checkbox"
      :value="true"
      name="beverage"
      label="Include a beverage?"
      help="Select a beverage, then uncheck me to see if data is preserved."
    />
    <!-- Try adding/removing preserve -->
    <FormKit
      v-if="value.beverage"
      preserve
      type="radio"
      name="beverage_type"
      :options="['Tea', 'Coffee']"
      label="Beverage"
      help="Select a beverage please."
    />

    <pre wrap>{{ value }}</pre>
  </FormKit>
```

## Composables 

FormKit provides a few composables to help you access the form’s data and context. These are available to be imported from the `@formkit/vue` package:

### useFormKitContext

The `useFormKitContext` is a composable that returns the form’s context object as a vue `Ref` whenever it becomes available. This must be used in a component that is a child of a `<FormKit>` component (like the form). The first argument is an optional [traversal path](/essentials/architecture#traversal) that allows you to navigate to any node within your form tree. The second argument is an optional effect callback that will be invoked whenever the context becomes available.

### Example: useFormKitContext

#### my-form.vue

```vue
<script setup>
import Address from './_examples__use-formkit-context__address.vue'
</script>

<template>
  <FormKit type="form" @submit="() => false">
    <FormKit name="name" label="Name" help="Enter your name" />
    <Address />
  </FormKit>
</template>
```

#### address.vue

```vue
<script setup>
import { useFormKitContext } from '@formkit/vue'
// Get the entire form context
const form = useFormKitContext()
// Get only the "name" via traversal
const name = useFormKitContext('name')
// Get the "city" and run an effect when it mounts
useFormKitContext('address.city', () => {
  alert('Showing city!')
})
</script>

<template>
  <h2>Address</h2>
  <FormKit type="group" name="address">
    <div class="flex gap-4">
      <FormKit name="street" label="Street" />
      <FormKit name="street_2" label="Street 2" />
    </div>
    <FormKit type="checkbox" name="usa" label="Are you in the United States?" />
    <div class="flex gap-4" v-if="form?.value.address?.usa">
      <FormKit name="city" label="City" />
      <FormKit
        type="select"
        name="state"
        label="State"
        :options="{ va: 'Virginia', nc: 'North Carolina' }"
      />
    </div>
  </FormKit>
  Your name: {{ name.value }}
</template>
```

### useFormKitContextById

Similar to `useFormKitContext` this composable finds any `<FormKit>` context object if that component has been given an explicit `id`. Optionally you can provide an effect callback that will be invoked whenever the node becomes available.

### Example: useFormKitContextById

#### my-form.vue

```vue
<script setup>
import { useFormKitContextById } from '@formkit/vue'
import { computed } from 'vue'

const formContext = useFormKitContextById('myForm')
const sum = computed(() => {
  return (formContext.value?.value.a ?? 0) + (formContext.value?.value.b ?? 0)
})
</script>

<template>
  <FormKit type="form" id="myForm">
    <div class="flex gap-4 items-center">
      <FormKit type="number" name="a" number :value="2" />
      <FormKit type="number" name="b" number :value="3" />
      <div class="whitespace-nowrap">= {{ sum }}</div>
    </div>
  </FormKit>
</template>
```

### useFormKitNodeById

Fetches any FormKit node that has an explicit `id`. It returns a `Ref` that will populate with the core node whenever it is mounted. Optionally you can provide an effect callback that will be invoked whenever the node becomes available.

### Example: useFormKitNodeById

#### my-form.vue

```vue
<script setup>
import { useFormKitNodeById } from '@formkit/vue'

const nodeRef = useFormKitNodeById('student_id', (node) => {
  // perform an effect when the node is available
  node.input('edu-445-1232')
})
</script>

<template>
  <FormKit type="form" @submit="() => false">
    <FormKit
      id="student_id"
      type="mask"
      mask="edu-###-####"
      name="student_id"
      validation="required"
    />
  </FormKit>
</template>
```

> **Info:** The node itself is not reactive and should be used for imperative actions like node.submit(). The context object is reactive and should be used for reading and reacting to the form’s state.

## Autofill

In order to prevent password managers such as 1Password and LastPass from autofilling your email and password input fields, set the respective props `data-1p-ignore` and `data-lpignore` to `true` on the inputs themselves. If you would like for this to be done automatically, check out the [adds attributes to prevent autofill](/essentials/examples) plugin.

## Props & Attributes

Forms are technically considered `input` types — so they share many of the universal props that standard inputs use.

## Sections

### Section Keys Reference

| Section Key | Element | Description |
|-------------|---------|-------------|

## Accessibility

All FormKit inputs are designed with the following accessibility considerations in mind. Help us continually improve accessibility for all by filing accessibility issues here:

- ✓ Semantic markup
- ✓ ARIA attributes
- ✓ Keyboard accessibility
- ✓ Focus indicators
- ✓ Color contrast with the provided theme
- ✓ Accessible labels, help text, and errors
