---
number: 4799
title: How to avoid unwanted error message to be shown instantly?
category: "Q&A"
created: 2024-07-01
url: "https://github.com/logaretm/vee-validate/discussions/4799"
upvotes: 1
comments: 3
answered: true
---

# How to avoid unwanted error message to be shown instantly?

Hello,
I have a problem of the unwanted error message
is shown instantly and then hidden again.

This form shows an input text when the checkbox is checked.
This text input is a required field.
Initially, before any user inputs, we do not want to the "required"
error message.
However after user inputs, we do want to the "required" error message
if the text is empty.

  Test scenario:
  1. Check the checkbox.
  2. Input a character.

  Things happened:
  * The error message is shown instantly and then become hidden (only for the first time).

  Expected behavior:
  * The error message is not shown when a character is added.

The demo of this problem:
https://stackblitz.com/edit/cplk4q-ezqvta?file=src%2FApp.vue

Could you let me know how to avoid this problem?
Thank ...

---

## Accepted Answer

I found that I can achieve the behavior I want using `resetField` from `useField`.
https://stackblitz.com/edit/cplk4q-ezqvta?file=src%2FApp.vue
