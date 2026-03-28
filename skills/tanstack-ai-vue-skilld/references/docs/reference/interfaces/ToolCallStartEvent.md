---
id: ToolCallStartEvent
title: ToolCallStartEvent
---

# Interface: ToolCallStartEvent

Defined in: types.ts:844

Emitted when a tool call starts.

## Extends

- [`BaseAGUIEvent`](BaseAGUIEvent.md)

## Properties

### index?

```ts
optional index: number;
```

Defined in: types.ts:853

Index for parallel tool calls

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

### parentMessageId?

```ts
optional parentMessageId: string;
```

Defined in: types.ts:851

ID of the parent message that initiated this tool call

***

### providerMetadata?

```ts
optional providerMetadata: Record<string, unknown>;
```

Defined in: types.ts:855

Provider-specific metadata to carry into the ToolCall

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

### toolCallId

```ts
toolCallId: string;
```

Defined in: types.ts:847

Unique identifier for this tool call

***

### toolName

```ts
toolName: string;
```

Defined in: types.ts:849

Name of the tool being called

***

### type

```ts
type: "TOOL_CALL_START";
```

Defined in: types.ts:845

#### Overrides

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`type`](BaseAGUIEvent.md#type)
