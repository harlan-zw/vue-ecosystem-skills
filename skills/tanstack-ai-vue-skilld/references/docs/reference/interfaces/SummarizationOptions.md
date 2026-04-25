---
id: SummarizationOptions
title: SummarizationOptions
---

# Interface: SummarizationOptions

Defined in: packages/typescript/ai/src/types.ts:1169

## Properties

### focus?

```ts
optional focus: string[];
```

Defined in: packages/typescript/ai/src/types.ts:1174

***

### logger

```ts
logger: InternalLogger;
```

Defined in: packages/typescript/ai/src/types.ts:1179

Internal logger threaded from the summarize() entry point. Adapters must
call logger.request() before the SDK call and logger.errors() in catch blocks.

***

### maxLength?

```ts
optional maxLength: number;
```

Defined in: packages/typescript/ai/src/types.ts:1172

***

### model

```ts
model: string;
```

Defined in: packages/typescript/ai/src/types.ts:1170

***

### style?

```ts
optional style: "bullet-points" | "paragraph" | "concise";
```

Defined in: packages/typescript/ai/src/types.ts:1173

***

### text

```ts
text: string;
```

Defined in: packages/typescript/ai/src/types.ts:1171
