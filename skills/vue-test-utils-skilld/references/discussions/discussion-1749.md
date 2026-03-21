---
number: 1749
title: What is the proper way of testing a component in Vue with API calls?
category: "Q&A"
created: 2022-09-04
url: "https://github.com/vuejs/test-utils/discussions/1749"
upvotes: 1
comments: 1
answered: true
---

# What is the proper way of testing a component in Vue with API calls?

I have a problem understand testing Vue components. In the component testing docs, it says:

> Component tests should focus on the component's public interfaces
> rather than internal implementation details. For most components, the
> public interface is limited to: events emitted, props, and slots. When
> testing, remember to test what a component does, not how it does it.

Say you have a Form Component:

...

---

## Accepted Answer

**@cexbrayat** [maintainer]:

Hi @walmartwarlord 

This test looks great to me. This is really close to what I would do and what I recommend in my book.

nit: flush promise is exposed by VTU, so you can import it from `@vue/test-utils` . And I would use the composition API for the component 