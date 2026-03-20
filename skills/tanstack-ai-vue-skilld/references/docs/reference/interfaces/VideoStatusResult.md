---
id: VideoStatusResult
title: VideoStatusResult
---

# Interface: VideoStatusResult

Defined in: types.ts:1102

**`Experimental`**

Status of a video generation job.

 Video generation is an experimental feature and may change.

## Properties

### error?

```ts
optional error: string;
```

Defined in: types.ts:1110

**`Experimental`**

Error message if status is 'failed'

***

### jobId

```ts
jobId: string;
```

Defined in: types.ts:1104

**`Experimental`**

Job identifier

***

### progress?

```ts
optional progress: number;
```

Defined in: types.ts:1108

**`Experimental`**

Progress percentage (0-100), if available

***

### status

```ts
status: "pending" | "processing" | "completed" | "failed";
```

Defined in: types.ts:1106

**`Experimental`**

Current status of the job
