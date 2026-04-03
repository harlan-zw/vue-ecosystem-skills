# Floating labels

easily add floating labels to your text and textarea inputs.

# Floating Labels Plugin

Using the `createFloatingLabelsPlugin` function from `@formkit/addons` you can easily add a floating label treatment to any `text` family (`text`, `email`, `url`, `date`, etc) or `textarea` FormKit input.

## Installation

To use this plugin with FormKit, install `@formkit/addons`:

```
yarn add @formkit/addons

```

Once you've installed the addons package, you'll need to register the plugin with FormKit. Tailwind and other `rootClasses`-based setups can style the plugin directly, while Genesis or custom CSS setups should include the supporting stylesheet or provide their own styles. The `createFloatingLabelsPlugin` has one option you can configure which controls whether the floating label treatment is the default treatment on applicable inputs:

```
// formkit.config.react.jsx
import { defineFormKitConfig } from '@formkit/react'
import { createFloatingLabelsPlugin } from '@formkit/addons'

export default defineFormKitConfig({
  plugins: [
    createFloatingLabelsPlugin({
      useAsDefault: true,
    }),
  ],
})

```

## Usage

By default the floating label plugin only takes effect on a FormKit input if you set the new `floating-label` prop to `true`.

In React JSX this prop is written as <code>floatingLabel</code>.

### Example: Floating Label Manual

#### off-by-default.react.jsx

```jsx
<FormKit type="text" label="Floating Text Label via prop" floatingLabel />
      <FormKit
        type="textarea"
        label="Floating Textarea Label via prop"
        floatingLabel
      />
      <FormKit type="text" label="I have a standard label" />
```

#### formkit.config.react.jsx

```jsx
import { defineFormKitConfig } from '@formkit/react'
import { genesisIcons } from '@formkit/icons'
import { createFloatingLabelsPlugin } from '@formkit/addons'

export default defineFormKitConfig({
  plugins: [createFloatingLabelsPlugin()],
  icons: {
    ...genesisIcons,
  },
})
```

If you would like to use floating labels by default then pass the `useAsDefault` option to the plugin when you install it.

```
// formkit.config.react.jsx
...
plugins: [
  createFloatingLabelsPlugin({
    useAsDefault: true,
  }),
],
...

```

When floating labels are set as the default you can still disable them on a FormKit input by setting the `floating-label` prop to `false`.

### Example: Floating Label Automatic

#### on-by-default.react.jsx

```jsx
<FormKit type="text" label="Floating Text Label" />
      <FormKit type="textarea" label="Floating Textarea Label" />
      <FormKit
        type="text"
        label="I have a standard label via prop"
        floatingLabel={false}
      />
```

#### formkit.config.react.jsx

```jsx
import { defineFormKitConfig } from '@formkit/react'
import { genesisIcons } from '@formkit/icons'
import { createFloatingLabelsPlugin } from '@formkit/addons'

export default defineFormKitConfig({
  plugins: [
    createFloatingLabelsPlugin({
      useAsDefault: true,
    }),
  ],
  icons: {
    ...genesisIcons,
  },
})
```

That's It! Floating labels on your FormKit inputs in as little as 3 additional lines of code.
