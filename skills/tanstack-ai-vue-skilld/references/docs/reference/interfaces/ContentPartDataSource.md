---
id: ContentPartDataSource
title: ContentPartDataSource
---

# Interface: ContentPartDataSource

Defined in: types.ts:116

Source specification for inline data content (base64).
Requires a mimeType to ensure providers receive proper content type information.

## Properties

### mimeType

```ts
mimeType: string;
```

Defined in: types.ts:129

The MIME type of the content (e.g., 'image/png', 'audio/wav').
Required for data sources to ensure proper handling by providers.

***

### type

```ts
type: "data";
```

Defined in: types.ts:120

Indicates this is inline data content.

***

### value

```ts
value: string;
```

Defined in: types.ts:124

The base64-encoded content value.
