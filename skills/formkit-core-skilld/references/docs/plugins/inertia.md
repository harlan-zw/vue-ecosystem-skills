# Inertia Plugin

A plugin for integrating FormKit with Laravel Inertia.

The `@formkit/inertia` plugin aims to seamlessly integrate Inertia.js with FormKit forms, leveraging a robust event system that harnesses Inertia.js event callbacks and FormKit plugins for a smooth and powerful web development experience.

## Installation

To use the Inertia plugin we need to have a Laravel project already with Inertia Vue.JS installed and running you can check how by looking into the first sections of the guide [Using FormKit with Laravel Inertia](/guides/using-formkit-with-laravel-inertia).

Now you can install using your preferred package manager by following this bash command:

```
npm install @formkit/inertia

```

## Usage

To use the Inertia plugin we need to import the `useForm` function from `@formkit/inertia`, call the `useForm` function to receive the `form`, it comes with Inertia's method calls, reactive states, the addons for extensions, and the FormKit plugin.

The `useForm` function takes one optional argument for the initial fields that will be passed to your form via plugin, it will also return methods like `submit`, `get`, `post`, `put`, `patch` and `delete`. All of these methods will return a suitable function for use as FormKit’s `@submit` handler.

The easiest way to use it is by creating a new `const` with the resulting method of your choice, and adding the `form.plugin` to the FormKit form `:plugins`:

```
<script setup lang="ts">
  import { useForm } from '@formkit/inertia'

  const form = useForm()
  const submitHandler = form.post('/login')
</script>

<template>
  <FormKit type="form" @submit="submitHandler" :plugins="[form.plugin]">
    <FormKit type="text" name="username" label="Username" />
    <FormKit type="password" name="password" label="Password" />
  </FormKit>
</template>

```

You could also also define the handler directly in your template:

```
<FormKit
  type="form"
  @submit="(fields, node) => form.post('/login')(fields, node)"
  :plugins="[form.plugin]"
>
  <!-- The rest of your form -->
</FormKit>

```

The functions support all visit options from Inertia, such as `preserveState`, `preserveScroll`, and event callbacks.

> **Info:** The options event callbacks will overwrite any default events to that specific event, meaning that if you for example add onStart you will lose the events from start that are for example loading, disabling and processing.

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
