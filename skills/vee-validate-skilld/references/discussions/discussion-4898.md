---
number: 4898
title: "useForm and `<form>` and how fields are found by name"
category: "Q&A"
created: 2024-10-18
url: "https://github.com/logaretm/vee-validate/discussions/4898"
upvotes: 1
comments: 1
answered: false
---

# useForm and `<form>` and how fields are found by name

I have a general question on how `useForm` actually works. It seems it maybe is just looking for inputs and for the `name` attribute of inputs. That would mean, form tags would not be necessary at all to have an actual form and also it would never work with the html submit and such.
Now how do I separate forms from each other? Lets say I have a useForm on a search with some searchoptions and as a child component I have a result wrapper that allows filter options also with useForm to organize that input. What will happen? And how to find out if I crossed some scope/context boundries?

---

## Top Comments

**@logaretm** [maintainer]:

Hey there.

You are correct, the `useForm` composables provides a context object with Vue's `provide()` API, each field that is created with `useField` or `<Field />` component injects that context with `inject()` and registers itself with the context API.

That means that vee-validate's API doesn't care about elements or their tag names. This is why it is UI agnostic, all it cares about is `useForm` and `useField` and by extension, `<Form />` and `<Field />` components.

> Now how do I separate forms from each other?

Not sure what do you mean, can you elaborate? Typically calling `us...