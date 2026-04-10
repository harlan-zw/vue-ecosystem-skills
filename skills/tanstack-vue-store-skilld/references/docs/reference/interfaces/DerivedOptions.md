---
id: DerivedOptions
title: DerivedOptions
---

# Interface: DerivedOptions\<TState, TArr\>

Defined in: derived.ts:45

## Type Parameters

### TState

`TState`

### TArr

`TArr` *extends* `ReadonlyArray`\<
  \| [`Derived`](../../classes/Derived.md)\<`any`\>
  \| [`Store`](../../classes/Store.md)\<`any`\>\> = `ReadonlyArray`\<`any`\>

## Properties

### deps

```ts
deps: TArr;
```

Defined in: derived.ts:54

***

### fn()

```ts
fn: (props) => TState;
```

Defined in: derived.ts:58

Values of the `deps` from before and after the current invocation of `fn`

#### Parameters

##### props

[`DerivedFnProps`](../DerivedFnProps.md)\<`TArr`\>

#### Returns

`TState`

***

### onSubscribe()?

```ts
optional onSubscribe: (listener, derived) => () => void;
```

Defined in: derived.ts:49

#### Parameters

##### listener

`Listener`\<`TState`\>

##### derived

[`Derived`](../../classes/Derived.md)\<`TState`\>

#### Returns

```ts
(): void;
```

##### Returns

`void`

***

### onUpdate()?

```ts
optional onUpdate: () => void;
```

Defined in: derived.ts:53

#### Returns

`void`
