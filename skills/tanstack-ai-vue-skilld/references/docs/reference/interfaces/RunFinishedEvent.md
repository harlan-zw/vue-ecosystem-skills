---
id: RunFinishedEvent
title: RunFinishedEvent
---

# Interface: RunFinishedEvent

Defined in: types.ts:775

Emitted when a run completes successfully.

## Extends

- [`BaseAGUIEvent`](BaseAGUIEvent.md)

## Properties

### finishReason

```ts
finishReason: "length" | "stop" | "content_filter" | "tool_calls" | null;
```

Defined in: types.ts:780

Why the generation stopped

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

### runId

```ts
runId: string;
```

Defined in: types.ts:778

Run identifier

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
type: "RUN_FINISHED";
```

Defined in: types.ts:776

#### Overrides

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`type`](BaseAGUIEvent.md#type)

***

### usage?

```ts
optional usage: object;
```

Defined in: types.ts:782

Token usage statistics

#### completionTokens

```ts
completionTokens: number;
```

#### promptTokens

```ts
promptTokens: number;
```

#### totalTokens

```ts
totalTokens: number;
```
