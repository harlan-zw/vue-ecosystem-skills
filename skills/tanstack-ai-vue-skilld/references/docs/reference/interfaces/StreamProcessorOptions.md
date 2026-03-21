---
id: StreamProcessorOptions
title: StreamProcessorOptions
---

# Interface: StreamProcessorOptions

Defined in: activities/chat/stream/processor.ts:90

Options for StreamProcessor

## Properties

### chunkStrategy?

```ts
optional chunkStrategy: ChunkStrategy;
```

Defined in: activities/chat/stream/processor.ts:91

***

### events?

```ts
optional events: StreamProcessorEvents;
```

Defined in: activities/chat/stream/processor.ts:93

Event-driven handlers

***

### initialMessages?

```ts
optional initialMessages: UIMessage[];
```

Defined in: activities/chat/stream/processor.ts:100

Initial messages to populate the processor

***

### jsonParser?

```ts
optional jsonParser: object;
```

Defined in: activities/chat/stream/processor.ts:94

#### parse()

```ts
parse: (jsonString) => any;
```

##### Parameters

###### jsonString

`string`

##### Returns

`any`

***

### recording?

```ts
optional recording: boolean;
```

Defined in: activities/chat/stream/processor.ts:98

Enable recording for replay testing
