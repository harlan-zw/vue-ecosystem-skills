---
number: 1758
title: How can I test Composition API Computed Properties without mounting the component
category: "Q&A"
created: 2022-09-06
url: "https://github.com/vuejs/test-utils/discussions/1758"
upvotes: 1
comments: 1
answered: true
---

# How can I test Composition API Computed Properties without mounting the component

```javascript
// Options Api
it("renders odd numbers", () => {
  const localThis = { even: false }

  expect(NumberRenderer.computed.numbers.call(localThis)).toBe("1, 3, 5, 7, 9")
})
```

---

## Accepted Answer

**@freakzlike** [maintainer]:

That's not possible. You need to mount the component or move the computed into a composable. 