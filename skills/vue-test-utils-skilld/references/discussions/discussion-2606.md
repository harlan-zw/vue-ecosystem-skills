---
number: 2606
title: "How to stub out lifecycle hooks in `<script setup>`?"
category: "Q&A"
created: 2025-01-24
url: "https://github.com/vuejs/test-utils/discussions/2606"
upvotes: 1
comments: 1
answered: true
---

# How to stub out lifecycle hooks in `<script setup>`?

When using the options API, you could stub out a lifecycle hook by passing an empty function to the `mount` function, e.g.
```js
mount(Component, {
  mounted () {},
})
```

How do you do this when using the composition API and `<script setup>`?

---

## Accepted Answer

**@cexbrayat** [maintainer]:

Sorry for the delay. You're correctly assuming this is not possible. I don't think we'll want to implement this, as it should not be necessary. But if you want to open a feature request, feel free to do so and provide a concrete repro.