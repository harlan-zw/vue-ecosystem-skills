---
id: TranscriptionSegment
title: TranscriptionSegment
---

# Interface: TranscriptionSegment

Defined in: types.ts:1203

A single segment of transcribed audio with timing information.

## Properties

### confidence?

```ts
optional confidence: number;
```

Defined in: types.ts:1213

Confidence score (0-1), if available

***

### end

```ts
end: number;
```

Defined in: types.ts:1209

End time of the segment in seconds

***

### id

```ts
id: number;
```

Defined in: types.ts:1205

Unique identifier for the segment

***

### speaker?

```ts
optional speaker: string;
```

Defined in: types.ts:1215

Speaker identifier, if diarization is enabled

***

### start

```ts
start: number;
```

Defined in: types.ts:1207

Start time of the segment in seconds

***

### text

```ts
text: string;
```

Defined in: types.ts:1211

Transcribed text for this segment
