---
id: ModelMessage
title: ModelMessage
---

# Interface: ModelMessage\<TContent\>

Defined in: packages/typescript/ai/src/types.ts:289

## Type Parameters

### TContent

`TContent` *extends* `string` \| `null` \| [`ContentPart`](../type-aliases/ContentPart.md)[] = `string` \| `null` \| [`ContentPart`](../type-aliases/ContentPart.md)[]

## Properties

### content

```ts
content: TContent;
```

Defined in: packages/typescript/ai/src/types.ts:296

***

### name?

```ts
optional name: string;
```

Defined in: packages/typescript/ai/src/types.ts:297

***

### role

```ts
role: "user" | "assistant" | "tool";
```

Defined in: packages/typescript/ai/src/types.ts:295

***

### toolCallId?

```ts
optional toolCallId: string;
```

Defined in: packages/typescript/ai/src/types.ts:299

***

### toolCalls?

```ts
optional toolCalls: ToolCall[];
```

Defined in: packages/typescript/ai/src/types.ts:298
