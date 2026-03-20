---
id: UsageInfo
title: UsageInfo
---

# Interface: UsageInfo

Defined in: activities/chat/middleware/types.ts:227

Token usage statistics passed to the onUsage hook.
Extracted from the RUN_FINISHED chunk when usage data is present.

## Properties

### completionTokens

```ts
completionTokens: number;
```

Defined in: activities/chat/middleware/types.ts:229

***

### promptTokens

```ts
promptTokens: number;
```

Defined in: activities/chat/middleware/types.ts:228

***

### totalTokens

```ts
totalTokens: number;
```

Defined in: activities/chat/middleware/types.ts:230
