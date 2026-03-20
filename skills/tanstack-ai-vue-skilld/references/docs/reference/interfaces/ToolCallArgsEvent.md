---
id: ToolCallArgsEvent
title: ToolCallArgsEvent
---

# Interface: ToolCallArgsEvent

Defined in: types.ts:854

Emitted when tool call arguments are streaming.

## Extends

- [`BaseAGUIEvent`](BaseAGUIEvent.md)

## Properties

### args?

```ts
optional args: string;
```

Defined in: types.ts:861

Full accumulated arguments so far

***

### delta

```ts
delta: string;
```

Defined in: types.ts:859

Incremental JSON arguments delta

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

### toolCallId

```ts
toolCallId: string;
```

Defined in: types.ts:857

Tool call identifier

***

### type

```ts
type: "TOOL_CALL_ARGS";
```

Defined in: types.ts:855

#### Overrides

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`type`](BaseAGUIEvent.md#type)
