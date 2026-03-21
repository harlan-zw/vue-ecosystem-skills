---
number: 4955
title: "Why can't we use ref for initialValues in the useForm composable?"
category: "Q&A"
created: 2024-11-28
url: "https://github.com/logaretm/vee-validate/discussions/4955"
upvotes: 1
comments: 1
answered: true
---

# Why can't we use ref for initialValues in the useForm composable?

According to the documentation, it says `initialValues?: MaybeRef<Record<string, any>>`. When using `ref` as shown in the screenshot, it results in a TypeScript error.



Is this discussion related?

---

## Accepted Answer

**@logaretm** [maintainer]:

Because it brings with it a set of expectations, like what happens when that ref changes? We can update the values then, but what if the user already interacted with the form and changed the values?

So in order to avoid introducing foot guns and satisfying one use-case over the other, it is recommended that you be explicit and use `resetForm` when you want the changes to reflect.