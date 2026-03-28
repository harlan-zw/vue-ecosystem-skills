---
id: ModelMessage
title: ModelMessage
---

# Interface: ModelMessage\<TContent\>

Defined in: types.ts:262

## Type Parameters

### TContent

`TContent` *extends* `string` \| `null` \| [`ContentPart`](../type-aliases/ContentPart.md)[] = `string` \| `null` \| [`ContentPart`](../type-aliases/ContentPart.md)[]

## Properties

### content

```ts
content: TContent;
```

Defined in: types.ts:269

***

### name?

```ts
optional name: string;
```

Defined in: types.ts:270

***

### role

```ts
role: "user" | "assistant" | "tool";
```

Defined in: types.ts:268

***

### toolCallId?

```ts
optional toolCallId: string;
```

Defined in: types.ts:272

***

### toolCalls?

```ts
optional toolCalls: ToolCall[];
```

Defined in: types.ts:271
