---
number: 1850
title: Input Value is not Passed to Spied Function
category: "Q&A"
created: 2022-11-09
url: "https://github.com/vuejs/test-utils/discussions/1850"
upvotes: 1
comments: 2
answered: true
---

# Input Value is not Passed to Spied Function

Hi Folks 

I am a newbie trying to get my first tests working for VueJS.  Sorry, I tried my best Googling and reading the docs but could not figure this out.

I have the following component and test that calls out to a Pinia store.  I am trying to verify that the store method is called with the proper arguments.  Try as I may, I cannot figure out why the `message` attribute is always being passed to the function as an empty string.

Test Failure Message:
```
Received: 
    1st spy call:

    Array [
      Object {
  -     "message": "arbitrary message",
  +     "message": "",
      },
    ]
Number of calls: 1
```

Any ideas on where I goofed?

Thank you for your time 

Demo App & Tests that reproduces the error: https://stackblitz.com/edit/vitejs-vite-38qokp?fil...

---

## Accepted Answer

**@cexbrayat** [maintainer]:

Hi @zhao-li 
Can you make an online repro using https://stackblitz.com/edit/vitest-dev-vitest-fum9v4?initialPath=__vitest__ ?
It's easier for us to take a look.