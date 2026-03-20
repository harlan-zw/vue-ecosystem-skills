---
id: ProcessorState
title: ProcessorState
---

# Interface: ProcessorState

Defined in: activities/chat/stream/types.ts:79

Current state of the processor

## Properties

### content

```ts
content: string;
```

Defined in: activities/chat/stream/types.ts:80

***

### done

```ts
done: boolean;
```

Defined in: activities/chat/stream/types.ts:85

***

### finishReason

```ts
finishReason: string | null;
```

Defined in: activities/chat/stream/types.ts:84

***

### thinking

```ts
thinking: string;
```

Defined in: activities/chat/stream/types.ts:81

***

### toolCallOrder

```ts
toolCallOrder: string[];
```

Defined in: activities/chat/stream/types.ts:83

***

### toolCalls

```ts
toolCalls: Map<string, InternalToolCallState>;
```

Defined in: activities/chat/stream/types.ts:82
