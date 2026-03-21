---
number: 5095
title: Right way to wire Field value into PrimeVue InputNumber component?
category: "Q&A"
created: 2025-11-03
url: "https://github.com/logaretm/vee-validate/discussions/5095"
upvotes: 1
comments: 0
answered: false
---

# Right way to wire Field value into PrimeVue InputNumber component?

Consider the numeric field `count` of a model that I'm building in a `Form` component. The field is rendered as a PrimeVue `InputNumber`.

I have the following solution, which seems to work just fine:

```html
<Form :initialValues="model" :validation-schema="validationSchema" @submit="onSubmit" >
  ...
  <Field name="count" v-slot="{ value, handleChange }">
    <InputNumber :model-value="value" @update:model-value="handleChange"  />
  </Field>
  ...
</Form>
```

However, the docs state that you shouldn't wire `value` into `:model-value`, but instead use `v-bind="field"`:

> `value: unknown`
>
> The current value of the field, useful to compare and do conditional rendering based on the field value. You should not use ...