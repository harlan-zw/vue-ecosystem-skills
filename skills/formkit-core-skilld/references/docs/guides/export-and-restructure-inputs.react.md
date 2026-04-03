# Export and restructure inputs

Follow this guide to learn how to create, register, and use a custom FormKit input in your project.

FormKit inputs ship with a lot of markup. This is useful for ensuring inputs are written in an accessible manner. However, sometimes it makes sense to modify the existing structure of a FormKit input. Using the FormKit CLI, we can export FormKit's open source inputs and modify their original structure — or even their functionality.

In this guide, we'll export the text input, and restructure it to better support a floating label design.

The exported input definition itself is framework-agnostic. The framework-specific part is how you register that input with your FormKit config.

## Export via CLI

FormKit comes with its own CLI to make exporting inputs a breeze. At the base directory of your project, run:

```
npx formkit@latest export

```

Running this command prompts you to select any of FormKit's open source
inputs to export:

```
? What input do you want to export? ›
❯   button
    submit
    checkbox
    file
    form
    group
    hidden
    list
    radio
  ↓ select

```

We're going to select the text input and allow the CLI to create a new `/inputs`
directory within `/src`:

```
✔ What input do you want to export? › text
✔ What language should be used? › JavaScript
? Where should the input be exported to (relative to the current directory)? ›
./src/inputs

```

Taking a look at our exported input, `text.js`, we can see the underlying sections that make up the FormKit input. These sections are provided as small composable functions. Each section represents a single `FormKitSchemaNode` and the arguments passed to that section are its children:

```
// text.js
import {
  outer,
  inner,
  wrapper,
  label,
  help,
  messages,
  message,
  icon,
  prefix,
  suffix,
  textInput,
} from '@formkit/inputs'
/**
 * Input definition for a text.
 * @public
 */
export const text = {
  /**
   * The actual schema of the input, or a function that returns the schema.
   */
  schema: outer(
    wrapper(
      label('$label'),
      inner(
        icon('prefix', 'label'),
        prefix(),
        textInput(),
        suffix(),
        icon('suffix')
      )
    ),
    help('$help'),
    messages(message('$message.value'))
  ),
  /**
   * The type of node, can be a list, group, or input.
   */
  type: 'input',
  /**
   * An array of extra props to accept for this input.
   */
  props: [],
  /**
   * Additional features that should be added to your input
   */
  features: [],
}

```

In this example, we are not going to overwrite the default FormKit text input,
but instead, create a custom text input that is going to use floating labels.
Let's go ahead and rename the text file we just exported to
`floatingLabelTextInput.js`:

```
src/
  |inputs/
  |   |- t̶e̶x̶t̶ floatingLabelTextInput.js

```

In `floatingLabelTextInput.js`, let's change the name of the
exported variable to `floatingLabelTextInput` from `text`.

```
...
export const t̶e̶x̶t̶ floatingLabelTextInput = {
  ...
}

```

## Register input

To globally register our "new" input, we need add our `floatingLabelTextInput` to the global config. We can do this wherever we are registering the FormKit plugin:

```
// formkit.config.react.jsx
import { defineFormKitConfig } from '@formkit/react'
import { genesisIcons } from '@formkit/icons'
import { floatingLabelTextInput } from '../src/inputs/floatingLabelTextInput'

export default defineFormKitConfig({
  inputs: {
    floatingLabelTextInput,
  },
  icons: {
    ...genesisIcons,
  },
})

```

## Modifying schema

Now we're going to modify the schema of `floatingLabelTextInput` to better support floating labels, which are usually implemented using the CSS sibling selector: `~`. In order to use a CSS selector like `:focus ~ label`, our `<label>` tag needs to be placed after our `<input>` tag. With our schema already exported, this change is easy to make:

```
export const floatingLabelTextInput = {
  schema: outer(
    wrapper(
      /*
      * Removing label
      */
      l̶a̶b̶e̶l̶(̶'̶$̶l̶a̶b̶e̶l̶'̶)̶, // ❌ removed from here
      inner(
        icon('prefix', 'label'),
        prefix(),
        textInput(),
        label('$label'), // 👈 and now placed here
        suffix(),
        icon('suffix')
      )
    ),
    help('$help'),
    messages(message('$message.value'))
  ),
  ...
}

```

## Using helpers

The `@formkit/inputs` package exports a number of helper functions that can be easily applied to the composable schema functions. Available helpers are:

```
import { $attrs, $if, $for, $extend, $root } from '@formkit/inputs'

```

Importing the `$attrs` function from FormKit's input package allows us to extend the schema of any section with additional attributes. In this example, we are using it to modify the label section and change its class from `formkit-label` to `formkit-label-floating`. Additionally, we’ll add a `data-has-value` attribute:

```
import {
  outer,
  inner,
  wrapper,
  label,
  help,
  messages,
  message,
  icon,
  prefix,
  suffix,
  textInput,
  /*
   * Importing $attrs
   */
  $attrs,
} from '@formkit/inputs'

export const floatingLabelTextInput = {
  schema: outer(
    wrapper(
      inner(
        icon('prefix', 'label'),
        prefix(),
        textInput(),
        /*
        * Using $attrs function to pass attrs object to label section with new
          class definition.
        */
        $attrs(
          {
            class: '$classes.labelFloating',
            'data-has-value': '$_value !== "" && $_value !== undefined',
            for: '$id',
          },
          label('$label')
        ),
        suffix(),
        icon('suffix')
      )
    ),
    help('$help'),
    messages(message('$message.value'))
  ),

  type: 'input',

  props: [],

  features: [],
}

```

After adding appropriate styling, we can see that our new custom input has its `<label>` moved within the HTML structure and uses floating labels:

#### example.react.jsx

```jsx
import { FormKit } from '@formkit/react'

function ExportInputsFinalResultExample() {
  return (
    <>
      <FormKit type="text" label="FormKit's Built-in Text Input" />
      <FormKit
        type="floatingLabelTextInput"
        label="Our new Floating Label Text Input"
        help="Check out the HTML tab to compare the 2 inputs."
      />

      <style>{`
        .formkit-inner {
          position: relative;
        }

        .formkit-label-floating {
          position: absolute;
          left: 0.5em;
          color: grey;
          transition: all 0.25s;
          bottom: calc(100% - 0.5em);
          transform: translateY(100%);
          padding: 0.25em;
          box-sizing: border-box;
        }

        input:focus ~ .formkit-label-floating,
        textarea:focus ~ .formkit-label-floating,
        .formkit-label-floating[data-has-value='true'] {
          font-size: 0.7em;
          transform: translateY(50%);
          background-color: white;
          bottom: 100%;
        }
      `}</style>
    </>
  )
}
```

#### floating-label-text-input.js

```js
import {
  outer,
  inner,
  wrapper,
  label,
  help,
  messages,
  message,
  icon,
  prefix,
  suffix,
  textInput,
  $attrs,
} from '@formkit/inputs'
/**
 * Input definition for a text.
 * @public
 */
export const floatingLabelTextInput = {
  schema: outer(
    wrapper(
      /*
       * Here we are commenting out the label input and moving it below the
       * text input.
       * label('$label'),
       */
      inner(
        icon('prefix', 'label'),
        prefix(),
        textInput(),
        /*
         * New label placement
         */
        $attrs(
          {
            'data-floating-label': true,
            'data-has-value': '$_value !== "" && $_value !== undefined',
            for: '$id',
          },
          label('$label')
        ),
        suffix(),
        icon('suffix')
      )
    ),
    help('$help'),
    messages(message('$message.value'))
  ),
  /**
   * The type of node, can be a list, group, or input.
   */
  type: 'input',
  /**
   * The family the input belongs to. Will inherit class lists
   */
  family: 'text',
  /**
   * An array of extra props to accept for this input.
   */
  props: [],
  /**
   * Additional features that should be added to your input
   */
  features: [],
}
```

#### formkit.config.react.jsx

```jsx
import { defineFormKitConfig } from '@formkit/react'
import { genesisIcons } from '@formkit/icons'
import { floatingLabelTextInput } from './_examples__guides__export-inputs__final-result__floating-label-text-input.js'

export default defineFormKitConfig({
  inputs: {
    floatingLabelTextInput,
  },
  icons: {
    ...genesisIcons,
  },
})
```

## Next steps

In this guide we exported the built-in `text` input using FormKit's [CLI tool](#export-via-cli) and used the exported file as a starting point for a new floating label variation. However, the export feature enables developers to do much more than that! Whether replacing FormKit's existing inputs, or adding new custom inputs with modified, added, removed, or moved sections — we look forward to seeing all the ways you use this feature!
