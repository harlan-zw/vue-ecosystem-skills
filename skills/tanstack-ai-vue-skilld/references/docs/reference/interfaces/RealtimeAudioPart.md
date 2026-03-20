---
id: RealtimeAudioPart
title: RealtimeAudioPart
---

# Interface: RealtimeAudioPart

Defined in: realtime/types.ts:102

Audio content part in a realtime message

## Properties

### audioData?

```ts
optional audioData: ArrayBuffer;
```

Defined in: realtime/types.ts:107

Raw audio data (optional, if stored)

***

### durationMs?

```ts
optional durationMs: number;
```

Defined in: realtime/types.ts:109

Duration of the audio in milliseconds

***

### transcript

```ts
transcript: string;
```

Defined in: realtime/types.ts:105

Transcription of the audio

***

### type

```ts
type: "audio";
```

Defined in: realtime/types.ts:103
