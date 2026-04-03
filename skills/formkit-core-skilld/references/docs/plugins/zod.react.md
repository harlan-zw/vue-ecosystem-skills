# Zod Plugin

Use your Zod schema to validate your FormKit forms.

With the `@formkit/zod` package you can easily enable validation of your FormKit forms with your Zod schema. This provides a convenient way to have isomorphic types and ensure that your front-end and back-end are using the same validation rules.

When validating against a Zod schema all validation errors will be mapped to their corresponding inputs, show or hide based on your form / input's `validation-visibility` prop, and prevent submission when form data does not pass validation with Zod.

## Installation

To use this plugin with FormKit, install `@formkit/zod`:

```
yarn add @formkit/zod

```

Once you've installed the `@formkit/zod` package, you'll need to register the plugin on a per-form basis and each form that requires validation with a Zod schema will create a new instance of the plugin using the `createZodPlugin` function.

## Usage

To use the Zod plugin we need to import the `createZodPlugin` function from `@formkit/zod`, call the `createZodPlugin` function to create receive our `zodPlugin` and `submitHandler`, and then add them both to our FormKit form.

The `createZodPlugin` function takes two arguments:

- `zodSchema`: The Zod schema that you would like to use to validate against the form.
- `submitCallback`: a function you would like to run once validation has succeeded on your form — this is where you would handle posting your data to your backend or other submit-related tasks. You form data will be provided with full TypeScript support based on your Zod schema.

The `createZodPlugin` will return a tuple of:

- `zodPlugin`: The plugin that should be applied to your target form's `plugins` prop.
- `submitHandler`: The submit handler that should be attached to your form's <code>onSubmit</code> action. When the form data passes validation of your provided Zod schema your `submitCallback` will fire.

### For form validation

Here is an example of using a Zod schema to validate a FormKit form. It's important that your FormKit input `name`s match the expected values for your Zod schema.

### Example: Zod Validation

#### validation.react.jsx

```jsx
const zodSchema = z.object({
  personalInfo: z.object({
    firstName: z.string().min(3).max(25),
    lastName: z.string().min(3).max(25),
  }),
  email: z.string().email(),
  arrayMin: z.string().array().min(2),
})

const [zodPlugin, submitHandler] = createZodPlugin(
  zodSchema,
  async (formData) => {
    await new Promise((resolve) => setTimeout(resolve, 2000))
    alert('Form was submitted!')
    console.log(formData)
  }
)

export default function App() {
  return (
    <>

      <h1>Validation from Zod schema</h1>
      <FormKit type="form" plugins={[zodPlugin]} onSubmit={submitHandler}>
        <FormKit type="group" name="personalInfo">
          <FormKit
            validationVisibility="live"
            type="text"
            name="firstName"
            label="First Name"
          />
          <FormKit type="text" name="lastName" label="Last Name" />
        </FormKit>
        <FormKit type="text" name="email" label="Your email" />
        <FormKit
          type="checkbox"
          name="arrayMin"
          label="Zod features"
          options={['Validation', 'Type-Safety', 'Reusability']}
        />
      </FormKit>
```

Now your FormKit form will use your Zod Schema for validation — and all messages will adjacent to each matching FormKit just live native FormKit validation!

### In addition to FormKit validation

Using Zod to validate your form doesn't mean you have to forgo using FormKit's built-in validation messages. If you add FormKit validation to your FormKit inputs then Zod validation errors will only show if all FormKit validations have been satisfied and there are remaining unsatisfied Zod validations.

This has a few benefits:

- You can use FormKit's built-in rules such as `confirm` which don't have easy-to-use equivalents within Zod.
- Your messages can be translated to one of the many existing languges in `@formkit/i18n` without any additional effort on your part.
- The built-in FormKit validation messages are written to be contextually aware of your input names and knowing that they will be attached directly to their corresponding inputs — so they are more precise and easier to understand than their generic Zod counterparts.

Here's the same form as before, but now using FormKit validation messages in addition to Zod schema validaiton.

### Example: Zod Validation with FormKit Validation

#### with-formkit-validation.react.jsx

```jsx
const zodSchema = z.object({
  personalInfo: z.object({
    firstName: z.string().min(3).max(25),
    lastName: z.string().min(3).max(25),
  }),
  email: z.string().email(),
  arrayMin: z.string().array().min(2),
})

const [zodPlugin, submitHandler] = createZodPlugin(
  zodSchema,
  async (formData) => {
    await new Promise((resolve) => setTimeout(resolve, 2000))
    alert('Form was submitted!')
    console.log(formData)
  }
)

export default function App() {
  return (
    <>

      <h1 className="text-2xl font-bold mb-4">Zod with FormKit Validation</h1>
      <FormKit type="form" plugins={[zodPlugin]} onSubmit={submitHandler}>
        <FormKit type="group" name="personalInfo">
          <FormKit
            validation="required|length:3,25"
            validationVisibility="live"
            type="text"
            name="firstName"
            label="First name"
          />
          <FormKit
            validation="required|length:3,25"
            type="text"
            name="lastName"
            label="Last name"
          />
        </FormKit>
        <FormKit
          validation="required|email"
          type="text"
          name="email"
          label="Your email"
        />
        <FormKit
          validation="required|min:2"
          type="checkbox"
          name="arrayMin"
          label="Zod features"
          options={['Validation', 'Type-Safety', 'Reusability']}
        />
      </FormKit>
```

### For setting form errors

If you need to set errors on your form you can do so with the `node.setZodErrors` function that is made available by the `zodPlugin`. The `node.setZodErrors` function accepts a `ZodError` object and will map the errors to each input. Any non-matching errors will be shown as form-level errors.

### Example: Zod Errors

#### errors.react.jsx

```jsx
const zodSchema = z.object({
  personalInfo: z.object({
    firstName: z.string().min(3).max(25),
    lastName: z.string().min(3).max(25),
  }),
  missingField: z.number(),
})

const [zodPlugin, submitHandler] = createZodPlugin(zodSchema, async () => {
  await new Promise((resolve) => setTimeout(resolve, 2000))
})

function setupFormNode(node) {
  const invalidValues = {
    personalInfo: { firstName: 'A', lastName: 'K' },
    missingField: 'not a number',
  }
  const zodParseResults = zodSchema.safeParse(invalidValues)
  node.setZodErrors(zodParseResults.error)
}

export default function App() {
  return (
    <>

      <h1 className="text-2xl font-bold mb-2">
        Errors set with node.setZodErrors()
      </h1>
      <p className="text-base mb-4">
        This form cannot be successfully submitted because the form fields do
        not match the provided schema.
        <br />
        This is done to illustrate hydration of form-level errors.
        <br />
        Do not actually do this. :)
      </p>
      <FormKit
        type="form"
        onNode={setupFormNode}
        plugins={[zodPlugin]}
        onSubmit={submitHandler}
      >
        <FormKit type="group" name="personalInfo">
          <FormKit type="text" name="firstName" label="First Name" />
          <FormKit type="text" name="lastName" label="Last Name" />
        </FormKit>
      </FormKit>
```
