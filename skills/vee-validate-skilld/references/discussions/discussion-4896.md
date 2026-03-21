---
number: 4896
title: "useField vs defineField -> validateOnBlur"
category: "Q&A"
created: 2024-10-15
url: "https://github.com/logaretm/vee-validate/discussions/4896"
upvotes: 1
comments: 1
answered: false
---

# useField vs defineField -> validateOnBlur

Is there a reason why useField does not share the same options as defineField in regards to its configuration on when to validate? @logaretm 

---

## Top Comments

**@logaretm** [maintainer]:

They serve two different purposes.

- `useField` creates a field that optionally integrates with a form and is meant to be used to build components.
- `defineField` creates a field that is always hooked to a form and is meant to be integrated via props with HTML elements or components.

I can see `useField` offering similar binds to `defineField` to make them more alike and enhances the experience of `useField` a little. I don't think it is a huge effort either.