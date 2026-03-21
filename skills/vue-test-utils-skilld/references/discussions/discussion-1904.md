---
number: 1904
title: Testing Suspense Component
category: "Q&A"
created: 2022-12-08
url: "https://github.com/vuejs/test-utils/discussions/1904"
upvotes: 1
comments: 1
answered: true
---

# Testing Suspense Component

I am trying to test a component with an async setup. The components I am working with in my project do not include their own suspense components, as I am trying to bubble them up and handle them in a single place. This all works well in my implementation, but I am unable to get default case to resolve.

This deviates slightly from the example specs in this repo, but it seems like what I am attempting to do should work.

I created a minimal example repo and a corresponding StackBlitz. The component suspends just fine in the browser, but the tests do...

---

## Accepted Answer

**@cexbrayat** [maintainer]:

Hi @jthn 

As you're waiting for 100ms in the promise, your test can't succeed
One easy way to workaround timers is to use `vi.useFakeTimers()`.

Something like:

```ts
const mountSuspense = async (component, options) => {
  // use fake timers
  vi.useFakeTimers();
  const c = defineComponent({
    render() {
      return h(Suspense, null, {
        default: h(component),
        fallback: h("div", "fallback"),
      })
    },
  })

  const wrapper = mount(c, options)
  // advance 100ms
  vi.advanceTimersByTime(100)
  await flushPromises()

  return wrapper
}
```
and I think the test should succeed