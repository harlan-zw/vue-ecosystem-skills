---
id: ToolCallPart
title: ToolCallPart
---

# Interface: ToolCallPart

Defined in: packages/typescript/ai/src/types.ts:311

## Properties

### approval?

```ts
optional approval: object;
```

Defined in: packages/typescript/ai/src/types.ts:318

Approval metadata if tool requires user approval

#### approved?

```ts
optional approved: boolean;
```

#### id

```ts
id: string;
```

#### needsApproval

```ts
needsApproval: boolean;
```

***

### arguments

```ts
arguments: string;
```

Defined in: packages/typescript/ai/src/types.ts:315

***

### id

```ts
id: string;
```

Defined in: packages/typescript/ai/src/types.ts:313

***

### name

```ts
name: string;
```

Defined in: packages/typescript/ai/src/types.ts:314

***

### output?

```ts
optional output: any;
```

Defined in: packages/typescript/ai/src/types.ts:324

Tool execution output (for client tools or after approval)

***

### state

```ts
state: ToolCallState;
```

Defined in: packages/typescript/ai/src/types.ts:316

***

### type

```ts
type: "tool-call";
```

Defined in: packages/typescript/ai/src/types.ts:312
