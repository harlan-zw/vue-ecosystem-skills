---
id: AGUIEvent
title: AGUIEvent
---

# Type Alias: AGUIEvent

```ts
type AGUIEvent = 
  | RunStartedEvent
  | RunFinishedEvent
  | RunErrorEvent
  | TextMessageStartEvent
  | TextMessageContentEvent
  | TextMessageEndEvent
  | ToolCallStartEvent
  | ToolCallArgsEvent
  | ToolCallEndEvent
  | StepStartedEvent
  | StepFinishedEvent
  | MessagesSnapshotEvent
  | StateSnapshotEvent
  | StateDeltaEvent
  | CustomEvent;
```

Defined in: types.ts:955

Union of all AG-UI events.
