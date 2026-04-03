# Auto-Height Textarea Plugin

Automatically adjust the height of your textareas based on their content.

Using the `createAutoHeightTextareaPlugin` function from `@formkit/addons` you can use a new prop (`auto-height`) on your Formkit inputs of type `textarea` to have them automatically grow and shrink in size based on their content.

## Installation

To use this plugin with FormKit, install `@formkit/addons`:

```
yarn add @formkit/addons

```

Once you've installed the addons package, you'll need to register the plugin with FormKit:

```
// formkit.config.react.jsx
import { defineFormKitConfig } from '@formkit/react'
import { createAutoHeightTextareaPlugin } from '@formkit/addons'

export default defineFormKitConfig({
  plugins: [createAutoHeightTextareaPlugin()],
})

```

## Usage

To enable auto-height on a text area add the `auto-height` prop to a FormKit input of type `textarea`.

In React JSX these props are written as <code>autoHeight</code> and <code>maxAutoHeight</code>.

Available field props:

- **max-auto-height** *Number* Establishes the upper limit for the expansion of a text area, allowing it to dynamically grow in height while ensuring it does not exceed the specified maximum height.

### Example: Auto-Height Textarea

#### auto-height.react.jsx

```jsx
const value = `Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.`

export default function App() {
  return (
    <>

      <FormKit
        type="textarea"
        autoHeight
        label="I have an auto-height plugin"
        help="This textarea will grow as you type"
        defaultValue={value}
      />
```

#### formkit.config.react.jsx

```jsx
import { defineFormKitConfig } from '@formkit/react'
import { genesisIcons } from '@formkit/icons'
import { createAutoHeightTextareaPlugin } from '@formkit/addons'

export default defineFormKitConfig({
  plugins: [createAutoHeightTextareaPlugin()],
  icons: {
    ...genesisIcons,
  },
})
```
