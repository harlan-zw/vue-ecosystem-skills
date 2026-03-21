---
number: 2680
title: "How to get an element that's not a descendant of the testing component?"
category: "Q&A"
created: 2025-07-01
url: "https://github.com/vuejs/test-utils/discussions/2680"
upvotes: 1
comments: 1
answered: true
---

# How to get an element that's not a descendant of the testing component?

Some components (like Buefy's tooltip with `append-to-body`) attach to the `body`, so they aren't a descendant of the component mounted for testing and can't be selected with the `find/get` methods provided by Vue test utils. These components don't use `Teleport`, so the solution of stubbing it doesn't apply. Is there a way to get a wrapper of these components without using `document.querySelector`?

---

## Accepted Answer

**@cexbrayat** [maintainer]:

Hi @rivaldi8 
I don't think so, I also use querySelector in those cases.