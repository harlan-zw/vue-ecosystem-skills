---
id: Derived
title: Derived
---

# Class: Derived\<TState, TArr\>

Defined in: derived.ts:61

## Type Parameters

### TState

`TState`

### TArr

`TArr` *extends* `ReadonlyArray`\<`Derived`\<`any`\> \| [`Store`](../Store.md)\<`any`\>\> = `ReadonlyArray`\<`any`\>

## Constructors

### Constructor

```ts
new Derived<TState, TArr>(options): Derived<TState, TArr>;
```

Defined in: derived.ts:96

#### Parameters

##### options

[`DerivedOptions`](../../interfaces/DerivedOptions.md)\<`TState`, `TArr`\>

#### Returns

`Derived`\<`TState`, `TArr`\>

## Properties

### lastSeenDepValues

```ts
lastSeenDepValues: unknown[] = [];
```

Defined in: derived.ts:78

***

### listeners

```ts
listeners: Set<Listener<TState>>;
```

Defined in: derived.ts:67

***

### options

```ts
options: DerivedOptions<TState, TArr>;
```

Defined in: derived.ts:70

***

### prevState

```ts
prevState: TState | undefined;
```

Defined in: derived.ts:69

***

### state

```ts
state: TState;
```

Defined in: derived.ts:68

## Methods

### checkIfRecalculationNeededDeeply()

```ts
checkIfRecalculationNeededDeeply(): void;
```

Defined in: derived.ts:178

#### Returns

`void`

***

### getDepVals()

```ts
getDepVals(): object;
```

Defined in: derived.ts:79

#### Returns

`object`

##### currDepVals

```ts
currDepVals: unknown[];
```

##### prevDepVals

```ts
prevDepVals: unknown[];
```

##### prevVal

```ts
prevVal: NonNullable<TState> | undefined;
```

***

### mount()

```ts
mount(): () => void;
```

Defined in: derived.ts:199

#### Returns

```ts
(): void;
```

##### Returns

`void`

***

### recompute()

```ts
recompute(): void;
```

Defined in: derived.ts:170

#### Returns

`void`

***

### registerOnGraph()

```ts
registerOnGraph(deps): void;
```

Defined in: derived.ts:105

#### Parameters

##### deps

readonly (
  \| `Derived`\<`any`, readonly `any`[]\>
  \| [`Store`](../Store.md)\<`any`, (`cb`) => `any`\>)[] = `...`

#### Returns

`void`

***

### subscribe()

```ts
subscribe(listener): () => void;
```

Defined in: derived.ts:211

#### Parameters

##### listener

`Listener`\<`TState`\>

#### Returns

```ts
(): void;
```

##### Returns

`void`

***

### unregisterFromGraph()

```ts
unregisterFromGraph(deps): void;
```

Defined in: derived.ts:147

#### Parameters

##### deps

readonly (
  \| `Derived`\<`any`, readonly `any`[]\>
  \| [`Store`](../Store.md)\<`any`, (`cb`) => `any`\>)[] = `...`

#### Returns

`void`
