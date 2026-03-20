---
id: TextMessageStartEvent
title: TextMessageStartEvent
---

# Interface: TextMessageStartEvent

Defined in: types.ts:806

Emitted when a text message starts.

## Extends

- [`BaseAGUIEvent`](BaseAGUIEvent.md)

## Properties

### messageId

```ts
messageId: string;
```

Defined in: types.ts:809

Unique identifier for this message

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

### role

```ts
role: "user" | "assistant" | "tool" | "system";
```

Defined in: types.ts:811

Role of the message sender

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
type: "TEXT_MESSAGE_START";
```

Defined in: types.ts:807

#### Overrides

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`type`](BaseAGUIEvent.md#type)
