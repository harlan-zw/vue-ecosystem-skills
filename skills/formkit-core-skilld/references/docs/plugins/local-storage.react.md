# Save to LocalStorage

Save unsubmitted user form input to localStorage to prevent data loss.

# LocalStorage Plugin

Using the `createLocalStoragePlugin` function from `@formkit/addons`, you can easily save unsubmitted user form inputs to localStorage which will be restored on page load. This is great for preventing data loss in the event a user's browser crashes, tab is closed, or other unforeseen issue causes your application to reload before the user can submit their data.

LocalStorage data is automatically cleared when a form `submit` is called.

## Installation

To use this plugin with FormKit, install `@formkit/addons`:

```
yarn add @formkit/addons

```

Once you've installed the addons package, you'll need to register the plugin with FormKit. The `createLocalStoragePlugin` has options you can configure:

- `prefix` - The prefix assigned to your localStorage key. Defaults to `formkit`.
- `key` - An optional key to include in the localStorage key name, useful for keying data to a particular user.
- `control` - An optional field name for a field in your form you would like to use to enable saving to localStorage when `true`. The field value must be a boolean.
- `maxAge` - The time (in milliseconds) that the saved localStorage should be considered valid. Defaults to 1 hour.
- `debounce` - The debounce to apply to saving data to localStorage. Defaults to `200`ms
- `beforeSave`: — An optional async callback that recieves the form data. Allows modification of form data before saving to localStorage.
- `beforeLoad`: — An optional async callback that recives the form data. Allows modification of the localStorage data before applying to the form.

```
import { defineFormKitConfig } from '@formkit/react'
import { createLocalStoragePlugin } from '@formkit/addons'

export default defineFormKitConfig({
  plugins: [
    createLocalStoragePlugin({
      prefix: 'formkit',
      key: undefined,
      control: undefined,
      maxAge: 3600000,
      debounce: 200,
      beforeSave: undefined,
      beforeLoad: undefined,
    }),
  ],
})

```

## Usage

To enable saving to localStorage add the `use-local-storage` to your FormKit `form`. The localStorage key will be your provided `prefix` (default is `formkit`) and your form `name` eg. `formkit-contact`.

In React JSX this prop is written as <code>useLocalStorage</code>.

### Basic example

### Example: Save to LocalStorage

#### basic.react.jsx

```jsx
const submitHandler = async (_payload, node) => {
  await new Promise((resolve) => setTimeout(resolve, 2000))
  node.reset()
}

export default function App() {
  return (
    <>

      <FormKit
        type="form"
        name="contact"
        useLocalStorage
        onSubmit={submitHandler}
      >
        <FormKit type="text" name="name" label="Your name" />
        <FormKit type="text" name="email" label="Your email" />
        <FormKit type="textarea" name="message" label="Your message" />
      </FormKit>
```

#### formkit.config.react.jsx

```jsx
import { defineFormKitConfig } from '@formkit/react'
import { genesisIcons } from '@formkit/icons'
import { createLocalStoragePlugin } from '@formkit/addons'

export default defineFormKitConfig({
  plugins: [
    createLocalStoragePlugin({
      prefix: 'formkit',
      maxAge: 1000 * 60 * 60,
    }),
  ],
  icons: {
    ...genesisIcons,
  },
})
```

That's it! Your form data will now be saved on every `commit` event that the `form` receives. It will remain valid until the `maxAge` set in your plugin config, and the localStorage data is cleared when the `submit` event fires on the target form.

### Restoring values on failed submit

When a user submits your form the matching localStorage entry for the form is deleted. Before deletion the value of the localStorage entry is stored in-memory and can be recovered by calling the `node.restoreCache()` method in your submit handler. This is useful for restoring user-entered data in the event that you have a failure in your submission process such as a server error.

### Example: Save with Key

#### restore.react.jsx

```jsx
const failingSubmitHandler = async (_payload, node) => {
  await new Promise((resolve) => setTimeout(resolve, 1000))
  node.setErrors(['Something went wrong with the server, please try again'])
  node.restoreCache()
}

export default function App() {
  return (
    <>

      <p>
        <em>
          <small>
            Data can be recovered with node.restoreCache()
            <br />
            If you reload after submit the data will persist.
          </small>
        </em>
      </p>
      <FormKit
        type="form"
        name="contactWithRestore"
        useLocalStorage
        onSubmit={failingSubmitHandler}
      >
        <FormKit type="text" name="name" label="Your name" />
        <FormKit type="text" name="email" label="Your email" />
        <FormKit type="textarea" name="message" label="Your message" />
      </FormKit>
```

#### formkit.config.react.jsx

```jsx
import { defineFormKitConfig } from '@formkit/react'
import { genesisIcons } from '@formkit/icons'
import { createLocalStoragePlugin } from '@formkit/addons'

export default defineFormKitConfig({
  plugins: [createLocalStoragePlugin()],
  icons: {
    ...genesisIcons,
  },
})
```

### With unique keys

If you are saving data to localStorage in the context of an app where multiple users might share the same device you can provide a `key` that is unique to the user and each user will then have their own localStorage entry.

### Example: Save with Key

#### key.react.jsx

```jsx
const [user, setUser] = useState(1)

  const submitHandler = async (_payload, node) => {
    await new Promise((resolve) => setTimeout(resolve, 2000))
    node.reset()
  }

  function handleChange(value) {
    const nextUser =
      typeof value === 'number'
        ? value
        : Number.isNaN(Number(value))
        ? 1
        : Number(value)
    setUser(nextUser)
    window.location.reload()
  }

  return (
    <>

      <FormKit
        type="form"
        name="multiUserDemo"
        useLocalStorage
        plugins={[createLocalStoragePlugin({ debounce: 0 })]}
        actions={false}
      >
        <p>Switch between mock users of our app:</p>
        <FormKit
          type="select"
          modelValue={user}
          onUpdateModelValue={handleChange}
          name="user"
          options={[
            { label: 'Dave', value: 1 },
            { label: 'Amanda', value: 2 },
            { label: 'Larry', value: 3 },
          ]}
        />
      </FormKit>
      <hr />
      <div key={user}>
        <p>
          <em>
            <small>Data in localStorage is keyed to each user ID</small>
          </em>
        </p>
        <FormKit
          type="form"
          name="contactWithKey"
          plugins={[
            createLocalStoragePlugin({
              key: user,
            }),
          ]}
          useLocalStorage
          onSubmit={submitHandler}
        >
          <FormKit type="text" name="name" label="Your name" />
          <FormKit type="text" name="email" label="Your email" />
          <FormKit type="textarea" name="message" label="Your message" />
        </FormKit>
      </div>
```

### With a control

You can allow a user to opt-in to saving their form data to localStorage by supplying the name of a field that returns a `boolean` value. When `true`, values will be saved.

### Example: Save with Control

#### control.react.jsx

```jsx
const submitHandler = async (_payload, node) => {
  await new Promise((resolve) => setTimeout(resolve, 2000))
  node.reset()
}

export default function App() {
  return (
    <>

      <p>
        <em>
          <small>Data saving is controlled by the form&apos;s checkbox.</small>
        </em>
      </p>
      <FormKit
        type="form"
        name="contactWithControl"
        plugins={[
          createLocalStoragePlugin({
            control: 'save',
          }),
        ]}
        useLocalStorage
        onSubmit={submitHandler}
      >
        <FormKit
          type="checkbox"
          name="save"
          value={true}
          label="Save my progress as I type"
        />
        <FormKit type="text" name="name" label="Your name" />
        <FormKit type="text" name="email" label="Your email" />
        <FormKit type="textarea" name="message" label="Your message" />
      </FormKit>
```

### With data modification

Using the `beforeSave` and `beforeLoad` async callbacks you can modify the data that is saved to localStorage. This can be useful if you want to run some sort of obfuscation funciton or send the data to your backend to encrypt it. In this examle, we obfuscate the data by base64 encoding the form values.

Note that the form is disabled when loading data from localStorage until our `beforeLoad` callback resolves.

### Example: Save with Modification

#### modification.react.jsx

```jsx
const submitHandler = async (_payload, node) => {
  await new Promise((resolve) => setTimeout(resolve, 2000))
  node.reset()
}

async function beforeSave(value) {
  await new Promise((resolve) => setTimeout(resolve, 500))
  return btoa(JSON.stringify(value))
}

async function beforeLoad(value) {
  await new Promise((resolve) => setTimeout(resolve, 1000))
  return JSON.parse(atob(value))
}

export default function App() {
  return (
    <>

      <p>
        <em>
          <small>
            If you check localStorage you will see that saved form data is
            base64 encoded.
          </small>
        </em>
      </p>
      <FormKit
        type="form"
        name="contactWithModification"
        plugins={[
          createLocalStoragePlugin({
            beforeSave,
            beforeLoad,
          }),
        ]}
        useLocalStorage
        onSubmit={submitHandler}
      >
        <FormKit type="text" name="name" label="Your name" />
        <FormKit type="text" name="email" label="Your email" />
        <FormKit type="textarea" name="message" label="Your message" />
      </FormKit>
```

> **Warning:** `localStorage` form information should be considered transient and ultimately stored in a database. We recommend clearing `localStorage` keys related to form data when a user logs out of your applications. You can do this by looping over `Object.entries(localStorage)` and removing all `localStorage` entries that start with `${prefix}-${id}` from your plugin configuration.
