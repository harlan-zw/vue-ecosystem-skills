---
id: VideoGenerationOptions
title: VideoGenerationOptions
---

# Interface: VideoGenerationOptions\<TProviderOptions, TSize\>

Defined in: types.ts:1069

**`Experimental`**

Options for video generation.
These are the common options supported across providers.

 Video generation is an experimental feature and may change.

## Type Parameters

### TProviderOptions

`TProviderOptions` *extends* `object` = `object`

### TSize

`TSize` *extends* `string` = `string`

## Properties

### duration?

```ts
optional duration: number;
```

Defined in: types.ts:1080

**`Experimental`**

Video duration in seconds

***

### model

```ts
model: string;
```

Defined in: types.ts:1074

**`Experimental`**

The model to use for video generation

***

### modelOptions?

```ts
optional modelOptions: TProviderOptions;
```

Defined in: types.ts:1082

**`Experimental`**

Model-specific options for video generation

***

### prompt

```ts
prompt: string;
```

Defined in: types.ts:1076

**`Experimental`**

Text description of the desired video

***

### size?

```ts
optional size: TSize;
```

Defined in: types.ts:1078

**`Experimental`**

Video size — format depends on the provider (e.g., "16:9", "1280x720")
