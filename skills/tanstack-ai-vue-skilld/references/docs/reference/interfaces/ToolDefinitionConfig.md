---
id: ToolDefinitionConfig
title: ToolDefinitionConfig
---

# Interface: ToolDefinitionConfig\<TInput, TOutput, TName\>

Defined in: activities/chat/tools/tool-definition.ts:88

Tool definition configuration

## Type Parameters

### TInput

`TInput` *extends* [`SchemaInput`](../type-aliases/SchemaInput.md) = [`SchemaInput`](../type-aliases/SchemaInput.md)

### TOutput

`TOutput` *extends* [`SchemaInput`](../type-aliases/SchemaInput.md) = [`SchemaInput`](../type-aliases/SchemaInput.md)

### TName

`TName` *extends* `string` = `string`

## Properties

### description

```ts
description: string;
```

Defined in: activities/chat/tools/tool-definition.ts:94

***

### inputSchema?

```ts
optional inputSchema: TInput;
```

Defined in: activities/chat/tools/tool-definition.ts:95

***

### metadata?

```ts
optional metadata: Record<string, unknown>;
```

Defined in: activities/chat/tools/tool-definition.ts:98

***

### name

```ts
name: TName;
```

Defined in: activities/chat/tools/tool-definition.ts:93

***

### needsApproval?

```ts
optional needsApproval: boolean;
```

Defined in: activities/chat/tools/tool-definition.ts:97

***

### outputSchema?

```ts
optional outputSchema: TOutput;
```

Defined in: activities/chat/tools/tool-definition.ts:96
