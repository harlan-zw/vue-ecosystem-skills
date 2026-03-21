---
number: 2164
title: "Is there any way to test Deep Selectors (`:deep()`) ?"
category: "Q&A"
created: 2023-08-19
url: "https://github.com/vuejs/test-utils/discussions/2164"
upvotes: 1
comments: 1
answered: false
---

# Is there any way to test Deep Selectors (`:deep()`) ?

```vue
<style scoped>
.a :deep(.b) {
  /* ... */
}
</style>
```

Is there any way or workaround to test the `:deep()` is be applied correctly to the element ?  

---

## Top Comments

**@freakzlike** [maintainer]:

I would use some E2E real browser testing (like Cypress) and check if the style has been applied to the element 