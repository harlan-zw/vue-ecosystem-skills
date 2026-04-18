---
id: StoreActionsFactory
title: StoreActionsFactory
---

# Type Alias: StoreActionsFactory()\<T, TActions\>

```ts
type StoreActionsFactory<T, TActions> = (store) => TActions;
```

Defined in: store.ts:8

## Type Parameters

### T

`T`

### TActions

`TActions` *extends* [`StoreActionMap`](StoreActionMap.md)

## Parameters

### store

#### get

[`Store`](../classes/Store.md)\<`T`\>\[`"get"`\]

#### setState

[`Store`](../classes/Store.md)\<`T`\>\[`"setState"`\]

## Returns

`TActions`
