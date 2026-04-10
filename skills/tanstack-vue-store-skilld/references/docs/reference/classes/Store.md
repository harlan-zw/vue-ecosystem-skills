---
id: Store
title: Store
---

# Class: Store\<TState, TUpdater\>

Defined in: store.ts:28

## Type Parameters

### TState

`TState`

### TUpdater

`TUpdater` *extends* `AnyUpdater` = (`cb`) => `TState`

## Constructors

### Constructor

```ts
new Store<TState, TUpdater>(initialState, options?): Store<TState, TUpdater>;
```

Defined in: store.ts:37

#### Parameters

##### initialState

`TState`

##### options?

[`StoreOptions`](../../interfaces/StoreOptions.md)\<`TState`, `TUpdater`\>

#### Returns

`Store`\<`TState`, `TUpdater`\>

## Properties

### listeners

```ts
listeners: Set<Listener<TState>>;
```

Defined in: store.ts:32

***

### options?

```ts
optional options: StoreOptions<TState, TUpdater>;
```

Defined in: store.ts:35

***

### prevState

```ts
prevState: TState;
```

Defined in: store.ts:34

***

### state

```ts
state: TState;
```

Defined in: store.ts:33

## Methods

### setState()

#### Call Signature

```ts
setState(updater): void;
```

Defined in: store.ts:55

Update the store state safely with improved type checking

##### Parameters

###### updater

(`prevState`) => `TState`

##### Returns

`void`

#### Call Signature

```ts
setState(updater): void;
```

Defined in: store.ts:56

Update the store state safely with improved type checking

##### Parameters

###### updater

`TState`

##### Returns

`void`

#### Call Signature

```ts
setState(updater): void;
```

Defined in: store.ts:57

Update the store state safely with improved type checking

##### Parameters

###### updater

`TUpdater`

##### Returns

`void`

***

### subscribe()

```ts
subscribe(listener): () => void;
```

Defined in: store.ts:43

#### Parameters

##### listener

`Listener`\<`TState`\>

#### Returns

```ts
(): void;
```

##### Returns

`void`
