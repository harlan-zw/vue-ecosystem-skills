---
category: Watch
alias: ignorableWatch
---

# watchIgnorable

Ignorable watch

## Usage

Extended `watch` that returns extra `ignoreUpdates(updater)` and `ignorePrevAsyncUpdates()` to ignore particular updates to the source.

```ts
import { watchIgnorable } from '@vueuse/core'
import { nextTick, shallowRef } from 'vue'

const source = shallowRef('foo')

const { stop, ignoreUpdates } = watchIgnorable(
  source,
  v => console.log(`Changed to ${v}``

## WatchOptionFlush timing

`watchIgnorable` accepts the same options as `watch` and uses the same defaults.
So, by default the composable works using `flush: 'pre'`.

## `ignorePrevAsyncUpdates`

This feature is only for async flush `'pre'` and `'post'`. If `flush: 'sync'` is used, `ignorePrevAsyncUpdates()` is a no-op as the watch will trigger immediately after each update to the source. It is still provided for sync flush so the code can be more generic.

```ts
import { watchIgnorable } from '@vueuse/core'
import { nextTick, shallowRef } from 'vue'

const source = shallowRef('foo')

const { ignorePrevAsyncUpdates } = watchIgnorable(
  source,
  v => console.log(`Changed to ${v}``

## Recommended Readings

- Ignorable Watch - by @patak-dev
