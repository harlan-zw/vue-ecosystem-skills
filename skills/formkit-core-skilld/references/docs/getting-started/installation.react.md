# Installation

Get up and running with FormKit in your project.

## Prerequisites

- React 18+ or Astro with React integration.
- Vite (strongly recommended for automatic optimizations)
- Node.js: `14.18.0`, `16.12.0`, or higher.
- Terminal: To run `npm`/`yarn`/`pnpm` commands.

If you'd rather install FormKit by hand, use the wizard below.

## Installation instruction wizard

## Quick Reference

| Scenario | Package | Config File |
|----------|---------|-------------|
| **New React app** | `npm install @formkit/react @formkit/core @formkit/inputs` | `formkit.config.ts` |
| **Existing React + TS** | `npm install @formkit/react @formkit/core @formkit/inputs` | `formkit.config.ts` |
| **Existing React + JS** | `npm install @formkit/react @formkit/core @formkit/inputs` | `formkit.config.js` |
| **Astro + React** | `npm install @formkit/react @formkit/core @formkit/inputs` | React wrapper component |

### Styling Options

| Style System | Package | Notes |
|--------------|---------|-------|
| **Tailwind CSS** | `@formkit/themes` + `@formkit/icons` | Generate `formkit.theme.ts` and use `rootClasses` |
| **Legacy CSS** | `@formkit/themes` + `@formkit/icons` | Import `@formkit/themes/genesis` |

### FormKit Pro (Optional)

| Framework | Package | Notes |
|-----------|---------|-------|
| **React** | `@formkit/pro` | Add to the `plugins` array in `defineFormKitConfig()` |
| **Astro + React** | `@formkit/pro` | Add to the same React config used by your wrapper component |

---

## Detailed Instructions

### React

Start by creating a React app with your preferred tooling. A Vite starter is a good default:

```sh
# TypeScript
npm create vite@latest my-app -- --template react-ts

# JavaScript
npm create vite@latest my-app -- --template react

cd my-app
npm install
```

Then install FormKit:

```sh
npm install @formkit/react @formkit/core @formkit/inputs
```

Once those packages are installed, wire FormKit into your app with a `FormKitProvider`:

```tsx
import { FormKit, FormKitProvider, defaultConfig } from '@formkit/react'

export default function App() {
  return (
    <FormKitProvider config={defaultConfig()}>
      <FormKit type="text" name="email" label="Email" />
    </FormKitProvider>
  )
}
```

### React

If you're adding FormKit to an existing React application, install the React package and its core input packages:

```sh
npm install @formkit/react @formkit/core @formkit/inputs
```

If your project does not already include React itself, install `react` and `react-dom` as well.

FormKit for React is provided through a `FormKitProvider` and the `<FormKit />` component:

```tsx
import { FormKit, FormKitProvider, defaultConfig } from '@formkit/react'

export default function App() {
  return (
    <FormKitProvider config={defaultConfig()}>
      <FormKit type="text" name="email" label="Email" />
    </FormKitProvider>
  )
}
```

That's it. Once the provider is mounted, you can start using `<FormKit />` anywhere inside your React tree.

### Astro

First, install Astro's React integration. You can refer to Astro's React integration docs for more detail.

Inside your Astro config file (`astro.config.*`), enable the React integration:

```js
// astro.config.mjs
import { defineConfig } from 'astro/config'
import react from '@astrojs/react'

export default defineConfig({
  integrations: [react()],
})
```

Next, install the packages FormKit needs in a React Astro project:

```sh
npm install @formkit/react @formkit/core @formkit/inputs
```

Now create a React wrapper component for your form:

```jsx
// src/components/Form.jsx
import { FormKit, FormKitProvider, defaultConfig } from '@formkit/react'

export default function Form() {
  async function submitHandler(fields) {
    await new Promise((resolve) => setTimeout(resolve, 1000))
    console.log(fields)
  }

  return (
    <FormKitProvider config={defaultConfig()}>
      <FormKit type="form" onSubmit={submitHandler}>
        <FormKit type="text" label="Name" name="name" />
        <FormKit type="email" label="Email" name="email" />
      </FormKit>
    </FormKitProvider>
  )
}
```

After that, import and use it inside your Astro files:

```astro
---
import Form from '../components/Form.jsx'
---

<Form client:visible />
```

## Configuration

To configure FormKit in React, create a `formkit.config.ts` file in your project root and export it with `defineFormKitConfig()`:

### formkit.config.ts
```ts
import { fr } from '@formkit/i18n'
import { defineFormKitConfig } from '@formkit/react'

export default defineFormKitConfig({
  locales: { fr },
  locale: 'fr',
})
```

### App.tsx (or equivalent)
```tsx
import { FormKit, FormKitProvider, defaultConfig } from '@formkit/react'
import formkitConfig from './formkit.config'

export default function App() {
  return (
    <FormKitProvider config={defaultConfig(formkitConfig())}>
      <FormKit type="text" name="email" label="Email" />
    </FormKitProvider>
  )
}
```

## Configuration

To configure FormKit in React, create a `formkit.config.js` file in your project root and export it with `defineFormKitConfig()`:

### formkit.config.js
```js
import { fr } from '@formkit/i18n'
import { defineFormKitConfig } from '@formkit/react'

export default defineFormKitConfig({
  locales: { fr },
  locale: 'fr',
})
```

### App.jsx (or equivalent)
```jsx
import { FormKit, FormKitProvider, defaultConfig } from '@formkit/react'
import formkitConfig from './formkit.config'

export default function App() {
  return (
    <FormKitProvider config={defaultConfig(formkitConfig())}>
      <FormKit type="text" name="email" label="Email" />
    </FormKitProvider>
  )
}
```

## Theming

For a Tailwind-powered setup, install the FormKit theme and icon packages:

```sh
npm install @formkit/themes @formkit/icons
```

Then generate a starter FormKit theme file:

```sh
npx formkit@latest theme
```

This creates `formkit.theme.ts`. Use the exported `rootClasses` in your React FormKit config:

```ts
import { defineFormKitConfig } from '@formkit/react'
import { genesisIcons } from '@formkit/icons'
import { rootClasses } from './formkit.theme'

export default defineFormKitConfig({
  icons: {
    ...genesisIcons,
  },
  config: {
    rootClasses,
  },
})
```

Finally, make sure Tailwind scans both your FormKit theme file and config file:

```css
@import "tailwindcss";
@source "./formkit.theme.ts";
@source "./formkit.config.ts";
```

If you're using Tailwind CSS 3, add those files to the `content` array in `tailwind.config.js` instead.

## Theming

If you prefer the legacy Genesis CSS theme, install the theme and icon packages:

```sh
npm install @formkit/themes @formkit/icons
```

Then import Genesis and register the default icons in your FormKit config:

```ts
import '@formkit/themes/genesis'
import { genesisIcons } from '@formkit/icons'
import { defineFormKitConfig } from '@formkit/react'

export default defineFormKitConfig({
  icons: {
    ...genesisIcons,
  },
})
```

Genesis is unopinionated enough to use as-is, or as a starting point for your own CSS.

## Adding Pro Inputs

Installing FormKit Pro in React follows the same plugin model as the rest of the React package.

#### 1. Get a Project Key

Login to your FormKit Pro account at pro.formkit.com and create a project. A `Project Key` will be provided to you.

#### 2. Install the package

```bash
npm install @formkit/pro
```

#### 3. Add the Pro plugin to your config

```ts
import { defineFormKitConfig } from '@formkit/react'
import { createProPlugin, rating, toggle } from '@formkit/pro'

const proPlugin = createProPlugin('fk-00000000000', {
  rating,
  toggle,
})

export default defineFormKitConfig({
  plugins: [proPlugin],
})
```

### Adding the Pro Genesis Theme

You will also need to install the accompanying Pro CSS:

```js
// main.js or formkit.config.ts
// Genesis for Pro is dependent on Genesis
import '@formkit/themes/genesis'
import '@formkit/pro/genesis'
```
