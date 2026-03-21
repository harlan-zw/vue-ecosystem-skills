---
number: 4950
title: useFieldArray validation issue + upgrade problem with form.handleSubmit
category: "Q&A"
created: 2024-11-22
url: "https://github.com/logaretm/vee-validate/discussions/4950"
upvotes: 2
comments: 1
answered: false
---

# useFieldArray validation issue + upgrade problem with form.handleSubmit

Hi everyone,

Using vee-validate 4.13.2, I'm having an issue with the validations using `useFieldArray`. When I have two rows of inputs and I delete the 1st row, validation errors don't show, but however they do show when I delete the 2nd row instead of the 1st one. Looks like a reactivity problem with the indexes. Anyone encountered this issue? Here's some relevant snippets:


```
<div v-for="(powerInverter, index) in fields" :key="`${props.name}[${index}]`">
  ...
  <text-box
    v-model="powerInverter.value.brand"
    :max-length="35"
    :name="`${props.name}[${index}].brand`"
    :placeholder="t('prosumerDeclaration.installation.brand')"
    required
  />
  ...
  <Button
    :label="t('common.remove')"
    icon="fas fa-trash"
    is-icon
    size="md"
    @click="removePowerInverter(index)"
  />
```...

---

## Top Comments

**@thibautvs**:

Hello,

Any idea regarding this problem?

Thanks in advance