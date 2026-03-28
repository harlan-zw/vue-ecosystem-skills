---
id: UIMessage
title: UIMessage
---

# Interface: UIMessage

Defined in: types.ts:327

UIMessage - Domain-specific message format optimized for building chat UIs
Contains parts that can be text, tool calls, or tool results

## Properties

### createdAt?

```ts
optional createdAt: Date;
```

Defined in: types.ts:331

***

### id

```ts
id: string;
```

Defined in: types.ts:328

***

### parts

```ts
parts: MessagePart[];
```

Defined in: types.ts:330

***

### role

```ts
role: "user" | "assistant" | "system";
```

Defined in: types.ts:329
