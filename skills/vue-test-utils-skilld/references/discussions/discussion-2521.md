---
number: 2521
title: How to call just beforeUnmount()?
category: "Q&A"
created: 2024-09-30
url: "https://github.com/vuejs/test-utils/discussions/2521"
upvotes: 1
comments: 1
answered: true
---

# How to call just beforeUnmount()?

Hey, 
I'm trying to unit test my code and keeping my tests specific to each method. How would I call beforeUnmount without calling any other methods and setting the appropriate props/data for the beforeUnmount() method?

Note: I tried the below but it seems the prop randomProp is still undefined in the call.

```
      await wrapper.setProps({ randomProp: ['propy1', 'propy2'] });
      await wrapper.vm.$options.beforeUnmount();
```


---

## Accepted Answer

**@cexbrayat** [maintainer]:

Hi @steven-twerdochlib 

You can call `wrapper.unmount()` which will unmount the component and call the hooks.