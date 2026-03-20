---
id: RealtimeEvent
title: RealtimeEvent
---

# Type Alias: RealtimeEvent

```ts
type RealtimeEvent = 
  | "status_change"
  | "mode_change"
  | "transcript"
  | "audio_chunk"
  | "tool_call"
  | "message_complete"
  | "interrupted"
  | "error";
```

Defined in: realtime/types.ts:238

Events emitted by the realtime connection
