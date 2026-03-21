---
number: 2223
title: useSlots is not defined
category: "Q&A"
created: 2023-10-25
url: "https://github.com/vuejs/test-utils/discussions/2223"
upvotes: 1
comments: 2
answered: true
---

# useSlots is not defined

According to this Issue https://github.com/vuejs/vue-test-utils/issues/2033
Is there any solution for `"@vue/test-utils": "^2.4.1",`?

I can not test components with useSlots()...

---

## Accepted Answer

Excuse me.

The Issue is in Nuxt Auto Imports of Vue. Ref, UseSlots... needs to be imported into the component. The Auto Import Feature does not work in Test context