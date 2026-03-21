---
number: 2226
title: how to test method in vue file
category: "Q&A"
created: 2023-10-26
url: "https://github.com/vuejs/test-utils/discussions/2226"
upvotes: 1
comments: 1
answered: true
---

# how to test method in vue file

foo.vue
```
<script setup>
const handleClick = () => {
  console.log(`click`)
}
</script>

<template>
  <button @click="handleClick">click me</button>
</template>
```

test.jsx

```
import { describe, expect, vi } from 'vitest'
import foo from 'foo.vue'
describe('foo', () => {
  it('click', async () => {
    const wrapper = mount(foo)

    await wrapper.find('button').trigger('click')
    await nextTick()

    expect(wrapper.vm.handleClick).toHaveBeenCalled() // to false  ,but i want true
  })
```

---

## Accepted Answer

**@cexbrayat** [maintainer]:

Hi @xxholly32 

You have to spy on the function before clicking on the button with `vi.spyOn(wrapper.vm, 'handleClick')`
Also you probably need to have parenthesis on your function call in your template `@click="handleClick()"`

If that does not work, can you provide us a small repro online using https://stackblitz.com/github/vuejs/create-vue-templates/tree/main/typescript-vitest?file=src%2Fcomponents%2F__tests__%2FHelloWorld.spec.ts ? 

It only takes a few minutes, and we'll be able to take a look