---
number: 5079
title: useFieldArray TS types
category: "Q&A"
created: 2025-08-23
url: "https://github.com/logaretm/vee-validate/discussions/5079"
upvotes: 1
comments: 0
answered: false
---

# useFieldArray TS types

Hello!

I am new to `vee-validate`.

How do you get TS `path` checks for `useFieldArray` `name`?

I believe vee-validate is inspired by react-hook-form and their `useFieldArray` has optional `control ` parameter that comes from `useForm` and carries useForm path types to useFieldArray so that you get validation that name exists and fields are of certain type.

How to achieve something like that?
I know i can pass generic to useFieldArray but then there's no connection between the type and the name that you pass to useFieldArray and you kind of responsible for keeping the name and ts type in sync.

Love all the work done for vee-validate!