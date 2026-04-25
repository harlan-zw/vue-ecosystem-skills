---
id: UIMessage
title: UIMessage
---

# Interface: UIMessage

Defined in: packages/typescript/ai/src/types.ts:354

UIMessage - Domain-specific message format optimized for building chat UIs
Contains parts that can be text, tool calls, or tool results

## Properties

### createdAt?

```ts
optional createdAt: Date;
```

Defined in: packages/typescript/ai/src/types.ts:358

***

### id

```ts
id: string;
```

Defined in: packages/typescript/ai/src/types.ts:355

***

### parts

```ts
parts: MessagePart[];
```

Defined in: packages/typescript/ai/src/types.ts:357

***

### role

```ts
role: "user" | "assistant" | "system";
```

Defined in: packages/typescript/ai/src/types.ts:356
