# Dropdown Input

A Pro input that allows users to select from a customizable options list.

The `dropdown` input allows users to select a value from a list of options. Unlike native select elements, the dropdown input allows you to customize both its appearance and behavior.

In React JSX props like <code>selectionAppearance</code>, <code>alwaysLoadOnOpen</code>, <code>loadOnCreated</code>, and <code>selectionRemovable</code> use the standard prop casing for that framework.

The `options` prop can accept three different formats of values:

- An array of objects with `value` and `label` keys (see example above)
- An array of strings `['A', 'B', 'C']`
- An object literal with key-value pairs `{ a: 'A', b: 'B', c: 'C' }`
- A function that returns any of the above

> **Warning:** If you assign options as an empty array, the input will be rendered in a disabled state.

## Basic examples

### Single-select

The dropdown input will render in single-select mode by default.

### Example: Dropdown

#### dropdown-single.react.jsx

```jsx
const frameworks = [
  { label: 'React', value: 'react' },
  { label: 'Vue', value: 'vue' },
  { label: 'Angular', value: 'angular' },
  { label: 'Svelte', value: 'svelte' },
]

function DropdownExample() {
  return (
    <FormKit type="form" actions={false}>
      {({ value }) => (
        <>
          <FormKit
            type="dropdown"
            name="framework"
            label="Choose your favorite frontend framework"
            placeholder="Backbone.js"
            popover
            options={frameworks}
          />
          <pre>{JSON.stringify(value, null, 2)}</pre>
        </>
      )}
    </FormKit>
  )
}
```

### Multi-select

Dropdown inputs with the prop `multiple` set will render in multi-select mode.

### Example: Dropdown

#### dropdown-multiple.react.jsx

```jsx
const sandwichToppings = [
  { label: 'Lettuce', value: 'lettuce' },
  { label: 'Tomato', value: 'tomato' },
  { label: 'Onion', value: 'onion' },
  { label: 'Pickles', value: 'pickles' },
  { label: 'Cheese', value: 'cheese' },
  { label: 'Mayo', value: 'mayo' },
  { label: 'Mustard', value: 'mustard' },
  { label: 'Ketchup', value: 'ketchup' },
  { label: 'Avocado', value: 'avocado' },
  { label: 'Bacon', value: 'bacon' },
  { label: 'Ham', value: 'ham' },
  { label: 'Turkey', value: 'turkey' },
  { label: 'Chicken', value: 'chicken' },
  { label: 'Roast Beef', value: 'roast-beef' },
  { label: 'Salami', value: 'salami' },
  { label: 'Pastrami', value: 'pastrami' },
  { label: 'Tuna', value: 'tuna' },
  { label: 'Egg Salad', value: 'egg-salad' },
]

function DropdownExample() {
  return (
    <FormKit type="form" actions={false}>
      {({ value }) => (
        <>
          <FormKit
            type="dropdown"
            name="sandwich_toppings"
            label="Select as many toppings as you would like"
            placeholder="Lettuce, tomato, onion, etc."
            options={sandwichToppings}
            multiple
            popover
            defaultValue={['lettuce', 'tomato']}
          />
          <pre>{JSON.stringify(value, null, 2)}</pre>
        </>
      )}
    </FormKit>
  )
}
```

> **Info:** Notice in the example above that because the `multiple` prop is set, the `value` prop must be an array.

## Dynamic options

Instead of passing a static list to the `options` prop, options can be assigned dynamically.

In this example, the function, `loadHorrorMovies`, makes a request to the API for TMDB to load a list of horror movies. Assigning the function to the `options` prop will load the options when the end-user opens the listbox.

### Example: Dropdown

#### dropdown-single-request.react.jsx

```jsx
async function loadHorrorMovies() {
  await new Promise((resolve) => setTimeout(resolve, 500))
  const res = await fetch(
    'https://api.themoviedb.org/4/list/8219282?page=1&api_key=f48bcc9ed9cbce41f6c28ea181b67e14'
  )
  if (res.ok) {
    const data = await res.json()
    return data.results.map((result) => {
      return {
        label: result.title,
        value: result.id,
      }
    })
  }
  return []
}

function DropdownExample() {
  return (
    <FormKit
      name="horrorMovie"
      type="dropdown"
      label="Select a horror movie"
      placeholder="Example placeholder"
      popover
      options={loadHorrorMovies}
    />
  )
}
```

#### Always load on open

By default the dropdown will only load options asynchronously once (upon the listbox being expanded). Setting the prop `always-load-on-open`  will cause the dropdown to load options every time the listbox is expanded.

### Example: Dropdown

#### dropdown-always-load-on-open.react.jsx

```jsx
<FormKit
        name="horrorMovie"
        type="dropdown"
        label="Select a horror movie"
        placeholder="Example placeholder"
        options={loadHorrorMovies}
        popover
        alwaysLoadOnOpen
      />
```

#### Load on created

The prop `load-on-created` will cause the dropdown to load options as soon as it is created.

### Example: Dropdown

#### dropdown-load-on-created.react.jsx

```jsx
{showDropdown ? (
        <FormKit
          name="horrorMovie"
          type="dropdown"
          label="Select a horror movie"
          placeholder="Example placeholder"
          popover
          options={loadHorrorMovies}
          loadOnCreated
        />
      ) : null}
```

### Pagination

A function assigned the options prop will be passed two arguments: `page` and `hasNextPage`. The page argument indicates the current page number, and hasNextPage is a callback function that indicates whether there are more pages to load.

### Example: Dropdown

#### dropdown-pagination.react.jsx

```jsx
async function loadCurrentlyPopularMovies({ page, hasNextPage }) {
  await new Promise((resolve) => setTimeout(resolve, 500))
  const res = await fetch(
    `https://api.themoviedb.org/3/movie/popular?api_key=f48bcc9ed9cbce41f6c28ea181b67e14&language=en-US&page=${page}`
  )
  if (res.ok) {
    const data = await res.json()
    if (page !== data.total_pages) hasNextPage()
    return data.results.map((item) => ({ label: item.title, value: item.id }))
  }
  return []
}

function DropdownExample() {
  return (
    <FormKit
      name="currentlyPopularMovie"
      type="dropdown"
      label="Choose a currently popular movie"
      options={loadCurrentlyPopularMovies}
      popover
      placeholder="Terminator 12"
    />
  )
}
```

#### Load on scroll

If you would rather allow the user to load more options without having to click the *Load more* option at the bottom of the options list, you can set the `load-on-scroll` prop to true, and our function, `loadCurrentlyPopularMovies` will be called again:

### Example: Dropdown

#### dropdown-pagination-load-on-scroll.react.jsx

```jsx
<FormKit
        type="dropdown"
        label="Choose a currently popular movie"
        placeholder="Star Wars Part XV"
        options={loadCurrentlyPopularMovies}
        popover
        loadOnScroll
      />
```

### Option loader

FormKit's dropdown input also provides an `optionLoader` prop that allows you to rehydrate values that are not in the options list. In this example the dropdown is provided an initial value (two movie IDs). The `optionLoader` function is called for each value that is not in the options list.

### Example: Dropdown

#### dropdown-option-loader.react.jsx

```jsx
async function loadCurrentlyPopularMovies({ page, hasNextPage }) {
  const res = await fetch(
    `https://api.themoviedb.org/3/movie/popular?api_key=f48bcc9ed9cbce41f6c28ea181b67e14&language=en-US&page=${page}`
  )
  if (res.ok) {
    const data = await res.json()
    if (page !== data.total_pages) hasNextPage()
    return data.results.map((item) => ({ label: item.title, value: item.id }))
  }
  return []
}

async function loadMovie(id, cachedOption) {
  if (cachedOption) return cachedOption
  const res = await fetch(
    `https://api.themoviedb.org/3/movie/${id}?api_key=f48bcc9ed9cbce41f6c28ea181b67e14&language=en-US`
  )
  if (res.ok) {
    const data = await res.json()
    return {
      label: data.title,
      value: data.id,
    }
  }
  return { label: 'Error loading' }
}

function DropdownExample() {
  return (
    <FormKit
      type="dropdown"
      name="currentlyPopularMovie"
      label="Choose some movies you would like to see"
      placeholder="Avatar, Star Wars..."
      options={loadCurrentlyPopularMovies}
      optionLoader={loadMovie}
      multiple
      popover
      defaultValue={[597, 598]}
    />
  )
}
```

Notice in the example above that the optionLoader function is passed two arguments: the `value` of the selected option (in this case, the movie ID) and the `cachedOption`. The cachedOption prop is used for preventing unnecessary lookups. If the cachedOption is not `null` it means that the selected option has already been loaded, and you can return the cachedOption directly.

## Option appearance

Unlike native select elements, the dropdown input can be customized via. markup.

### Option slot

The dropdown input allows you to customize the look and feel of each option by using the option slot. In this example, we are using the option slot to display each option's asset, logo, and name:

In React this is typically implemented with an <code>option</code> entry on the <code>slots</code> prop.

### Example: Dropdown

#### dropdown-option-slot.react.jsx

```jsx
const frameworks = [
  {
    label: 'React',
    value: 'react',
    asset:
      'https://s3.amazonaws.com/cdn.formk.it/example-assets/frontend-framework-logos/react-logo.png',
  },
  {
    label: 'Vue',
    value: 'vue',
    asset:
      'https://s3.amazonaws.com/cdn.formk.it/example-assets/frontend-framework-logos/vue-logo.png',
  },
  {
    label: 'Angular',
    value: 'angular',
    asset:
      'https://s3.amazonaws.com/cdn.formk.it/example-assets/frontend-framework-logos/angular-logo.png',
  },
  {
    label: 'Svelte',
    value: 'svelte',
    asset:
      'https://s3.amazonaws.com/cdn.formk.it/example-assets/frontend-framework-logos/svelte-logo.png',
  },
]

function DropdownExample() {
  return (
    <FormKit
      type="dropdown"
      name="framework"
      label="Choose a frontend framework"
      placeholder="Example placeholder"
      popover
      options={frameworks}
      slots={{
        option: ({ option, classes }) => (
          <div className={`${classes.option} flex items-center`}>
            <img src={option.asset} alt="optionAvatar" className="w-5 mr-2" />
            <span>{option.label}</span>
          </div>
        ),
      }}
    />
  )
}
```

## Selection appearance

The dropdown input allows you to customize the look and feel of the selected option(s).

### Selection appearance prop

When using the dropdown input as a `multi-select`, you can customize the look and feel of the selected options by setting the `selection-appearance` prop to either `truncate` (the default) or `tags`.

### Example: Dropdown

#### dropdown-selection-appearance.react.jsx

```jsx
import countries from './_examples___data__countries.js'

function DropdownExample() {
  return (
    <>
      <FormKit
        type="dropdown"
        label="Single-select"
        placeholder="Pick a country"
        options={countries}
        popover
        defaultValue="FR"
      />
      <FormKit
        type="dropdown"
        label="Truncate appearance"
        placeholder="Pick a country"
        options={countries}
        popover
        multiple
        defaultValue={['FR', 'GR', 'ES']}
      />
      <FormKit
        type="dropdown"
        label="Tags appearance"
        placeholder="Pick a country"
        options={countries}
        popover
        multiple
        selectionAppearance="tags"
        defaultValue={['FR', 'GR', 'ES']}
      />
    </>
  )
}
```

### Selection slot

If you only want to customize the display of the selected option, use the selection slot (as opposed to the option slot mentioned above):

In React this is typically implemented with <code>selection</code> or <code>tag</code> entries on the <code>slots</code> prop.

### Example: Dropdown

#### dropdown-selection-slot.react.jsx

```jsx
const frameworks = [
  {
    label: 'React',
    value: 'react',
    asset:
      'https://s3.amazonaws.com/cdn.formk.it/example-assets/frontend-framework-logos/react-logo.png',
  },
  {
    label: 'Vue',
    value: 'vue',
    asset:
      'https://s3.amazonaws.com/cdn.formk.it/example-assets/frontend-framework-logos/vue-logo.png',
  },
  {
    label: 'Angular',
    value: 'angular',
    asset:
      'https://s3.amazonaws.com/cdn.formk.it/example-assets/frontend-framework-logos/angular-logo.png',
  },
  {
    label: 'Svelte',
    value: 'svelte',
    asset:
      'https://s3.amazonaws.com/cdn.formk.it/example-assets/frontend-framework-logos/svelte-logo.png',
  },
]

function DropdownExample() {
  return (
    <>
      <FormKit
        name="framework"
        type="dropdown"
        label="Single-select"
        placeholder="Example placeholder"
        options={frameworks}
        popover
        defaultValue="vue"
        slots={{
          selection: ({ option, classes }) => (
            <div style={{ display: 'flex', alignItems: 'center' }}>
              <img
                src={option.asset}
                alt="optionAvatar"
                style={{ width: '1.25rem', marginRight: '0.5rem' }}
              />
              <span className={classes.selection}>{option.label}</span>
            </div>
          ),
        }}
      />

      <FormKit
        type="dropdown"
        name="framework"
        label="Tags appearance"
        placeholder="Example placeholder"
        options={frameworks}
        multiple
        selectionAppearance="tags"
        defaultValue={['vue', 'angular']}
        slots={{
          tag: ({ handlers, option, classes }) => (
            <div
              className={classes.tag}
              style={{ display: 'flex', alignItems: 'center' }}
            >
              <img
                src={option.asset}
                alt=""
                style={{
                  width: '1rem',
                  marginRight: '0.25rem',
                  backgroundColor: 'white',
                  borderRadius: '0.25rem',
                }}
              />
              <span className={classes.tagLabel}>{option.label}</span>
              <button
                onClick={handlers.removeSelection(option)}
                tabIndex={-1}
                type="button"
                className={classes.removeSelection}
                style={{
                  background: 'none',
                  border: 'none',
                  padding: 0,
                  marginLeft: '0.25rem',
                  cursor: 'pointer',
                }}
              >
                <span className={`${classes.closeIcon} ${classes.icon}`}>
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 12 16">
                    <path
                      d="M10,12.5c-.13,0-.26-.05-.35-.15L1.65,4.35c-.2-.2-.2-.51,0-.71,.2-.2,.51-.2,.71,0L10.35,11.65c.2,.2,.2,.51,0,.71-.1,.1-.23,.15-.35,.15Z"
                      fill="currentColor"
                    />
                    <path
                      d="M2,12.5c-.13,0-.26-.05-.35-.15-.2-.2-.2-.51,0-.71L9.65,3.65c.2-.2,.51-.2,.71,0,.2,.2,.2,.51,0,.71L2.35,12.35c-.1,.1-.23,.15-.35,.15Z"
                      fill="currentColor"
                    />
                  </svg>
                </span>
              </button>
            </div>
          ),
        }}
      />
    </>
  )
}
```

> **Warning:** The selection slot does not exist on the multi-select dropdown with selection appearance `truncate`.

## Behavioral props

The following props allow you to customize the behavior of the dropdown input.

### Empty Message

The dropdown input, by default, will be rendered in a disabled state if no options are passed. Optionally, you may pass the `empty-message` prop a message to display when no options are available:

### Example: Dropdown

#### dropdown-empty-message.react.jsx

```jsx
function DropdownExample() {
  return (
    <div>
      <FormKit label="No options" options={[]} type="dropdown" popover />
      <FormKit
        label="No options, empty message set."
        options={[]}
        type="dropdown"
        popover
        emptyMessage="No options here!"
      />
    </div>
  )
}
```

### Selection Removable

If you would like to allow users to remove the selected value, set the `selection-removable` prop to true. This will render a close icon next to the selected value:

> **Warning:** The selection-removable prop cannot be used for multi-selects.

### Example: Dropdown

#### dropdown-selection-removable.react.jsx

```jsx
const frameworks = [
  { label: 'React', value: 'react' },
  { label: 'Vue', value: 'vue' },
  { label: 'Angular', value: 'angular' },
  { label: 'Svelte', value: 'svelte' },
]

function DropdownExample() {
  return (
    <FormKit type="form" actions={false}>
      {({ value }) => (
        <>
          <FormKit
            type="dropdown"
            name="framework"
            label="Choose a frontend framework"
            placeholder="Example placeholder"
            options={frameworks}
            defaultValue="vue"
            popover
            selectionRemovable
          />
          <pre>{JSON.stringify(value, null, 2)}</pre>
        </>
      )}
    </FormKit>
  )
}
```

### Open on remove

By default, when the `selection-removable` prop is set to `true`, the dropdown will not open after the selected value is removed. You can change this behavior by setting the `open-on-remove` prop to `true`:

### Example: Dropdown

#### dropdown-open-on-remove.react.jsx

```jsx
const frameworks = [
  { label: 'React', value: 'react' },
  { label: 'Vue', value: 'vue' },
  { label: 'Angular', value: 'angular' },
  { label: 'Svelte', value: 'svelte' },
]

function DropdownExample() {
  return (
    <FormKit type="form" actions={false}>
      {({ value }) => (
        <>
          <FormKit
            type="dropdown"
            name="framework"
            label="Choose a frontend framework"
            placeholder="Example placeholder"
            options={frameworks}
            defaultValue="vue"
            popover
            selectionRemovable
            openOnRemove
          />
          <pre>{JSON.stringify(value, null, 2)}</pre>
        </>
      )}
    </FormKit>
  )
}
```

### Close on select

By default, when the `multiple` prop is set, the dropdown will not close after an option is selected. You can change this behavior by setting the `close-on-select` prop to `true`:

### Example: Dropdown

#### dropdown-close-on-select.react.jsx

```jsx
import countries from './_examples___data__countries.js'

function DropdownExample() {
  return (
    <FormKit type="form" actions={false}>
      {({ value }) => (
        <>
          <FormKit
            type="dropdown"
            name="countries"
            label="Choose your favorite countries"
            placeholder="Afghanistan, Albania..."
            options={countries}
            multiple
            popover
            closeOnSelect
          />
          <pre>{JSON.stringify(value, null, 2)}</pre>
        </>
      )}
    </FormKit>
  )
}
```

### Open on focus

If you would like expand the listbox as soon as the dropdown input is focused, you can use the `open-on-focus` prop:

### Example: Dropdown

#### dropdown-open-on-focus.react.jsx

```jsx
const frameworks = [
  { label: 'React', value: 'react' },
  { label: 'Vue', value: 'vue' },
  { label: 'Angular', value: 'angular' },
  { label: 'Svelte', value: 'svelte' },
]

function focusDropdown() {
  document.getElementById('dropdown')?.focus()
}

function DropdownExample() {
  return (
    <div>
      <FormKit type="button" onClick={focusDropdown}>
        Click me to focus dropdown
      </FormKit>
      <FormKit
        id="dropdown"
        type="dropdown"
        name="framework"
        label="Choose a frontend framework"
        placeholder="Example placeholder"
        options={frameworks}
        defaultValue="vue"
        popover
        openOnFocus
      />
    </div>
  )
}
```

### Overscroll

When using the dropdown with static options, FormKit's dropdown also comes with a feature called `overscroll`. Setting the `behavior` prop to overscroll will render the listbox directly over the input to maximize the available size for the list:

### Example: Dropdown

#### dropdown-overscroll.react.jsx

```jsx
<FormKit
        type="dropdown"
        label="Select a country"
        options={countries}
        behavior="overscroll"
        defaultValue="NP"
        placeholder="Select a country"
      />
```

### Max

If you would like to limit the number of options that can be selected, you can use the `max` prop:

### Example: Dropdown

#### dropdown-max.react.jsx

```jsx
import countries from './_examples___data__countries.js'

function DropdownExample() {
  return (
    <FormKit type="form" actions={false}>
      {({ value }) => (
        <>
          <FormKit
            type="dropdown"
            name="countries"
            label="Choose your favorite countries"
            placeholder="Afghanistan, Albania..."
            options={countries}
            multiple
            popover
            max="3"
            defaultValue={['AF', 'AL']}
          />
          <pre>{JSON.stringify(value, null, 2)}</pre>
        </>
      )}
    </FormKit>
  )
}
```

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `options` | `any` | `[]` | The list of options the user can select from. |
| `load-on-scroll` | `boolean` | `false` | When set to true, the dropdown will try loading more options based on the end-user`s scroll position |
| `option-loader` | `function` | `null` | Used for hydrating initial value, or performing an additional request to load more information of a selected option. |
| `empty-message` | `string` | `undefined` | Renders a message when there are no options to display. |
| `selection-appearance` | `string` | `truncate` | For multi-select dropdowns, this prop allows you to customize the look and feel of the selected options. Possible values are truncate (the default) or tags. |
| `selection-removable` | `boolean` | `false` | For single-select dropdowns, this prop allows you to remove the selected value. |
| `open-on-remove` | `boolean` | `false` | When the selection-removable prop is set to true, the dropdown will not open after the selected value is removed. You can change this behavior by setting the open-on-remove prop to true. |
| `close-on-select` | `boolean` | `false` | When the multiple prop is set, the dropdown will not close after an option is selected. You can change this behavior by setting the close-on-select prop to true. |
| `open-on-focus` | `boolean` | `false` | If you would like expand the listbox as soon as the dropdown input is focused, you can use the open-on-focus prop. |
| `options-appearance` | `string` | `undefined` | For multi-select dropdowns, this prop allows you to customize the look and feel of the selected options. Possible values are default (the default) or checkbox. |
| `multiple` | `boolean` | `false` | When set to true, the dropdown will allow the user to select multiple options. |
| `behavior` | `string` | `undefined` | Renders the listbox directly over the input to maximize the available size for the list. |
| `always-load-on-open` | `boolean` | `false` | Determines whether the dropdown should always load its options when opened or whether it should reference the options that were previously found when opening. |
| `` | `boolean` | `false` | When set to true, the dropdown will load the options when the node is created. |
| `` | `number | string` | `undefined` | If you would like to limit the number of options that can be selected, you can use the max prop (applies only to multi-select). |
| `` | `boolean` | `true` | When set to false, the end-user cannot deselect a selected option form the listbox. |
| `popover` | `boolean` | `false` | Renders the input's listbox using the browser Popover API. |

## Sections & slot data

You can target specific sections of an input using the `section-key` attribute or slots. Each section can be styled or customized independently.

## Slot Data

### Universal Slot Data

Available in all sections of this input:

| Property | Type | Description |
|----------|------|-------------|
| `_value` | `any` | The current  |
| `_root` | `Document | ShadowRoot` | The root document or shadow root the input is inside. This can be set by using a higher-order `<FormKitRoot>` component. |
| `attrs` | `Record<string, any>` | An object of attributes that (generally) should be applied to the root <input> element. |
| `classes` | `Record<string, string>` | Classes to apply on the various sections. |
| `defaultMessagePlacement` | `boolean` | Whether or not to render messages in the standard location. |
| `describedBy` | `string` | The ID of an element that describes the input. This is generally used for screen readers. |
| `didMount` | `boolean` | Whether or not the input has been mounted. |
| `disabled` | `boolean` | Whether the input is disabled. |
| `family` | `string` | The family of the input. This is generally the same as the input type but can be used to group similar inputs for styling purposes. |
| `fns` | `Record<string, (...args: any[]) => any>` | Utility functions, generally for use in the input’s schema. |
| `help` | `string` | The help text of the input |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers. |
| `id` | `string` | The unique id of the input. Should also be applied as the id attribute. This is generally required for accessibility reasons. |
| `items` | `symbol[]` | An array of symbols that represent the a child’s nodes. These are not the child’s nodes but are just symbols representing them. They are used to iterate over the children for rendering purposes. |
| `label` | `string` | The label of the input |
| `messages` | `Record<string, FormKitMessage>` |  A list of messages to be displayed on the input. Often these are validation messages and error messages, but other `visible` core node messages do also apply here. This object is only populated when the validation should be actually displayed. |
| `node` | `FormKitNode` | The cored node of this input. |
| `slots` | `Record<string, CallableFunction>` | A record of slots that have been passed into the top level component responsible for creating the node. |
| `state` | `FormKitFrameworkContextState` | A collection of state trackers/details about the input |
| `type` | `string` | The type of input eg.  |
| `ui` | `Record<string, FormKitMessage>` | Translated ui messages that are not validation related. These are generally used for interface messages like  |
| `value` | `any` | The current committed value of the input. This is the value that should be used for most use cases. The setting of this property is debounced by the value of the debounce prop (default of 20ms). |

### Input-Specific Slot Data

Additional slot data specific to the `dropdown` input:

| Property | Type | Description |
|----------|------|-------------|
| `options` | `FormKitOptionsList` | An array of option objects available for selection. |
| `isOpen` | `boolean` | Whether the dropdown listbox is currently open. |
| `selection` | `FormKitOptionsProp | FormKitOptionsProp[]` | The currently selected option(s). |
| `selections` | `FormKitOptionsProp[]` | Array of all selected options (for multi-select). |
| `selectionAppearance` | `any` | How selected values are displayed in multi-select mode (truncate or tags). |
| `multiple` | `boolean` | Whether multiple options can be selected. |
| `placeholder` | `string` | Placeholder text shown when no option is selected. |
| `truncationCount` | `string` | The  |
| `fns` | `Record<string, (...args: any[]) => any>` | Utility functions for the dropdown input. |
| `fns.isSelected` | `(option: FormKitOptionsProp) => boolean` | Returns true if the given option is currently selected. |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the dropdown input. |
| `handlers.toggle` | `() => void` | Toggles the dropdown open/closed. |
| `handlers.open` | `() => void` | Opens the dropdown. |
| `handlers.close` | `() => void` | Closes the dropdown. |
| `handlers.select` | `(option: FormKitOptionsProp) => void` | Selects an option. |
| `handlers.deselect` | `(option: FormKitOptionsProp) => void` | Deselects an option. |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |
| `option` | `option`, `listitem`, `selection`, `selectionWrapper`, `selectorSelectionsItem`, `tagWrapper`, `tag`, `tagLabel` | `FormKitOptionsProp` | The current option object when iterating. Contains value, label, and attrs. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```

#### Selector structure
The main input structure with selector button and icons.
- outer
  └─ wrapper
    └─ label
    └─ inner
      └─ prefixIcon
      └─ prefix
      └─ selector
        └─ placeholder
        └─ selectIcon
        └─ loaderIcon
        └─ closeIcon
      └─ listbox
      └─ suffix
      └─ suffixIcon
  └─ help
  └─ messages
    └─ message

#### Listbox structure
The dropdown options list rendered inside dropdownWrapper.
- dropdownWrapper
  └─ listbox
    └─ emptyMessage
      └─ emptyMessageInner
    └─ listitem
      └─ selectedIcon
      └─ option
    └─ loadMore
      └─ loadMoreInner
        └─ loaderIcon

#### Selection structure single
How a selected value displays inside the selector for single-select dropdowns.
- selector
  └─ selectionWrapper
    └─ selection
      └─ option

#### Selection structure truncate
Multi-select with selection-appearance="truncate" (default). Overflow selections show as "+N".
- selector
  └─ selectorSelectionsWrapper
    └─ selectorSelections
      └─ selectorSelectionsItem
  └─ truncationCount

#### Selection structure tags
Multi-select with selection-appearance="tags". Selections display as removable tags.
- selector
  └─ tagsWrapper
    └─ tags
      └─ tagWrapper
        └─ tag
          └─ tagLabel
          └─ removeSelection
```

### Section Keys Reference

| Section Key | Element | Description |
|-------------|---------|-------------|
| `outer` | `<div>` | The outermost wrapping element. |
| `wrapper` | `<label>` | A label element wrapping the inner section and label text. Clicking anywhere toggles the checkbox/radio. |
| `label` | `<span>` | A span containing the label text beside the checkbox/radio. |
| `inner` | `<span>` | A span wrapping the input, decorator, prefix, and suffix sections. |
| `prefixIcon` | `<label>` | An element for outputting an icon before the prefix section. |
| `prefix` | (none) | Has no output by default, but allows content directly before an input element. |
| `selector` | `<button>` | A button element that opens the dropdown options list and displays current selection. |
| `placeholder` | `<span>` | Placeholder text shown when no option is selected. |
| `selectIcon` | `<span>` | An icon displayed beside the select (typically a dropdown caret). |
| `loaderIcon` | `<span>` | Loading spinner icon. |
| `closeIcon` | `<span>` | Icon for the search clear button. |
| `listbox` | `<ul>` | The dropdown list containing available options. |
| `suffix` | (none) | Has no output by default, but allows content directly after an input element. |
| `suffixIcon` | `<span>` | An element for outputting an icon after the suffix section. |
| `help` | `<div>` | The element containing help text. |
| `messages` | `<ul>` | A wrapper around all the messages. |
| `message` | `<li>` | The element (or many elements) containing a message — most often validation and error messages. |
| `dropdownWrapper` | `<div>` | Wrapper element for the listbox, handles positioning (popover). |
| `emptyMessage` | `<li>` | Shown when there are no options to display. |
| `emptyMessageInner` | `<span>` | Inner span containing the empty message text. |
| `listitem` | `<li>` | A single option item in the listbox. |
| `selectedIcon` | `<span>` | Checkmark shown next to selected items. |
| `option` | `<div>` | Wrapper for each individual toggle button option. |
| `loadMore` | `<li>` | Element shown at the bottom of the list for loading more options. |
| `loadMoreInner` | `<span>` | Inner wrapper for the load more content. |
| `selectionWrapper` | `<div>` | Wraps each individual selection. Iterates over selected options. |
| `selection` | `<div>` | Contains the display of a single selected option. |
| `selectorSelectionsWrapper` | `<div>` | Wrapper around the truncated selections display in multi-select truncate mode. |
| `selectorSelections` | `<div>` | Container for the visible truncated selection items. |
| `selectorSelectionsItem` | `<div>` | A single selection item in truncate mode. |
| `truncationCount` | `<div>` | Displays the count of additional selections not shown (e.g., |
| `tagsWrapper` | `<div>` | Wrapper around all tag elements in multi-select tags mode. |
| `tags` | `<div>` | Container for all the tag elements. |
| `tagWrapper` | `<div>` | Wrapper around each individual tag. |
| `tag` | `<div>` | A tag element containing the label and remove button. |
| `tagLabel` | `<span>` | The label text inside a tag. |
| `removeSelection` | `<button>` | Button to clear the selected date (when clearable). |

## Accessibility

All FormKit inputs are designed with the following accessibility considerations in mind. Help us continually improve accessibility for all by filing accessibility issues here:

- ✓ Semantic markup
- ✓ ARIA attributes
- ✓ Keyboard accessibility
- ✓ Focus indicators
- ✓ Color contrast with the provided theme
- ✓ Accessible labels, help text, and errors

### Accessibility attributes

| Section | Attribute | Value | Description |
|---------|-----------|-------|-------------|
| `selector` | `tabindex` | `0` | Prioritizes keyboard focus order by setting it to 0 |
| `selector` | `aria-haspopup` | `listbox` | Signals the presence of a pop-up listbox triggered by interaction. |
| `selector` | `aria-expanded` | `-` | Indicates whether the dropdown element is currently expanded or collapsed. |
| `selector` | `aria-controls` | `-` | Links this element to the ID of the listbox element. |
| `selector` | `aria-describedBy` | `-` | Associate this element with descriptive text from another element. |
| `placeholder` | `aria-hidden` | `true` | Makes this element not exposed to the accessibility API when no placeholder exists. |
| `removeSelection` | `tabindex` | `-1` | Prioritizes keyboard focus order by setting it to -1 |
| `removeSelection` | `aria-controls` | `-` | Links this element to the ID of the input element. |
| `selections` | `aria-live` | `polite` | Annouces to screen readers that this element was dynamically updated without interrupting the current task. |
| `selections` | `aria-hidden` | `true` | Makes this element not exposed to the accessibility API. |
| `selectionsItem` | `aria-hidden` | `true` | Makes this element not exposed to the accessibility API when last visible index and index are greater than last visible index. |
| `tagWrapper` | `tabindex` | `0` | Prioritizes keyboard focus order by setting it to 0 |
| `tag` | `tabindex` | `0` | Prioritizes keyboard focus order by setting it to 0 |
| `tagsWrapper` | `aria-live` | `polite` | Annouces to screen readers that this element was dynamically updated without interrupting the current task. |

### Keyboard Interactions

| Key | Description |
|-----|-------------|
| `enter` | Opens the listbox when the input is focused. Selects an item when a list item is focused |
| `space` | Opens the listbox when the input is focused. Selects an item when a list item is focused |
| `esc` | Closes the listbox when the input is focused. |
| `up` | Navigates to previous list item in list box. Closes listbox if most-previous item is selected |
| `down` | Opens the listbox when input is focused. Navigates to next list item in list box. |
