---
id: ToolCallStartEvent
title: ToolCallStartEvent
---

# Interface: ToolCallStartEvent

Defined in: types.ts:839

Emitted when a tool call starts.

## Extends

- [`BaseAGUIEvent`](BaseAGUIEvent.md)

## Properties

### index?

```ts
optional index: number;
```

Defined in: types.ts:848

Index for parallel tool calls

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

### parentMessageId?

```ts
optional parentMessageId: string;
```

Defined in: types.ts:846

ID of the parent message that initiated this tool call

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

Defined in: types.ts:842

Unique identifier for this tool call

***

### toolName

```ts
toolName: string;
```

Defined in: types.ts:844

Name of the tool being called

***

### type

```ts
type: "TOOL_CALL_START";
```

Defined in: types.ts:840

#### Overrides

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`type`](BaseAGUIEvent.md#type)
