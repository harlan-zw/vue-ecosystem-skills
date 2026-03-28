---
id: StepFinishedEvent
title: StepFinishedEvent
---

# Interface: StepFinishedEvent

Defined in: types.ts:900

Emitted when a thinking/reasoning step finishes.

## Extends

- [`BaseAGUIEvent`](BaseAGUIEvent.md)

## Properties

### content?

```ts
optional content: string;
```

Defined in: types.ts:907

Full accumulated thinking content (optional, for debugging)

***

### delta

```ts
delta: string;
```

Defined in: types.ts:905

Incremental thinking content

***

### model?

```ts
optional model: string;
```

Defined in: types.ts:756

Model identifier for multi-model support

#### Inherited from

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`model`](BaseAGUIEvent.md#model)

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

### stepId

```ts
stepId: string;
```

Defined in: types.ts:903

Step identifier

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
type: "STEP_FINISHED";
```

Defined in: types.ts:901

#### Overrides

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`type`](BaseAGUIEvent.md#type)
