---
number: 1728
title: Test a Mock Router with composition API adn Vitest
category: "Q&A"
created: 2022-08-19
url: "https://github.com/vuejs/test-utils/discussions/1728"
upvotes: 1
comments: 1
answered: true
---

# Test a Mock Router with composition API adn Vitest

Hi
I woudl like to test a vue component with a router using vitest. I following this guide but I have problems
https://test-utils.vuejs.org/guide/advanced/vue-router.html#using-a-mocked-router-with-composition-api

This is my component 
```html
<button
      data-testid="DayButton"
      class="btn btn-primary"
      @click="goToDaybook()"
    >
      DayBook
    </button>
```
```js
<script setup>
  import { useRouter } from 'vue-router'

  const router = useRouter()

  const goToDaybook = () => router.push({ name: 'daybook-no-entry' })
  const goToAbout = () => router.push({ name: 'about' })
</script>
```

Here it is my test

...

---

## Accepted Answer

**@freakzlike** [maintainer]:

You overwrite your method with `wrapper.vm.goToDaybook = vi.fn()`. So it will no longer do it's normal logic (calling `router.push`). Remove the check of `wrapper.vm.goToDaybook` and try again