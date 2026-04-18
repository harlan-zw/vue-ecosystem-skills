---
id: ReadonlyStore
title: ReadonlyStore
---

# Class: ReadonlyStore\<T\>

Defined in: store.ts:59

## Type Parameters

### T

`T`

## Implements

- `Omit`\<[`Store`](Store.md)\<`T`\>, `"setState"` \| `"actions"`\>

## Constructors

### Constructor

```ts
new ReadonlyStore<T>(getValue): ReadonlyStore<T>;
```

Defined in: store.ts:64

#### Parameters

##### getValue

(`prev?`) => `T`

#### Returns

`ReadonlyStore`\<`T`\>

### Constructor

```ts
new ReadonlyStore<T>(initialValue): ReadonlyStore<T>;
```

Defined in: store.ts:65

#### Parameters

##### initialValue

`T`

#### Returns

`ReadonlyStore`\<`T`\>

## Accessors

### state

#### Get Signature

```ts
get state(): T;
```

Defined in: store.ts:73

##### Returns

`T`

#### Implementation of

```ts
Omit.state
```

## Methods

### get()

```ts
get(): T;
```

Defined in: store.ts:76

#### Returns

`T`

#### Implementation of

```ts
Omit.get
```

***

### subscribe()

```ts
subscribe(observerOrFn): Subscription;
```

Defined in: store.ts:79

#### Parameters

##### observerOrFn

[`Observer`](../type-aliases/Observer.md)\<`T`\> | (`value`) => `void`

#### Returns

[`Subscription`](../interfaces/Subscription.md)

#### Implementation of

```ts
Omit.subscribe
```
