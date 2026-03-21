---
number: 2208
title: How to check for WrapperLike type
category: "Q&A"
created: 2023-10-06
url: "https://github.com/vuejs/test-utils/discussions/2208"
upvotes: 2
comments: 1
answered: true
---

# How to check for WrapperLike type

We wrote a plugin which requires us to check for 'WrapperLike', but this type isn't exported. 

How would you guys propose we check for this?


---

## Accepted Answer

**@cexbrayat** [maintainer]:

Ha yes I understand why. You're trying to find components using a string selector, which loses all type-safety and returns a WrapperLike.

You can make it work with something like:

```ts
function testIdPlugin(wrapper: VueWrapper | DOMWrapper<Node>): {
  findByTestId: (name: string, isComponent: boolean) => BaseWrapper<Node>;
} {
  return {
    findByTestId(name: string, isComponent: boolean) {
      return isComponent
        ? wrapper.findComponent(`[data-test-id='${name}']`) as BaseWrapper<Node>
        : wrapper.find(`[data-test-id='${name}']`);
    }
  };
}
```

But to be honest with you, I think you're shooting yourself in the foot by trying to do this if you care about type safety.
The "type-safe way" to find a component is by using its type rather than a CSS selector. That way, you get a properly typed `VueWrapper`, with its `vm` reflecting its proper type.