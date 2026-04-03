# Icons

Easily add icons to your inputs using the provided FormKit icons or supply your own

FormKit comes with over 130 icons out-of-the-box! With the exception of the brand icons (like YouTube, TikTok, or Visa) all icons are original and MIT-licensed for free use within your project. You can use [our icons](#available-icons), [add your own](#adding-icons-to-the-iconregistry), or easily [connect to a 3rd-party icon set](#using-3rd-party-libraries).

Using icons in your project is as easy as providing your desired icon name to one of an input's icon props.

```
<FormKit prefix-icon="email" />
<FormKit suffix-icon="settings" />
<FormKit type="select" select-icon="caretDown" />

```

It's that easy! 

#### A quick demo of icons in action

### Example: Icons Introduction

#### intro.react.jsx

```jsx
<FormKit
        type="form"
        onSubmit={() => false}
        submitLabel="Let's gooo"
        submitAttrs={{
          suffixIcon: 'submit',
          help: "With 130+ icons built in, it's easy to get started!",
        }}
      >
        <FormKit
          type="email"
          prefixIcon="email"
          label="What is your email address?"
          placeholder="myname@website.com"
          help="Look at my fancy prefix icon!"
        />
        <FormKit
          type="text"
          suffixIcon="search"
          label="What are you looking for?"
          help="I have a suffix icon."
        />
        <FormKit
          type="range"
          prefixIcon="sad"
          suffixIcon="happy"
          label="How do icons make you feel?"
          help="Many input types support icons, like this range input."
        />
        <FormKit
          type="select"
          selectIcon="caretDown"
          label="How likely are you to use icons?"
          help="You can replace default icons such as the select input control."
          options={[
            'Very Likely',
            'Likely',
            'Unsure',
            'Unlikely',
            'Very Unlikely',
          ]}
        />
        <FormKit
          type="color"
          prefixIcon="color"
          label="Choose a color"
          value="#5896D0"
          help="Add icons to color inputs!"
        />
      </FormKit>
```

## Available icons

The `@formkit/icons` package ships with over 130 common icons to make getting started easy! Use the search below to filter the available icons:

## Installation & setup

For most users **no installation is required** to use icons (although we recommend [adding your icons to the iconRegistry](#adding-icons-to-the-iconregistry)
for best performance). Icon support is provided via a 1st-party FormKit plugin called `createThemePlugin()`. This plugin
is enabled by default if you are using FormKit's `defaultConfig()`.

> **Note:** The FormKit `createThemePlugin()` is enabled by default in the FormKit’s `defaultConfig()`. If your
project is using `defaultConfig()` (this is usually the case), then getting started is as simple as using the
`${section}-icon` props available on `FormKit` components — no additional setup required.

When using the framework config that ships with FormKit, you can use several top-level configuration options to
customize your experience. See the `createThemePlugin` docs in the next section for expanded explanations of each.

```
import { defineFormKitConfig } from '@formkit/react'

export default defineFormKitConfig({
  icons: { heart: '<svg...' },
  iconLoaderUrl: (iconName) => `https://...`,
  iconLoader: async (iconName) => undefined,
})

```

### If your project uses a custom config

If your project is **not** using FormKit’s provided `defaultConfig` then you will need to install
the `createThemePlugin()` in your FormKit project's config:

- Import `createThemePlugin()` from the `@formkit/themes` package.
- Add `createThemePlugin()` to your project's plugin array inside of your FormKit config.

```
import { defineFormKitConfig } from '@formkit/react'
import { createThemePlugin } from '@formkit/themes'

export default defineFormKitConfig({
  plugins: [createThemePlugin()],
})

```

The `createThemePlugin` takes 4 optional arguments:

- `theme`: A string representation of a FormKit theme name, eg. `'genesis'`. When provided, if a matching FormKit theme is found, it will be loaded via CDN automatically.
- `icons`: An object of SVG icons to be added to the internal `iconRegistry`. Keys are icon names and values are SVGs, eg `{ heart: '<svg ...' }`
- `iconLoaderUrl`: A function that receives `iconName` and returns a URL where the icons can be loaded not found in the `iconRegistry`. [See example](#using-fontawesome-with-a-custom-iconloaderurl)
- `iconLoader`: A function that receives `iconName` and returns a Promise that resolves to a SVG (as a string) or `undefined`. Use this when you need more control than just overriding the `iconLoaderUrl`. [See example](#an-example-heroicons-iconloader)

Once the theme plugin is installed in your project, your FormKit inputs will have icon props available to use.

## Registering icons

### How are icons loaded?

FormKit goes through 4 steps when attempting to load an icon. They are, in order:

1. **SVG prop value** - If the prop value is an SVG (e.g. `prefix-icon="<svg ..."`), then the provided SVG will be used.
2. **The iconRegistry** - If the prop value is a string that is not an SVG, then FormKit will look for the icon in its internal `iconRegistry` for a matching key.
3. **Your project's CSS variables** - If there is a CSS variable that matches `--fk-icon-${yourIconName}` defined in your CSS, it will be loaded into the `iconRegistry`. The value of the CSS variable should be a base64-encoded SVG — it should not be wrapped in quotes. This is how FormKit ships default icons for inputs in its 1st-party themes.
4. **Via CDN** - If no matching icon can be found in your codebase, then a request will be made to the `@formkit/icons` package via CDN. If a matching icon name is found it will be used. You can [override where remote icons are loaded](#using-fontawesome-with-a-custom-iconloaderurl) if you'd like to use a 3rd-party icon library as a fallback.

Because FormKit falls back to CDN requests for icons, you can easily get started in a new project by providing supported icon names to your input’s icon props
and they will be loaded for you automatically — no additional setup required! 

Remotely loaded SVGs are added to the internal `iconRegistry` the first time an icon is fetched. Additional requests for the same icon will be cached until a user reloads your application.

### Adding icons to the iconRegistry

Magic CDNs are great — but for the best possible performance you should register icons you know you will be using locally in your project.
You can do this by adding icons to your root FormKit config. FormKit's 1st-party icons can be imported from the `@formkit/icons` package.

```
yarn add @formkit/icons

```

```
import { defineFormKitConfig } from '@formkit/react'
import { applicationIcons, ethereum } from '@formkit/icons'
import { thirdPartyIcon } from '@some-other-icon-package'

export default defineFormKitConfig({
  icons: {
    ...applicationIcons,
    ethereum,
    thirdPartyIcon,
    formkit: '<svg ...',
  },
})

```

> **Note:** FormKit automatically loads missing icons from its icon package via CDN. This is great for quickly getting up
and running, but we recommend registering icons you know you will end up using into the `iconRegistry` for best performance.

## Outputting icons

### Adding icons to inputs

Many FormKit inputs support `suffix` and `prefix` icons. You can use the `prefix-icon` and `suffix-icon` props on any
`text`-like input such as `text`, `email`, `search`, `date`, etc. These props are available on the `select`, `color`,
and `range` inputs as well.

The `select` input has a `select-icon` prop that allows you to change the icon used for the select input’s control.

The `file` input has `file-remove-icon` and `file-item-icon` props:

### Example: Icons Introduction

#### usage-basic.react.jsx

```jsx
<FormKit
        prefixIcon="filePdf"
        suffixIcon="search"
        label="Prefix & suffix"
      />
      <FormKit type="select" selectIcon="caretDown" label="Select control" />
      <FormKit
        type="file"
        fileItemIcon="fileAudio"
        fileRemoveIcon="trash"
        label="File icons"
        help="Add a file to see the trash icon."
      />
```

### Using custom SVG icons

Sometimes you need to render a one-off icon in your project. You can directly supply an SVG definition to an icon prop
and the SVG will be rendered for you:

### Example: Icons Introduction

#### inline-svg.react.jsx

```jsx
import { FormKit } from '@formkit/react'

const formkit =
  '<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M4 0.0182495H0V4.01533H4V8.01167L7.9989 8.01167V12.0088H4V16.0058H0V20.0029H4V16.0058H8V12.0088H11.9989V8.01167L8 8.01167V4.01459H4V0.0182495ZM11.9983 20.0029H15.9977H15.9983H19.9972H19.9977H23.9972V24H19.9977H19.9972H15.9983H15.9977H11.9983V20.0029Z" fill="currentColor"/></svg>'

function InlineSvgExample() {
  return (
    <FormKit
      type="text"
      prefixIcon={formkit}
      label="An inline icon"
      help="I use an inline SVG definition"
    />
  )
}
```

### Using the <FormKitIcon /> component

FormKit ships with a component called `<FormKitIcon />` that allows you to output any icon from the `iconRegistry` anywhere
within your project. Import it from <code>@formkit/react</code>. Need an icon you're using in FormKit on some other part of your UI? No problem:

### Example: Icon Component

#### icon-component.react.jsx

```jsx
import { FormKitIcon } from '@formkit/react'

function IconComponentExample() {
  return (
    <>
      <h2>
        Using <code>FormKitIcon</code> you can output any loaded icon anywhere.
      </h2>
      <div className="[&>.formkit-icon]:block [&>.formkit-icon]:max-w-[5em]">
        <FormKitIcon icon="heart" />
      </div>
    </>
  )
}
```

## Icon click handlers

Every icon prop registers a click-handler prop. For example, the `prefix-icon` prop will
have a corresponding <code>onPrefixIconClick</code> prop.

Each click-handler prop receives the input's core `node` and the click `event` as arguments.

### Example: Icons Introduction

#### handle-click.react.jsx

```jsx
<FormKit
        type="password"
        label="A fancy password input"
        value="mySecretPassword!"
        prefixIcon="password"
        suffixIcon="eyeClosed"
        onSuffixIconClick={handleIconClick}
        suffixIconClass="hover:text-blue-500"
      />
```

## Using 3rd-party libraries

If you want to use a 3rd-party icon set in your FormKit project, you can supply a custom `iconLoaderUrl` or complete `iconLoader`
(either globally, at the node config level, or as a component prop) which is responsible for retrieving icons that do not
already exist in the `iconRegistry`.

> **Note:** The `iconLoaderUrl` and `iconLoader` functions are *only meant to handle missing icons*! For the best possible performance
you can (and should) load any SVG icons you know you will be using into the `iconRegistry` by using the `icons` configuration prop in your FormKit config.

Sometimes — in cases such as a form builder or CMS — you don't know in advance which icons you’ll need. That's where remote loading of icons shines.

- The `iconLoaderUrl` and `iconLoader` functions each receive the current `iconName` as an argument
- The return value of `iconLoaderUrl` should be a URL to a remote CDN where the icon SVG can be found. This is the easiest way to change the fallback loading behavior.
- if you need more control use `iconLoader` which allows replacement of all the logic for remote icon fetching. This function should return a `Promise` that resolves to `string` (the SVG) or `undefined`.
- You only need to use `iconLoaderUrl` *or* `iconLoader` — if you supply both then `iconLoader` takes precedence.

### Using FontAwesome with a custom iconLoaderUrl

Below is an implementation of FormKit loading icons from FontAwesome by replacing the `iconLoaderUrl` with a different CDN path.

### Example: FontAwesome Icons

#### font-awesome.react.jsx

```jsx
import { FormKit, FormKitIcon } from '@formkit/react'
export { default as formkitConfig } from './_examples__icons__font-awesome__formkit.config.react.jsx'

function FontAwesomeIconsExample() {
  return (
    <>
      <div style={{ display: 'none' }}>
        <style>
          {
            '.font-awesome-icons .formkit-inner svg, .font-awesome-icons .formkit-icon svg { fill: currentColor; }'
          }
        </style>
      </div>
      <div className="font-awesome-icons">
        <FormKit
          label="I'm using FontAwesome icons"
          prefixIcon="atom"
          suffixIcon="lightbulb"
          innerClass="[&_svg]:fill-current"
        />
        <FormKit
          type="select"
          label="Custom loaders work with all icon props"
          selectIcon="circle-arrow-down"
          options={['One', 'Two', 'Three']}
          help="I'm a select with a custom select icon"
          innerClass="[&_svg]:fill-current"
        />
        <h2 className="text-xl font-bold mb-4">
          Also works with standalone icons
        </h2>
        <div
          className="w-32 text-slate-800 dark:text-slate-300"
          style={{ maxWidth: '8rem' }}
        >
          <FormKitIcon icon="jedi" />
        </div>
      </div>
    </>
  )
}
```

#### formkit.config.react.jsx

```jsx
import { defineFormKitConfig } from '@formkit/react'

export default defineFormKitConfig({
  iconLoaderUrl: (iconName) =>
    `https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free/svgs/solid/${iconName}.svg`,
})
```

### An example Heroicons iconLoader

Below is an implementation of FormKit with a fully custom `iconLoader` that fetches missing icons from Heroicons instead of the FormKit icon set.

### Example: Heroicons Icons

#### heroicons.react.jsx

```jsx
import { FormKit, FormKitIcon } from '@formkit/react'
export { default as formkitConfig } from './_examples__icons__heroicons__formkit.config.react.jsx'

function HeroiconsExample() {
  return (
    <>
      <FormKit
        label="I'm using Heroicons icons"
        prefixIcon="variable"
        suffixIcon="trash"
      />
      <FormKit
        type="select"
        label="Custom loaders work with all icon props"
        selectIcon="selector"
        options={['One', 'Two', 'Three']}
        help="I'm a select with a custom select icon"
      />
      <h2 className="text-xl font-bold mb-4">
        Also works with standalone icons
      </h2>
      <div
        className="w-32 text-slate-800 dark:text-slate-300"
        style={{ maxWidth: '8rem' }}
      >
        <FormKitIcon icon="qrcode" />
      </div>
    </>
  )
}
```

#### formkit.config.react.jsx

```jsx
import { defineFormKitConfig } from '@formkit/react'

export default defineFormKitConfig({
  iconLoader: (iconName) => {
    return fetch(
      `https://cdn.jsdelivr.net/npm/heroicons/outline/${iconName}.svg`
    )
      .then(async (response) => {
        const icon = await response.text()
        if (icon.startsWith('<svg')) {
          return icon
        }
        return undefined
      })
      .catch((error) => {
        console.error(error)
        return undefined
      })
  },
})
```
