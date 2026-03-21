---
number: 1876
title: How to test an async setups with props?
category: "Q&A"
created: 2022-11-17
url: "https://github.com/vuejs/test-utils/discussions/1876"
upvotes: 1
comments: 1
answered: true
---

# How to test an async setups with props?

In the Documentation, the Code for an async setup is the following:

```
test('Async component', () => {
  const TestComponent = defineComponent({
    components: { Async },
    template: '<Suspense><Async/></Suspense>'
  })

  const wrapper = mount(TestComponent)
  // ...
})
```


That works perfectly. But what if, i want to set props of "Async"? 

I cant' set them via wrapper.vm.setProps and i cant set them in the mount(...) Function, because these are the props from TestComponent. I also tried to write it into the Template, as in usual Vue Templates - that results, that the Object is converted to a String...

---

## Accepted Answer

**@cexbrayat** [maintainer]:

If I understand your question correctly, I would do something like that:

```ts
test('Async component', () => {
  const TestComponent = defineComponent({
    components: { Async },
    template: '<Async :something="something" />',
    props: { something: Object }
  })

  const wrapper = mount(TestComponent, { props: { something: { hello: 'world' } })
})
```