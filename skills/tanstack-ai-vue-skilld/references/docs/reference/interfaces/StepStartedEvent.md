---
id: StepStartedEvent
title: StepStartedEvent
---

# Interface: StepStartedEvent

Defined in: types.ts:882

Emitted when a thinking/reasoning step starts.

## Extends

- [`BaseAGUIEvent`](BaseAGUIEvent.md)

## Properties

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

### stepId

```ts
stepId: string;
```

Defined in: types.ts:885

Unique identifier for this step

***

### stepType?

```ts
optional stepType: string;
```

Defined in: types.ts:887

Type of step (e.g., 'thinking', 'planning')

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
type: "STEP_STARTED";
```

Defined in: types.ts:883

#### Overrides

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`type`](BaseAGUIEvent.md#type)
