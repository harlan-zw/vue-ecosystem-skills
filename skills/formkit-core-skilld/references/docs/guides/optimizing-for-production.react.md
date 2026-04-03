# Optimizing for production

Follow this guide to learn how to slim down your FormKit installation for production.

FormKit ships with a lot of functionality out of the box. This is great for getting started, but the `defaultConfig` may include features and inputs you aren’t using. In this guide, we'll learn how to slim down our FormKit installation for production.

## Examining the defaultConfig

Most FormKit users get started by using the provided `defaultConfig` — but what does this actually include?

- Adds the `@formkit/validation` plugin with all rules.
- Adds the `@formkit/i18n` plugin with the `en` locale (plus any additional locales you've added).
- Adds the `@formkit/inputs` plugin with all non-pro inputs.
- Adds the `@formkit/theme` plugin with CDN-loaded icons, or any explicitly loaded icons.
- Adds the `@formkit/vue` bindings to allow FormKit to interface with Vue.
- Registers the `@formkit/dev` error interpreter (gives human-readable error messages in development).

The `defaultConfig` also exposes a convenient object syntax to provide configuration options for all the plugins above. For example, to provide an input to the `@formkit/inputs` plugin instantiation, the default config allows you to pass an `inputs` property:

```
app.use(plugin, defaultConfig({
  inputs: {
    myInput: createInput(/* input options */)
  }
}))

```

For more details, check out the source code of the defaultConfig.

## A custom configuration

When optimizing your FormKit installation for production, you may want to create a custom configuration. This will allow you to only include the features, inputs, rules, and messages you are actually using.

For example, consider a project with a simple form that only uses a text input and the `required` rule. Something like this:

```
async function submit(fields) {
  // ... submit the things
}

export default function Example() {
  return (
    <FormKit type="form" onSubmit={submit}>
      <FormKit
        type="text"
        name="name"
        label="Name"
        help="What do people call you?"
        validation="required"
      />
    </FormKit>
  )
}

```

In this case, we only want to use the singular `required` rule, only the `text` input, and only the `required` message in English and German. We can create this tree-shakable custom configuration by not using the `defaultConfig` and instead performing our own plugin instantiations:

### Using the global plugin

```
// file: main.ts
import { createApp } from 'vue'
import App from './App.vue'
import type { FormKitOptions } from '@formkit/core'
import { plugin, bindings } from '@formkit/vue'
import { createValidationPlugin } from '@formkit/validation'
import { required } from '@formkit/rules'
import { createI18nPlugin, en, de } from '@formkit/i18n'
import { createLibraryPlugin, text, form, submit } from '@formkit/inputs'

const library = createLibraryPlugin({ text, form, submit })
const validation = createValidationPlugin({ required })
const i18n = createI18nPlugin({ en, de })

const app = createApp(App)
app.use(plugin, {
  plugins: [library, validation, i18n, bindings]
})

```

### Using the Nuxt module

If you are using the `@formkit/nuxt` module, you can opt out of the `defaultConfig` by providing the `defaultConfig: false` option to the module:

```
export default defineNuxtConfig({
  modules: ['@formkit/nuxt'],
  formkit: {
    autoImport: true,
    defaultConfig: false
  }
})

```

Then your `formkit.config.ts` is expected to provide a full custom configuration:

```
import type { FormKitOptions } from '@formkit/core'
import { bindings } from '@formkit/vue'
import { createValidationPlugin } from '@formkit/validation'
import { required } from '@formkit/rules'
import { createI18nPlugin, en, de } from '@formkit/i18n'
import { createLibraryPlugin, text, form, submit } from '@formkit/inputs'

const library = createLibraryPlugin({ text, form, submit })
const validation = createValidationPlugin({ required })
const i18n = createI18nPlugin({ en, de })

export default {
  plugins: [library, validation, i18n, bindings]
} satisfies FormKitOptions

```

> **Tip:** In the above examples, we import the `en` and `de` locales. These include messages that are not used in our example. Instead, we could have provided our own custom messages directly:
```
createI18nPlugin({
  en: {
    validation: {
      required: 'This field is required'
    },
    ui: {
      submit: 'Submit'
    }
  },
  de: {
    validation: {
      required: 'Dieses Feld ist erforderlich'
    },
    ui: {
      submit: 'Einreichen'
    }
  }
})

```

## Configuration injection (code splitting)

Vue’s plugin architecture is inherently global. The `plugin` in `@formkit/vue` is no different; however, this convenience comes with a cost — FormKit will be loaded wherever Vue is loaded, even if it is not used on the page.

Fortunately for Nuxt users, the `@formkit/nuxt` module provides a solution to this problem: `autoImport: true`. This option will automatically inject FormKit and its configuration only on pages where it is used.

Vite users can also leverage automatic injection by using unplugin-formkit.

For users of other build tools or for use cases that don’t fit well within the supported features of `unplugin-formkit`, using the `<FormKitProvider>` component allows you to provide global configuration to your FormKit inputs at the point of use. Wrap your components in `<FormKitProvider>` and provide a `config` prop:

```
<script setup>
import { FormKitProvider } from '@formkit/vue'
import type { FormKitOptions } from "@formkit/core"

const formKitConfig: FormKitOptions = {
  // ... your custom config
}
</script>

<template>
  <FormKitProvider :config="formKitConfig">
    <!-- your FormKit components (can be deeply nested) -->
  </FormKitProvider>
</template>

```
