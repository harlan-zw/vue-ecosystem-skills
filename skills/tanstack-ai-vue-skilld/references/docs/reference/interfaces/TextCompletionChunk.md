---
id: TextCompletionChunk
title: TextCompletionChunk
---

# Interface: TextCompletionChunk

Defined in: types.ts:980

## Properties

### content

```ts
content: string;
```

Defined in: types.ts:983

***

### finishReason?

```ts
optional finishReason: "length" | "stop" | "content_filter" | null;
```

Defined in: types.ts:985

***

### id

```ts
id: string;
```

Defined in: types.ts:981

***

### model

```ts
model: string;
```

Defined in: types.ts:982

***

### role?

```ts
optional role: "assistant";
```

Defined in: types.ts:984

***

### usage?

```ts
optional usage: object;
```

Defined in: types.ts:986

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
