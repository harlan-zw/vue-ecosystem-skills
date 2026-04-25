---
id: JSONSchema
title: JSONSchema
---

# Interface: JSONSchema

Defined in: packages/typescript/ai/src/types.ts:52

JSON Schema type for defining tool input/output schemas as raw JSON Schema objects.
This allows tools to be defined without schema libraries when you have JSON Schema definitions available.

## Indexable

```ts
[key: string]: any
```

## Properties

### $defs?

```ts
optional $defs: Record<string, JSONSchema>;
```

Defined in: packages/typescript/ai/src/types.ts:62

***

### $ref?

```ts
optional $ref: string;
```

Defined in: packages/typescript/ai/src/types.ts:61

***

### additionalItems?

```ts
optional additionalItems: boolean | JSONSchema;
```

Defined in: packages/typescript/ai/src/types.ts:83

***

### additionalProperties?

```ts
optional additionalProperties: boolean | JSONSchema;
```

Defined in: packages/typescript/ai/src/types.ts:82

***

### allOf?

```ts
optional allOf: JSONSchema[];
```

Defined in: packages/typescript/ai/src/types.ts:64

***

### anyOf?

```ts
optional anyOf: JSONSchema[];
```

Defined in: packages/typescript/ai/src/types.ts:65

***

### const?

```ts
optional const: unknown;
```

Defined in: packages/typescript/ai/src/types.ts:58

***

### default?

```ts
optional default: unknown;
```

Defined in: packages/typescript/ai/src/types.ts:60

***

### definitions?

```ts
optional definitions: Record<string, JSONSchema>;
```

Defined in: packages/typescript/ai/src/types.ts:63

***

### description?

```ts
optional description: string;
```

Defined in: packages/typescript/ai/src/types.ts:59

***

### else?

```ts
optional else: JSONSchema;
```

Defined in: packages/typescript/ai/src/types.ts:70

***

### enum?

```ts
optional enum: unknown[];
```

Defined in: packages/typescript/ai/src/types.ts:57

***

### examples?

```ts
optional examples: unknown[];
```

Defined in: packages/typescript/ai/src/types.ts:89

***

### exclusiveMaximum?

```ts
optional exclusiveMaximum: number;
```

Defined in: packages/typescript/ai/src/types.ts:74

***

### exclusiveMinimum?

```ts
optional exclusiveMinimum: number;
```

Defined in: packages/typescript/ai/src/types.ts:73

***

### format?

```ts
optional format: string;
```

Defined in: packages/typescript/ai/src/types.ts:78

***

### if?

```ts
optional if: JSONSchema;
```

Defined in: packages/typescript/ai/src/types.ts:68

***

### items?

```ts
optional items: JSONSchema | JSONSchema[];
```

Defined in: packages/typescript/ai/src/types.ts:55

***

### maximum?

```ts
optional maximum: number;
```

Defined in: packages/typescript/ai/src/types.ts:72

***

### maxItems?

```ts
optional maxItems: number;
```

Defined in: packages/typescript/ai/src/types.ts:80

***

### maxLength?

```ts
optional maxLength: number;
```

Defined in: packages/typescript/ai/src/types.ts:76

***

### maxProperties?

```ts
optional maxProperties: number;
```

Defined in: packages/typescript/ai/src/types.ts:87

***

### minimum?

```ts
optional minimum: number;
```

Defined in: packages/typescript/ai/src/types.ts:71

***

### minItems?

```ts
optional minItems: number;
```

Defined in: packages/typescript/ai/src/types.ts:79

***

### minLength?

```ts
optional minLength: number;
```

Defined in: packages/typescript/ai/src/types.ts:75

***

### minProperties?

```ts
optional minProperties: number;
```

Defined in: packages/typescript/ai/src/types.ts:86

***

### not?

```ts
optional not: JSONSchema;
```

Defined in: packages/typescript/ai/src/types.ts:67

***

### oneOf?

```ts
optional oneOf: JSONSchema[];
```

Defined in: packages/typescript/ai/src/types.ts:66

***

### pattern?

```ts
optional pattern: string;
```

Defined in: packages/typescript/ai/src/types.ts:77

***

### patternProperties?

```ts
optional patternProperties: Record<string, JSONSchema>;
```

Defined in: packages/typescript/ai/src/types.ts:84

***

### properties?

```ts
optional properties: Record<string, JSONSchema>;
```

Defined in: packages/typescript/ai/src/types.ts:54

***

### propertyNames?

```ts
optional propertyNames: JSONSchema;
```

Defined in: packages/typescript/ai/src/types.ts:85

***

### required?

```ts
optional required: string[];
```

Defined in: packages/typescript/ai/src/types.ts:56

***

### then?

```ts
optional then: JSONSchema;
```

Defined in: packages/typescript/ai/src/types.ts:69

***

### title?

```ts
optional title: string;
```

Defined in: packages/typescript/ai/src/types.ts:88

***

### type?

```ts
optional type: string | string[];
```

Defined in: packages/typescript/ai/src/types.ts:53

***

### uniqueItems?

```ts
optional uniqueItems: boolean;
```

Defined in: packages/typescript/ai/src/types.ts:81
