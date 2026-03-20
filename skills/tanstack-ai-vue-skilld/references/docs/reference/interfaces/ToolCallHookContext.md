---
id: ToolCallHookContext
title: ToolCallHookContext
---

# Interface: ToolCallHookContext

Defined in: activities/chat/middleware/types.ts:123

Context provided to tool call hooks (onBeforeToolCall / onAfterToolCall).

## Properties

### args

```ts
args: unknown;
```

Defined in: activities/chat/middleware/types.ts:129

Parsed arguments for the tool call

***

### tool

```ts
tool: 
  | Tool<SchemaInput, SchemaInput, string>
  | undefined;
```

Defined in: activities/chat/middleware/types.ts:127

The resolved tool definition, if found

***

### toolCall

```ts
toolCall: ToolCall;
```

Defined in: activities/chat/middleware/types.ts:125

The tool call being executed

***

### toolCallId

```ts
toolCallId: string;
```

Defined in: activities/chat/middleware/types.ts:133

ID of the tool call

***

### toolName

```ts
toolName: string;
```

Defined in: activities/chat/middleware/types.ts:131

Name of the tool
