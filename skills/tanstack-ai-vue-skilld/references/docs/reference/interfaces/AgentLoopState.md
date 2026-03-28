---
id: AgentLoopState
title: AgentLoopState
---

# Interface: AgentLoopState

Defined in: types.ts:604

State passed to agent loop strategy for determining whether to continue

## Properties

### finishReason

```ts
finishReason: string | null;
```

Defined in: types.ts:610

Finish reason from the last response

***

### iterationCount

```ts
iterationCount: number;
```

Defined in: types.ts:606

Current iteration count (0-indexed)

***

### messages

```ts
messages: ModelMessage<
  | string
  | ContentPart<unknown, unknown, unknown, unknown, unknown>[]
  | null>[];
```

Defined in: types.ts:608

Current messages array
