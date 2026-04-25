---
id: ImageGenerationResult
title: ImageGenerationResult
---

# Interface: ImageGenerationResult

Defined in: packages/typescript/ai/src/types.ts:1251

Result of image generation

## Properties

### id

```ts
id: string;
```

Defined in: packages/typescript/ai/src/types.ts:1253

Unique identifier for the generation

***

### images

```ts
images: GeneratedImage[];
```

Defined in: packages/typescript/ai/src/types.ts:1257

Array of generated images

***

### model

```ts
model: string;
```

Defined in: packages/typescript/ai/src/types.ts:1255

Model used for generation

***

### usage?

```ts
optional usage: object;
```

Defined in: packages/typescript/ai/src/types.ts:1259

Token usage information (if available)

#### inputTokens?

```ts
optional inputTokens: number;
```

#### outputTokens?

```ts
optional outputTokens: number;
```

#### totalTokens?

```ts
optional totalTokens: number;
```
