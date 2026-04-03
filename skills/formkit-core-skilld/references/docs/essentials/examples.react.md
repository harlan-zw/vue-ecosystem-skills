# Examples

Examples you can use in your project today.

A broad collection of examples with working code you can use in your project today.

## Forms & structure

A FormKit of type `form` provides an automatic submit button. This example shows how to add classes to the submit button.
Using the `list` type, we can create repeater inputs that can have multiple values. This example uses a loop to let users add/remove email addresses.

## Schema

Use the `FormKitSchema` component to conditionally show an input (with validation rules) based on the value of another input.
Use the `FormKitSchema` component to render the multi-step form from the multi-step form guide.
Create a custom schema-powered submit button that dynamically disables while the form is submitting and provides a loading spinner.
Adds a simple countdown of characters left in a textarea with a hover tooltip based on the textarea's maxlength prop

## Plugins

Use a plugin to add an asterisk (*) to the label area of inputs that have the "required" rule.
Use a plugin to cast string values to numbers. Useful if you want inputs of type `number` to return a JS `Number` primitive.
Use a plugin to append an icon before validation messages by extending the schema definition.
Use a plugin to set all initial input values to an empty string `""` instead of `undefined`.
Use a plugin to allow inputs in the `button` family to have a loading spinner that can be toggled at-will with a new `loading` prop.
Use a plugin to automatically set an input's `name`, `label`, and `help` props based on the `id`. Reduces repetitive prop declarations in your HTML.
A plugin that adds the attribute `data-testid` with the node id for testing libraries.
A plugin that automatically scrolls to the first error on the page on submit or when backend errors are added.
A plugin that adds `data-1p-ignore` and `data-lpignore` attributes to prevent password manager autofill.

## Inputs

A custom input with +1 and -1 step buttons. Made using `createInput()`.
A simple custom input that allows users to select a currency and enter a value. Made using `createInput()`.
Use slots or the `:sections-schema` feature to modify a label's HTML.
Conditionally update the `options` of a `select` input based on the value of another input.
Using only new styles (Tailwind Classes in this example) apply a card treatment to the default FormKit Radio input structure.

## User interface

Add a loading spinner to your input when an async validation rule is pending validation.
Only enable a save/submit button if a user has changed any value inside a form.
Add transitions to validation messages by injecting a Vue `TransitionGroup` component using FormKit's `:sections-schema`.
Use the `classes` config object and FormKit props to produce a dynamic classes based on input state. Helpful for Tailwind and other CSS utility libraries.
Create UI variations of FormKit inputs (like buttons) that update based on reactive data in your components.
