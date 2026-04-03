# Internationalization (i18n)

Translate FormKit UI and validation messages into supported languages — or provide your own.

FormKit ships with internationalization support for all of its interfaces and validation messages.

## Available languages

Currently, FormKit supports the following languages (in the `@formkit/i18n` package):

- 🇱🇾 Arabic (ar) — @Ahmedelforjani
- 🇦🇿 Azerbaijani (az) — @EmrullahKutlar
- 🇧🇩 Bengali (bn)
- 🇧🇦 Bosnian (bs) — @TarikTz
- 🇧🇬 Bulgarian (bg) — @ivanov1234159
- Catalan (ca) — @petergithubmgw
- 🇨🇳 Chinese (zh) — @myleslee
- 🇨🇳 Chinese Traditional (zh-TW) — @actocoa
- 🇭🇷 Croatian (hr) — @antemarkic
- 🇨🇿 Czech (cs) — @dfridrich
- 🇩🇰 Danish (da) — @bjerggaard
- 🇳🇱 Dutch (nl) — @arjendejong12
- 🇺🇸 English (en)
- 🇫🇮 Finish (fi) — @mihqusta
- 🇫🇷 French (fr) — @HoreKk, @pop123123123
- Frisian (fy) — @arjendejong12
- 🇩🇪 German (de) — @digitalkaoz, @tosling
- 🇬🇷 Greek (el) — @mendrinos
- 🇮🇱 Hebrew (he) — @Hepi420
- 🇭🇺 Hungarian (hu) — @KristofKekesi
- 🇮🇸 Icelandic (is) — @Gunsobal
- 🇮🇩 Indonesian (id) — @rama-adi
- 🇮🇹 Italian (it) — @punga78, @Archetipo95
- 🇯🇵 Japanese (ja) — @wonyx
- 🇰🇿 Kazakh (kk) — @ilya-raevskiy
- 🇰🇷 Korean (ko) — @bwp618, @titusdecali
- 🇱🇻 Latvian (lv) — @Bamslation
- 🇱🇹 Lithuanian (lt) — @balu-lt
- 🇲🇳 Mongolian (mn) — @zemunkh
- 🇳🇴 Norwegian Bokmål (nb) — @hognevevle
- 🇮🇷 Persian (fa) — @shahabbasian
- 🇵🇱 Polish (pl) — @xxSkyy
- 🇧🇷 Portuguese (pt) @r-martins, @dbomfim
- 🇷🇴 Romanian (ro) — @danve
- 🇷🇺 Russian (ru) — @andreimakushkin
- 🇸🇰 Slovak (sk) — @neridev
- 🇸🇮 Slovenian (sl) — @krisflajs
- 🇷🇸 Serbian (sr) — @milos5593
- 🇦🇷 Spanish (es) — @inibg
- 🇸🇪 Swedish (sv) — @purung
- 🇹🇯 Tajik (tg) — @devixrootix
- 🇹🇱 Tetum (tet) — @joshbrooks
- 🇹🇭 Thai (th) — @pknn
- 🇺🇦 Ukrainian (uk) — @aresofficial
- 🇺🇿 Uzbek (uz) — @root5427
- 🇹🇷 Turkish (tr) — @ragokan, @cemkaan
- 🇻🇳 Vietnamese (vi) — @oanhnn

Although flags are poor representations of languages (flags indicate a geographic nation, while languages can be spoken in many ares of the world), we use the flags in the list above to indicate the location of the contributor who created that particular locale.

## Using a locale

FormKit’s `defaultConfig` includes the English locale by default. To add an additional locale, import it from `@formkit/i18n` and append it to the `locales` option in your FormKit configuration. To set the active locale, specify it with the `locale` option:

```
import { defineFormKitConfig } from '@formkit/react'
import { de, fr, zh } from '@formkit/i18n'

export default defineFormKitConfig({
  // Define additional locales
  locales: { de, fr, zh },
  // Define the active locale
  locale: 'fr',
})

```

## Changing the active locale

There are two universal ways to change your active locale:

- Using `changeLocale` to globally change the locale.
- Updating the root `config.locale` value directly.

### Using changeLocale

You can change the locale of all FormKit inputs by using the `changeLocale` helper. This is the preferred method when a global change is needed:

### Example: Changing locale

#### change-locale-2.react.jsx

```jsx
import { FormKit } from '@formkit/react'
import { changeLocale } from '@formkit/i18n'
export { default as formkitConfig } from './_examples__locale-change-2__formkit.config.react.jsx'

export default function App() {
  return (
    <>
      <button
        className="border-2 px-2 py-1 mb-4"
        onClick={() => changeLocale('zh')}
      >
        Set to Chinese
      </button>
      <FormKit
        type="text"
        validation="required|length:10"
        name="username"
        validationVisibility="live"
      />
    </>
  )
}
```

#### formkit.config.react.jsx

```jsx
import { defineFormKitConfig } from '@formkit/react'
import { genesisIcons } from '@formkit/icons'
import { zh } from '@formkit/i18n'

export default defineFormKitConfig({
  locales: { zh },
  icons: {
    ...genesisIcons,
  },
})
```

### Using app state or root config

If you need more direct control, you can drive locale changes from application state and apply them to FormKit. The Vue example below updates the root FormKit `config.locale` value directly, while the React example keeps the active locale in component state and applies it with `changeLocale()`:

### Example: Changing locale via config

#### locale-change-config.react.jsx

```jsx
import { useEffect, useState } from 'react'
import { FormKit, changeLocale } from '@formkit/react'
export { default as formkitConfig } from './_examples__locale-change-config__formkit.config.react.jsx'

const styles = `
  .locale-switch {
    display: inline-block;
    margin-bottom: 2em;
  }

  .locale-note {
    display: block;
    margin-top: 1em;
    color: SlateGray;
  }
`

export default function App() {
  const [current, setCurrent] = useState('en')

  useEffect(() => {
    changeLocale(current)

    return () => {
      changeLocale('en')
    }
  }, [current])

  const toggleLocale = () => {
    setCurrent((locale) => (locale === 'en' ? 'de' : 'en'))
  }

  return (
    <>
      <style>{styles}</style>
      <a
        className="locale-switch"
        onClick={(event) => {
          event.preventDefault()
          toggleLocale()
        }}
        href="#"
      >
        {current === 'en' ? (
          <span>🇩🇪 config.locale = 'de'</span>
        ) : (
          <span>🇺🇸 config.locale = 'en'</span>
        )}
      </a>
      <FormKit type="form" onSubmit={() => false}>
        <FormKit
          type="email"
          label="Email"
          placeholder="email@example.com"
          validation="required|email"
        />
      </FormKit>
      <small className="locale-note">
        Note: this example does not contain a full german locale, only the
        messages required for this example (submit, required, email).
      </small>
    </>
  )
}
```

#### formkit.config.react.jsx

```jsx
import { defineFormKitConfig } from '@formkit/react'
import { genesisIcons } from '@formkit/icons'

export default defineFormKitConfig({
  locales: {
    de: {
      ui: {
        submit: 'Senden',
      },
      validation: {
        required({ name }) {
          return `${name[0].toUpperCase() + name.slice(1)} ist ein Pflichtfeld.`
        },
        email: 'Dies ist keine gueltige E-Mail.',
      },
    },
  },
  icons: {
    ...genesisIcons,
  },
})
```

## Overriding

If you find a phrase in your locale isn’t worded the way you prefer, you can override those individual messages globally in your configuration by providing a `messages` object:

```
import { defineFormKitConfig } from '@formkit/react'

export default defineFormKitConfig({
  messages: {
    en: {
      ui: {
        submit: '🚀 Launch',
      },
    },
  },
})

```

> **Tip:** Messages are generally found under a locale’s `ui` or `validation` property. To see a full list of keys and messages checkout the english locale.

## Adding your language

Writing a locale for a language you know is a great way to contribute to FormKit and an easy way to get started with open source too! We are always eager to see pull requests for new locales. To support this effort, we’ve created a locale builder — a small web app to make the translation process as easy as possible.

Of course, you are not required to use our locale builder to submit a language, and are more than welcome to submit a standard pull request with your locale included.

> **Info:** If your language is already on the list (let's say English), but your locality speaks a variation of that language (like 🇬🇧 `en-GB`), please feel free to submit your localized language.
