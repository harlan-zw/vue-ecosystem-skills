---
id: StateDeltaEvent
title: StateDeltaEvent
---

# Interface: StateDeltaEvent

Defined in: types.ts:928

Emitted to provide an incremental state update.

## Extends

- [`BaseAGUIEvent`](BaseAGUIEvent.md)

## Properties

### delta

```ts
delta: Record<string, unknown>;
```

Defined in: types.ts:931

The state changes to apply

***

### model?

```ts
optional model: string;
```

Defined in: types.ts:751

Model identifier for multi-model support

#### Inherited from

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`model`](BaseAGUIEvent.md#model)

***

### rawEvent?

```ts
optional rawEvent: unknown;
```

Defined in: types.ts:753

Original provider event for debugging/advanced use cases

#### Inherited from

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`rawEvent`](BaseAGUIEvent.md#rawevent)

***

### timestamp

```ts
timestamp: number;
```

Defined in: types.ts:749

#### Inherited from

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`timestamp`](BaseAGUIEvent.md#timestamp)

***

### type

```ts
type: "STATE_DELTA";
```

Defined in: types.ts:929

#### Overrides

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`type`](BaseAGUIEvent.md#type)
