---
id: MessagesSnapshotEvent
title: MessagesSnapshotEvent
---

# Interface: MessagesSnapshotEvent

Defined in: types.ts:910

Emitted to provide a snapshot of all messages in a conversation.

Unlike StateSnapshot (which carries arbitrary application state),
MessagesSnapshot specifically delivers the conversation transcript.
This is a first-class AG-UI event type.

## Extends

- [`BaseAGUIEvent`](BaseAGUIEvent.md)

## Properties

### messages

```ts
messages: UIMessage[];
```

Defined in: types.ts:913

Complete array of messages in the conversation

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
type: "MESSAGES_SNAPSHOT";
```

Defined in: types.ts:911

#### Overrides

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`type`](BaseAGUIEvent.md#type)
