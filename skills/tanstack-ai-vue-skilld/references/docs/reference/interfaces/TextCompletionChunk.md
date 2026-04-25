---
id: TextCompletionChunk
title: TextCompletionChunk
---

# Interface: TextCompletionChunk

Defined in: packages/typescript/ai/src/types.ts:1156

## Properties

### content

```ts
content: string;
```

Defined in: packages/typescript/ai/src/types.ts:1159

***

### finishReason?

```ts
optional finishReason: "length" | "stop" | "content_filter" | null;
```

Defined in: packages/typescript/ai/src/types.ts:1161

***

### id

```ts
id: string;
```

Defined in: packages/typescript/ai/src/types.ts:1157

***

### model

```ts
model: string;
```

Defined in: packages/typescript/ai/src/types.ts:1158

***

### role?

```ts
optional role: "assistant";
```

Defined in: packages/typescript/ai/src/types.ts:1160

***

### usage?

```ts
optional usage: object;
```

Defined in: packages/typescript/ai/src/types.ts:1162

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
