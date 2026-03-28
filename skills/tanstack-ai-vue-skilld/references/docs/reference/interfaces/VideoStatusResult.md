---
id: VideoStatusResult
title: VideoStatusResult
---

# Interface: VideoStatusResult

Defined in: types.ts:1109

**`Experimental`**

Status of a video generation job.

 Video generation is an experimental feature and may change.

## Properties

### error?

```ts
optional error: string;
```

Defined in: types.ts:1117

**`Experimental`**

Error message if status is 'failed'

***

### jobId

```ts
jobId: string;
```

Defined in: types.ts:1111

**`Experimental`**

Job identifier

***

### progress?

```ts
optional progress: number;
```

Defined in: types.ts:1115

**`Experimental`**

Progress percentage (0-100), if available

***

### status

```ts
status: "pending" | "processing" | "completed" | "failed";
```

Defined in: types.ts:1113

**`Experimental`**

Current status of the job
