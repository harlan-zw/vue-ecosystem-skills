---
number: 2630
title: Unable to set value of headlessui Combobox in unit tests
category: "Q&A"
created: 2025-03-12
url: "https://github.com/vuejs/test-utils/discussions/2630"
upvotes: 1
comments: 1
answered: true
---

# Unable to set value of headlessui Combobox in unit tests

Hello,

I’m currently experiencing an issue when trying to set a value for the `Combobox` component in my unit tests using Vue Test Utils. I’ve created a minimal example to reproduce the issue, which you can view here: StackBlitz Example.

In my tests, I am unable to set a value for the `Combobox` component, and I’m unsure of the correct approach to do so.

Please note that unit tests are not runnable in StackBlitz. You will need to download the repository and run the tests locally:
1. Run `npm install`
2. Run `npm test:unit`

I would appreciate any help or guidance on how to set the value for the Combobox correctly in unit tests using Vue Test Utils.

Thank you in advance!

---

## Accepted Answer

**@cexbrayat** [maintainer]:

It looks like they are not listening to clicks but to mousedown on options https://github.com/tailwindlabs/headlessui/blob/0a8de016e8f4f6f3c27fdebe8fe79debdd2ae4fb/packages/%40headlessui-vue/src/components/combobox/combobox.ts#L1475

If that's not enough, I think your best shot is to ask the question on the headlessui repo, as this is not really an issue with VTU but rather an implementation detail of headlessui to figure out in order to make your test pass