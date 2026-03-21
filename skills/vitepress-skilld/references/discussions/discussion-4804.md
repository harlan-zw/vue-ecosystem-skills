---
number: 4804
title: "Remove the inner `div` in the `Content` component?"
category: "Q&A"
created: 2025-06-21
url: "https://github.com/vuejs/vitepress/discussions/4804"
upvotes: 1
comments: 1
answered: true
---

# Remove the inner `div` in the `Content` component?

I'm trying to remove the div that is the immediate child in the `Content` component around the rendered markdown.

Is this something that I can configure to remove at all?

---

## Accepted Answer

I didn't figure out how to remove it completely but I figured out a decent enough work-around to create my own theme:

```vue
<script setup>
  import { useRoute } from 'vitepress'
  const { route } useRoute()
</script>

<template>
  <component :is="route.component" role="main" />
<template>
```