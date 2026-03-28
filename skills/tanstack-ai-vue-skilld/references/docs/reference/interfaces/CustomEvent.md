---
id: CustomEvent
title: CustomEvent
---

# Interface: CustomEvent

Defined in: types.ts:944

Custom event for extensibility.

## Extends

- [`BaseAGUIEvent`](BaseAGUIEvent.md)

## Properties

### model?

```ts
optional model: string;
```

Defined in: types.ts:756

Model identifier for multi-model support

#### Inherited from

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`model`](BaseAGUIEvent.md#model)

***

### name

```ts
name: string;
```

Defined in: types.ts:947

Custom event name

***

### rawEvent?

```ts
optional rawEvent: unknown;
```

Defined in: types.ts:758

Original provider event for debugging/advanced use cases

#### Inherited from

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`rawEvent`](BaseAGUIEvent.md#rawevent)

***

### timestamp

```ts
timestamp: number;
```

Defined in: types.ts:754

#### Inherited from

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`timestamp`](BaseAGUIEvent.md#timestamp)

***

### type

```ts
type: "CUSTOM";
```

Defined in: types.ts:945

#### Overrides

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`type`](BaseAGUIEvent.md#type)

***

### value?

```ts
optional value: unknown;
```

Defined in: types.ts:949

Custom event value
