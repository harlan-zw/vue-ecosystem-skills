---
number: 1969
title: Testing v-model type matching error/warning when using TypeScript
category: "Q&A"
created: 2023-02-09
url: "https://github.com/vuejs/test-utils/discussions/1969"
upvotes: 1
comments: 1
answered: true
---

# Testing v-model type matching error/warning when using TypeScript

I'm testing that a component correctly updates a `v-model` value after clicking a button. 

I followed the documentation for testing `v-model` and I've used the suggested approach of adding an `onUpdate:modelValue` prop like this:

```ts
const wrapper = mount(Editor, {
    props: {
      modelValue: 'initialText',
      'onUpdate:modelValue': (e) => wrapper.setProps({ modelValue: e })
    }
  })
```

The issue is that I get a type warning, because my components (eg: `Editor`) does not specify `onUpdate:modelValue` as a prop in `defineProps`.

What would be the correct way to handle this type warning properly? Is there any other approach except to use `(Editor as any)`? 

---

## Accepted Answer

**@cexbrayat** [maintainer]:

Hi @LondonAppDev 

We usually add `emits: ['update:modelValue'],` to the `Editor` component, and I think it should compile properly.
If that works as I expect, I'll add a note in the docs 