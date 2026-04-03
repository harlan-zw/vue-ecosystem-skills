# AutoAnimate

Add smoothing transitions to your FormKit inputs using AutoAnimate.

# AutoAnimate Plugin

AutoAnimate is a zero-config, drop-in animation utility that adds smooth transitions to any web app. It also works great with FormKit.

FormKit doesn't need much animation, but a small tasteful amount can make it clear when elements pop on and off a page, or move around — such as validation messages.

## Installation

To use AutoAnimate with FormKit, install `@formkit/addons`:

```
yarn add @formkit/addons

```

Once you've installed the addons package, you'll need to register the AutoAnimate plugin with FormKit:

In React this usually means exporting a config from <code>defineFormKitConfig()</code>.

```
import { defineFormKitConfig } from '@formkit/react'
import { createAutoAnimatePlugin } from '@formkit/addons'

export default defineFormKitConfig({
  plugins: [
    createAutoAnimatePlugin(
      {
        duration: 250,
        easing: 'ease-in-out',
        delay: 0,
      },
      {
        global: ['outer', 'inner'],
        form: ['form'],
        repeater: ['items'],
      }
    ),
  ],
})

```

If you've installed it correctly, you should have smooth transitions when showing and hiding validation messages:

## Example

### Example: AutoAnimate example

#### auto-animate.react.jsx

```jsx
const [fruit, setFruit] = useState(null)

  const submitApp = async (_formData, node) => {
    await new Promise((resolve) => setTimeout(resolve, 2000))
    node.setErrors(['This is an example form-level error.'])
  }

  return (
    <>

      <FormKit type="form" onSubmit={submitApp}>
        <FormKit type="repeater">
          <FormKit
            label="username"
            type="text"
            defaultValue="hello"
            validation="required|length:6"
            validationVisibility="live"
          />
          <FormKit
            label="Email"
            type="email"
            defaultValue="invalid@foo."
            validation="required|email"
            validationVisibility="live"
            help="Change me to see animations"
          />
        </FormKit>

        <FormKit
          modelValue={fruit}
          onUpdateModelValue={(value) =>
            setFruit(typeof value === 'string' ? value : null)
          }
          label="Select a fruit"
          help="Conditional fields at the root form level will also be animated"
          type="radio"
          name="fruit"
          placeholder="Select the best country"
          options={['None', 'Apple', 'Strawberry', 'Banana']}
        />
        {fruit && fruit !== 'None' ? (
          <FormKit
            type="checkbox"
            validation="required|accepted"
            validationLabel="Confirmation"
            label={`Please confirm that you meant to select ${fruit}.`}
          />
        ) : null}
      </FormKit>
```

#### formkit.config.react.jsx

```jsx
import { defineFormKitConfig } from '@formkit/react'
import { createProPlugin, inputs as proInputs } from '@formkit/pro'
import { genesisIcons } from '@formkit/icons'
import { createAutoAnimatePlugin } from '@formkit/addons'

const pro = createProPlugin('fk-52971f34220', proInputs)

export default defineFormKitConfig({
  plugins: [pro, createAutoAnimatePlugin()],
  icons: {
    ...genesisIcons,
  },
})
```

That's pretty much all you need to do! AutoAnimate is intended to be a zero-config drop in utility. However, if you really want to fine tune the plugin a little more, you can provide your own AutoAnimate options or plugins. Read more about this on the AutoAnimate documentation site.
