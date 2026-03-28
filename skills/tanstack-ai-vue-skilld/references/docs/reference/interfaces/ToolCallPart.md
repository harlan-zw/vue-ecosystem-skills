---
id: ToolCallPart
title: ToolCallPart
---

# Interface: ToolCallPart

Defined in: types.ts:284

## Properties

### approval?

```ts
optional approval: object;
```

Defined in: types.ts:291

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

Defined in: types.ts:288

***

### id

```ts
id: string;
```

Defined in: types.ts:286

***

### name

```ts
name: string;
```

Defined in: types.ts:287

***

### output?

```ts
optional output: any;
```

Defined in: types.ts:297

Tool execution output (for client tools or after approval)

***

### state

```ts
state: ToolCallState;
```

Defined in: types.ts:289

***

### type

```ts
type: "tool-call";
```

Defined in: types.ts:285
