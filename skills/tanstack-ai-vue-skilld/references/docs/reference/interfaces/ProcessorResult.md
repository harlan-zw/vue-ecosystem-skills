---
id: ProcessorResult
title: ProcessorResult
---

# Interface: ProcessorResult

Defined in: activities/chat/stream/types.ts:69

Result from processing a stream

## Properties

### content

```ts
content: string;
```

Defined in: activities/chat/stream/types.ts:70

***

### finishReason?

```ts
optional finishReason: string | null;
```

Defined in: activities/chat/stream/types.ts:73

***

### thinking?

```ts
optional thinking: string;
```

Defined in: activities/chat/stream/types.ts:71

***

### toolCalls?

```ts
optional toolCalls: ToolCall[];
```

Defined in: activities/chat/stream/types.ts:72
