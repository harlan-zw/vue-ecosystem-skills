---
id: Store
title: Store
---

# Class: Store\<T, TActions\>

Defined in: store.ts:15

## Type Parameters

### T

`T`

### TActions

`TActions` *extends* [`StoreActionMap`](../type-aliases/StoreActionMap.md) = `never`

## Constructors

### Constructor

```ts
new Store<T, TActions>(getValue): Store<T, TActions>;
```

Defined in: store.ts:18

#### Parameters

##### getValue

(`prev?`) => `T`

#### Returns

`Store`\<`T`, `TActions`\>

### Constructor

```ts
new Store<T, TActions>(initialValue): Store<T, TActions>;
```

Defined in: store.ts:19

#### Parameters

##### initialValue

`T`

#### Returns

`Store`\<`T`, `TActions`\>

### Constructor

```ts
new Store<T, TActions>(initialValue, actionsFactory): Store<T, TActions>;
```

Defined in: store.ts:20

#### Parameters

##### initialValue

`NonFunction`\<`T`\>

##### actionsFactory

[`StoreActionsFactory`](../type-aliases/StoreActionsFactory.md)\<`T`, `TActions`\>

#### Returns

`Store`\<`T`, `TActions`\>

## Properties

### actions

```ts
readonly actions: TActions;
```

Defined in: store.ts:17

## Accessors

### state

#### Get Signature

```ts
get state(): T;
```

Defined in: store.ts:46

##### Returns

`T`

## Methods

### get()

```ts
get(): T;
```

Defined in: store.ts:49

#### Returns

`T`

***

### setState()

```ts
setState(updater): void;
```

Defined in: store.ts:43

#### Parameters

##### updater

(`prev`) => `T`

#### Returns

`void`

***

### subscribe()

```ts
subscribe(observerOrFn): Subscription;
```

Defined in: store.ts:52

#### Parameters

##### observerOrFn

[`Observer`](../type-aliases/Observer.md)\<`T`\> | (`value`) => `void`

#### Returns

[`Subscription`](../interfaces/Subscription.md)
