---
id: TextMessageEndEvent
title: TextMessageEndEvent
---

# Interface: TextMessageEndEvent

Defined in: types.ts:830

Emitted when a text message completes.

## Extends

- [`BaseAGUIEvent`](BaseAGUIEvent.md)

## Properties

### messageId

```ts
messageId: string;
```

Defined in: types.ts:833

Message identifier

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
type: "TEXT_MESSAGE_END";
```

Defined in: types.ts:831

#### Overrides

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`type`](BaseAGUIEvent.md#type)
