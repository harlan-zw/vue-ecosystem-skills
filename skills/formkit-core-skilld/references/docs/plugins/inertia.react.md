# Inertia Plugin

A plugin for integrating FormKit with Laravel Inertia.

> **Warning:** The current `@formkit/inertia` guide and examples target Vue + Inertia workflows. If you are browsing the React docs, treat this page as package reference material rather than a React integration guide.
:::

```
<FormKit
  type="form"
  @submit="(fields, node) => form.post('/login', {
    preserveScroll: true,
    onSuccess: () => form.node.reset(),
  })(fields, node)"
  :plugins="[form.plugin]"
>
  <!-- The rest of your form -->
</FormKit>

```

To cancel a form submission, use the `cancel()` method.

```
<FormKit
  type="form"
  @submit="(fields, node) => form.post('/login')(fields, node)"
  :plugins="[form.plugin]"
>
  <!-- The rest of your form -->
</FormKit>

<FormKit type="button" @click="form.cancel()" label="Cancel" />

```

The `useForm()` composable also returns reactive states. The Inertia ones are: `processing`, `progress`, `recentlySuccessful` and `wasSuccessful`, the FormKit based ones are `valid`, `errors`, `dirty` and `node`. For example, you could use the `processing` state to disable the form submit button while Inertia is processing the form (assuming that you’re using your own submit button):

```
<template>
  <FormKit type="form" @submit="submit" :plugins="[form.plugin]">
    <FormKit type="text" name="username" label="Username" />
    <FormKit type="password" name="password" label="Password" />

    <template #submit>
      <FormKit type="submit" label="Log in" :disabled="form.processing" />
    </template>
  </FormKit>
</template>

```

## Addons

The main feature for extending functionality is by passing addons to `addon()`, this way you can target multiple events that will be triggered when those are called by Inertia's event callback system, `addon()` accepts a function or an array of functions with `on()`, it accepts any of the events from Inertia’s event callbacks (without the `on` prefix), specifically: `before`, `start`, `progress`, `success`, `error`, `cancel`, `cancelToken` and `finish`. The arguments passed to your callback are the Inertia event’s callback arguments and then FormKit's node:

```
<script setup lang="ts">
  import { useForm } from '@formkit/inertia'

  const form = useForm()
  form.addon((on) => {
    on('before', (visit, node) => {
      return confirm('Are you sure you want to delete this user?')
    })

    on('success', (page, node) => {
      toast('User deleted.')
    })
  })
</script>

```

If you need a single event callback `useForm()` also returns `on()` directly:

```
<script setup lang="ts">
  import { useForm } from '@formkit/inertia'

  const form = useForm()
  form.on('before', (visit, node) => {
    return confirm('Are you sure you want to delete this user?')
  })
</script>

```

:::
