---
category: Watch
alias: pausableWatch
---

# watchPausable

Pausable watch

::: info
This function will be removed in future version.
:::

::: tip

Pausable Watcher has been added to Vue since 3.5, use `const { stop, pause, resume } = watch(watchSource, callback)` instead.

:::

## Usage

Use as normal the `watch`, but return extra `pause()` and `resume()` functions to control.

```ts
import { watchPausable } from '@vueuse/core'
import { nextTick, shallowRef } from 'vue'

const source = shallowRef('foo')

const { stop, pause, resume } = watchPausable(
  source,
  v => console.log(`Changed to ${v}``
