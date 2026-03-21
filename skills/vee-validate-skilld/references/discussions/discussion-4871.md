---
number: 4871
title: validateField on an object
category: "Q&A"
created: 2024-09-26
url: "https://github.com/logaretm/vee-validate/discussions/4871"
upvotes: 2
comments: 0
answered: false
---

# validateField on an object

Is it possible to validate a nested object? i have a form like this:
```ts
export const FreeSubmissionProduct = object({
  type: literal('free')
})

export const PremiumSubmissionProduct = object({
  type: literal('premium'),
  location_id: string()
})

export const SubmissionProduct = discriminatedUnion('type', [FreeSubmissionProduct, PremiumSubmissionProduct])

const formSchema = z.object({
  submission: SubmissionProduct
})
```
with a lot of other fields, but after they fill in the submission fields i want to validate only that part of the form.
It works when i do `validateField('submission.type')` but i actually want to validate the whole submission object at once with `validateField('submission')` but that will return 0 errors even if its an empty object.

if you v...