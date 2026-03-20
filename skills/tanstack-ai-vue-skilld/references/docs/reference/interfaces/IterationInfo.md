---
id: IterationInfo
title: IterationInfo
---

# Interface: IterationInfo

Defined in: activities/chat/middleware/types.ts:179

Information passed to onIteration at the start of each agent loop iteration.

## Properties

### iteration

```ts
iteration: number;
```

Defined in: activities/chat/middleware/types.ts:181

0-based iteration index

***

### messageId

```ts
messageId: string;
```

Defined in: activities/chat/middleware/types.ts:183

The assistant message ID created for this iteration
