---
id: TextCompletionChunk
title: TextCompletionChunk
---

# Interface: TextCompletionChunk

Defined in: types.ts:928

## Properties

### content

```ts
content: string;
```

Defined in: types.ts:931

***

### finishReason?

```ts
optional finishReason: "length" | "stop" | "content_filter" | null;
```

Defined in: types.ts:933

***

### id

```ts
id: string;
```

Defined in: types.ts:929

***

### model

```ts
model: string;
```

Defined in: types.ts:930

***

### role?

```ts
optional role: "assistant";
```

Defined in: types.ts:932

***

### usage?

```ts
optional usage: object;
```

Defined in: types.ts:934

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
