---
number: 2215
title: Struggle to properly mock child component with third party dependency in it
category: "Q&A"
created: 2023-10-17
url: "https://github.com/vuejs/test-utils/discussions/2215"
upvotes: 1
comments: 1
answered: true
---

# Struggle to properly mock child component with third party dependency in it

Hey there, continue to learn unit testing, currently got an issues with testing a component, which have child component + library usage onMount hook. I try both mount / shallowMount, for some reason shallowMount not stubbing child component and i fail to manage make simple wrapper exist test run.

Here's the fork: 
https://stackblitz.com/edit/github-39zexb?file=src%2Fcomponents%2FLoginView.vue

Error i got: 

```
Error: [vitest] There was an error when mocking a module. If you are using "vi.mock" factory, make sure there are no top level variables inside, since this call is hoisted to top of the file. Read more: https://vitest.dev/api/vi.html#vi-mock
 ❯ src/auth/ui/AuthForm.vue:3:31
      1| <script setup lang="ts">
      2| import { openModal } from '@kolirt/vue-modal'
      3| import { $off, $on, Events, account, connect, disconnect } from '@kolirt/vue-web3-auth'
       |                               ^
      4| import { defineAsyncComponent, onBeforeUnmount, onMounted } from 'vue'
      5| 
 ❯ src/02-pages/views/LoginView.vue:3:31

```...

---

## Accepted Answer

**@cexbrayat** [maintainer]:

If you use shallow mount, then the child component is not used, but the import to your third party lib is still executed, and fails with `TypeError: window.matchMedia is not a function`, because jsdom probably does not support this function.

So you can either patch the window object to add matchMedia in your test (maybe look on the issue tracker of jsdom), or mock the third dependency completely if you use shallowMount:

```ts
vi.mock('@kolirt/vue-web3-auth', () => {
  return {};
});

describe('LoginView.vue', () => {
  const wrapper = shallowMount(LoginView);
  it('should render properly', () => {
    expect(wrapper.exists()).toBeTruthy();
  });
});
```