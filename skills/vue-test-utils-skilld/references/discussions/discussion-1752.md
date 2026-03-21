---
number: 1752
title: How would you simplify this unit tested Vue component?
category: "Q&A"
created: 2022-09-05
url: "https://github.com/vuejs/test-utils/discussions/1752"
upvotes: 1
comments: 1
answered: true
---

# How would you simplify this unit tested Vue component?

I have a simple card component that is unit/component tested and would like to know if I can simplify it.

Basically, it's just a card that has a header, footer, and content slot. If one of these slots is not used, the parent container will not render.

```html
<template>
  <div class="card">
    <header v-if="$slots.header" class="card-header">
      <slot name="header" />
    </header>
    <div v-if="$slots.content" class="card-content">
      <slot name="content" />
    </div>
    <div v-if="$slots.footer" class="card-footer">
      <slot name="footer" />
    </div>
    <b-loading v-model="isLoading" :is-full-page="false"></b-loading>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
  name: 'AppCard',
  props: {
    isLoading: {
      type: Boolean,
      default: false,
    },
  },
});
</script>
```...

---

## Accepted Answer

**@freakzlike** [maintainer]:

Doesn't look too bad for me. I personally would group them to have a better overview what is related to that specific test case:
```ts
describe('<AppCard />', () => {
  /**
   * Header
   */
  describe('header', () => {
    it('renders element within .card-header', () => {
      const wrapper = mount(AppCard, {
        slots: {
          header: '<div>Header</div>'
        }
      })

      expect(wrapper.find('.card-header').text()).toBe('Header')
    })

    it('removes .card-header when no element is passed', () => {
      const wrapper = mount(AppCard)

      expect(wrapper.find('.card-header').exists()).toBe(false)
    })
  })

  /**
   * Content
   */
  describe('content', () => {
    it('renders element within .card-content', () => {
      const wrapper = mount(AppCard, {
        slots: {
          content: '<div>Content</div>'
        }
      })

      expect(wrapper.find('.card-content').text()).toBe('Content')
    })

    it('removes .card-content when no element is passed', () => {
      const wrapper = mount(AppCard)

      expect(wrapper.find('.card-content').exists()).toBe(false)
    })
  })
...
```...