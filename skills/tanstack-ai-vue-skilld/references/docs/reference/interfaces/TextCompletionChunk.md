---
id: TextCompletionChunk
title: TextCompletionChunk
---

# Interface: TextCompletionChunk

Defined in: types.ts:973

## Properties

### content

```ts
content: string;
```

Defined in: types.ts:976

***

### finishReason?

```ts
optional finishReason: "length" | "stop" | "content_filter" | null;
```

Defined in: types.ts:978

***

### id

```ts
id: string;
```

Defined in: types.ts:974

***

### model

```ts
model: string;
```

Defined in: types.ts:975

***

### role?

```ts
optional role: "assistant";
```

Defined in: types.ts:977

***

### usage?

```ts
optional usage: object;
```

Defined in: types.ts:979

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
