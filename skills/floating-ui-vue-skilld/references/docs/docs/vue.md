---
title: "Vue | Floating UI"
meta:
  description: "A JavaScript library to position floating elements and create interactions for them."
---

# Vue

This package provides Vue bindings for `@floating-ui/dom` — a library that provides anchor positioning for a floating element to position it next to a given reference element.

```
npm install @floating-ui/vue
```

## [Usage](#usage)

`useFloating()` is the main composable:

```
<script setup>
import {ref} from 'vue';
import {useFloating} from '@floating-ui/vue';

const reference = ref(null);
const floating = ref(null);
const {floatingStyles} = useFloating(reference, floating);
</script>

<template>
  <button ref="reference">Button</button>
  <div ref="floating" :style="floatingStyles">Tooltip</div>
</template>
```

This will position the floating `Tooltip` element at the **bottom center** of the `Button` element by default.

- `reference` is the reference (or anchor) element that is being referred to for positioning.
- `floating` is the floating element that is being positioned relative to the reference element.
- `floatingStyles` is an object of positioning styles to apply to the floating element’s `style` attribute.

### [Disabling transform](#disabling-transform)

By default, the floating element is positioned using `transform` in the `floatingStyles` object. This is the most performant way to position elements, but can be disabled:

```
useFloating(reference, floating, {
  transform: false,
});
```

If you’d like to retain transform styles while allowing transform animations, create a wrapper, where the outermost node is the positioned one, and the inner is the actual styled element.

### [Custom position styles](#custom-position-styles)

The composable returns the coordinates and positioning strategy directly if `floatingStyles` is not suitable for full customization.

```
const {x, y, strategy} = useFloating(reference, floating);
```

## [Return value](#return-value)

The composable returns all the values from `computePosition`, plus some extras to work with Vue. This includes data about the final placement and middleware data which are useful when rendering.

## [Options](#options)

The composable accepts all the options from `computePosition`, which allows you to customize the position. Here’s an example:

```
import {
  useFloating,
  offset,
  flip,
  shift,
} from '@floating-ui/vue';

// Inside your component
useFloating(reference, floating, {
  placement: 'right',
  middleware: [offset(10), flip(), shift()],
});
```

The composable also accepts `Ref` options:

```
import {
  useFloating,
  offset,
  flip,
  shift,
} from '@floating-ui/vue';

// Inside your component
const placement = ref('right');
const middleware = ref([offset(10), flip(), shift()]);
useFloating(reference, floating, {
  placement,
  middleware,
});
```

Middleware can alter the positioning from the basic `placement`, act as visibility optimizers, or provide data to use.

The docs for the middleware that were passed are available here:

- `offset`
- `flip`
- `shift`

## [Anchoring](#anchoring)

The position is only calculated **once** on render, or when the `reference` or `floating` elements changed — for example, the floating element get mounted via conditional rendering.

To ensure the floating element remains anchored to its reference element in a variety of scenarios without detaching — such as when scrolling or resizing the page — you can pass the `autoUpdate` utility to the `whileElementsMounted` prop:

```
import {useFloating, autoUpdate} from '@floating-ui/vue';

// Inside your component
useFloating(reference, floating, {
  whileElementsMounted: autoUpdate,
});
```

To pass options to `autoUpdate`:

```
useFloating(reference, floating, {
  whileElementsMounted(...args) {
    const cleanup = autoUpdate(...args, {animationFrame: true});
    // Important! Always return the cleanup function.
    return cleanup;
  },
});
```

Ensure you are using conditional rendering (`v-if`) for the floating element, not an opacity/visibility/display style. If you are using `v-show` instead, avoid the `whileElementsMounted` prop.

### [Manual updating](#manual-updating)

While `autoUpdate` covers most cases where the position of the floating element must be updated, it does not cover every single one possible due to performance/platform limitations.

The composable returns an `update()` function to update the position at will:

```
<script setup>
const {update} = useFloating(reference, floating);
</script>

<template>
  <Panel @resize="update" />
</template>
```

## [Custom components](#custom-components)

The composable also accepts custom component template refs:

```
<script setup>
import {ref} from 'vue';
import {useFloating} from '@floating-ui/vue';

import MyButton from './MyButton.vue';
import MyTooltip from './MyTooltip.vue';

const reference = ref(null);
const floating = ref(null);
const {floatingStyles} = useFloating(reference, floating);
</script>

<template>
  <MyButton ref="reference">Button</MyButton>
  <MyTooltip ref="floating">Tooltip</MyTooltip>
</template>
```

## [Effects](#effects)

Positioning is done in an async function, which means the position is ready during a microtask, after layout effects are executed. This means initially, the floating element is situated at the top-left (0, 0) of its offset container — so calling DOM methods that cause side-effects like scrolling will result in unexpected behavior.

The composable returns an `isPositioned` boolean ref that lets you know if the floating element has been positioned:

```
const open = ref(false);
const {isPositioned} = useFloating(reference, floating, {
  // Synchronize \`isPositioned\` with an \`open\` ref.
  open,
});

// Each time the floating element opens, we want to focus and
// scroll some element into view.
watch(isPositioned, (isPositioned) => {
  if (isPositioned) {
    someElement.focus();
    someElement.scrollIntoView();
  }
});
```

The `open` option accepts a boolean ref that represents the open/close state of the floating element. This ensures you can wait each time it opens when the host component does not unmount, which is necessary in cases where the reference element relocates on the page.

## [Arrow](#arrow)

The `arrow` module exported from this package allows template refs in addition to elements. See arrow for details.

```
<script setup>
import {arrow, useFloating} from '@floating-ui/vue';
import {ref} from 'vue';

const reference = ref(null);
const floating = ref(null);
const floatingArrow = ref(null);

const {floatingStyles, middlewareData} = useFloating(
  reference,
  floating,
  {
    middleware: [arrow({element: floatingArrow})],
  },
);
</script>

<template>
  <span ref="reference">Reference</span>
  <div ref="floating" :style="floatingStyles">
    Floating
    <div
      ref="floatingArrow"
      :style="{
        position: 'absolute',
        left:
          middlewareData.arrow?.x != null
            ? \`${middlewareData.arrow.x}px\`
            : '',
        top:
          middlewareData.arrow?.y != null
            ? \`${middlewareData.arrow.y}px\`
            : '',
      }"
    ></div>
  </div>
</template>
```

## [Virtual Element](#virtual-element)

See Virtual Elements for details. Example:

```
<script setup>
import {onMounted, ref} from 'vue';
import {useFloating} from '@floating-ui/vue';

const reference = ref(null);
const floating = ref(null);
const {floatingStyles} = useFloating(reference, floating);

onMounted(() => {
  /**
   * Assign the virtual element to reference inside
   * a lifecycle hook or effect or event handler.
   */
  reference.value = {
    getBoundingClientRect() {
      return {
        // ...
      };
    },
  };
});
</script>

<template>
  <div ref="floating">Tooltip</div>
</template>
```

React Native Prev: React Native MigrationNext: Migration