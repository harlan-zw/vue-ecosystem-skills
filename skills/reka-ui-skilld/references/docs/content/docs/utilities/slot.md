---
title: Slot
description: Merges its props onto its immediate child.
---

# Slot

<Description>
Merges its props onto its immediate child.
</Description>

<Callout type="info" title="Question">

How is this component different from Vue native slot?

A: The biggest different is how it handles the `attributes` assigned to it.

</Callout>

Native slot treat any binded value as Scoped Slots, where the values will be exposed to the parent template and be consumed.

But Reka UI's slot behave differently, it would merge all the assigned attributes onto it's immediate child.

## Example

Say we want to assign an `id` attribute to whatever component/element that was rendered, but Native slot will convert it into a scoped slot, and you will need to assign that id manually.

```vue
<!-- Native Slot -->
<!-- Comp.vue -->
<template>
  <slot id="reka-01">
    ...
  </slot>
</template>

<!-- parent template -->
<template>
  <Comp v-slot="slotProps">
    <button :id="slotProps.id">...<button>
  <Comp>
<template>
```
(You can check out
Vue SFC Playground and see that the `id` wasn't being inherited.)

This would be troublesome if you want to ensure some attributes are being passed onto certain element, maybe for accessibility reason.

---

Alternatively, If you use `Slot` from Reka UI, the attributes assigned to the Slot component will be inherited by the immediate child element, but you will no longer have access to the `Scoped Slot`,

```vue
<!-- Reka UI Slot -->
<script setup lang="ts">
import { Slot } from 'reka-ui'
</script>

<!-- Comp.vue -->
<template>
  <Slot id="reka-01">
    ...
  </Slot>
</template>

<!-- parent template -->
<template>
  <Comp>
    <!-- id will be inherited -->
    <button>...<button>
  <Comp>
<template>
```
