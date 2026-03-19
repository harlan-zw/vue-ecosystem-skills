# Autocomplete Input

A Pro input that allows users to search and select from a customizable options list. Supports single and multi-value selections.

The `autocomplete` input allows you to search through a list of options.

The `options` prop can accept three different formats of values:

- An array of objects with `value` and `label` keys (see example above)
- An array of strings `['A', 'B', 'C']`
- An object literal with key-value pairs `{ a: 'A', b: 'B', c: 'C' }`
- A function that returns any of the above

> **Warning:** If you assign options as an empty array, the input will be rendered in a disabled state.

## Basic examples

### Single-select

By default, the autocomplete input will render in single-select mode:

### Example: Autocomplete

#### autocomplete-single.vue

```vue
<script setup>
import countries from './_examples___data__countries.js'
</script>

<template>
  <FormKit type="form" #default="{ value }" :actions="false">
    <FormKit
      type="autocomplete"
      name="country"
      label="Search for a country"
      placeholder="Example: United States"
      :options="countries"
      popover
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

### Multi-select

By setting the `multiple` prop the autocomplete input will render in multi-select mode:

### Example: Autocomplete

#### autocomplete-multiple.vue

```vue
<script setup>
import countries from './_examples___data__countries.js'
</script>

<template>
  <FormKit type="form" #default="{ value }" :actions="false">
    <FormKit
      type="autocomplete"
      name="country"
      label="Search for a country"
      placeholder="Example: United States"
      :options="countries"
      multiple
      popover
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

> **Info:** Notice in the example above that because the multiple prop is set, the value prop must be an array.

## Filtering

The autocomplete input will filter options with its own internal search function. You can replace this search function by providing the `filter` prop a function of your own. Your function will receive two arguments, the `option` being iterated over and the current `search` value:

### Example: Autocomplete

#### autocomplete-filter.vue

```vue
<FormKit
    type="autocomplete"
    name="autocomplete"
    label="Search for a country"
    :options="countries"
    placeholder="Example: United States"
    popover
    :filter="
      (option, search) =>
        option.label.toLowerCase().startsWith(search.toLowerCase())
    "
  />
```

## Dynamic options

Instead of passing a static list to the `options` prop, you can assign it to a function. Doing so is useful when you need to load options from an API or another source.

### Search parameter

In this example, we'll assign the `options` prop the `searchMovies` function. By doing so, searchMovies will receive the `context` object as an argument. Within this context object is the `search` property, which is the current search value. To perform our search, we'll use the search value as the query parameter for our API request:

### Example: Autocomplete

#### autocomplete-single-request.vue

```vue
<script setup>
// Search movie receives FormKit's context object
// which we are destructuring to get the search value.
async function searchMovies({ search }) {
  if (!search) return []
  const res = await fetch(
    `https://api.themoviedb.org/3/search/movie?query=${
      search || ''
    }&api_key=f48bcc9ed9cbce41f6c28ea181b67e14&language=en-US&page=1&include_adult=false`
  )
  if (res.ok) {
    const data = await res.json()
    // Iterating over results to set the required
    // `label` and `value` keys.
    return data.results.map((result) => {
      return {
        label: result.title,
        value: result.id,
      }
    })
  }
  // If the request fails, we return an empty array.
  return []
}
</script>

<template>
  <!--Setting the `options` prop to async function `loadHorrorMovies`-->
  <FormKit
    name="movie"
    type="autocomplete"
    label="Search for your favorite movie"
    placeholder="Example: Shawshank Redemption"
    popover
    :options="searchMovies"
  />
</template>
```

### Page and hasNextPage parameters

A likely scenario you'll encounter is needing to search through a paginated API. This can be done by referencing the same `context` object as before. Within this object, we can utilize the `page` and `hasNextPage` properties. The page property is the current page number, and the hasNextPage property is a function to be called when there are more pages to load:

### Example: Autocomplete

#### autocomplete-pagination.vue

```vue
<script setup>
// Search movie receives FormKit's context object
// which we are destructuring to get the search value,
// the page, and the hasNextPage parameters.
async function searchMovies({ search, page, hasNextPage }) {
  if (!search) return []
  const res = await fetch(
    `https://api.themoviedb.org/3/search/movie?query=${
      search || ''
    }&api_key=f48bcc9ed9cbce41f6c28ea181b67e14&language=en-US&page=${page}&include_adult=false`
  )
  if (res.ok) {
    const data = await res.json()
    if (page !== data.total_pages) hasNextPage()
    return data.results.map((result) => {
      return {
        label: result.title,
        value: result.id,
      }
    })
  }
  return []
}
</script>

<template>
  <FormKit
    name="movie"
    type="autocomplete"
    label="Search for your favorite movie"
    placeholder="Example: Lord of the Rings"
    :options="searchMovies"
    popover
  />
</template>

<style scoped>
:deep(.formkit-option) {
  display: flex;
  align-items: center;
}

:deep(.formkit-option img) {
  width: 20%;
  margin-right: 20px;
}

:deep(.option-overview) {
  font-size: 12px;
}
</style>
```

### Option loader

#### Rehydrating values

FormKit's autocomplete input also provides an `optionLoader` prop that allows you to rehydrate values that are not in the options list. In this example, we'll provide the autocomplete an initial value (a movie ID), and assign the optionLoader to a function that will make a request to the API to get the movie:

### Example: Autocomplete

#### autocomplete-pagination-option-loader.vue

```vue
<script setup>
// Search movie receives FormKit's context object
// which we are destructuring to get the search value,
// the page, and the hasNextPage parameters.
async function searchMovies({ search, page, hasNextPage }) {
  if (!search) return []
  const res = await fetch(
    `https://api.themoviedb.org/3/search/movie?query=${
      search || ''
    }&api_key=f48bcc9ed9cbce41f6c28ea181b67e14&language=en-US&page=${page}&include_adult=false`
  )
  if (res.ok) {
    const data = await res.json()
    if (page !== data.total_pages) hasNextPage()
    return data.results.map((result) => {
      return {
        label: result.title,
        value: result.id,
      }
    })
  }
  return []
}

// The function assigned to the `option-loader` prop will be called with the
// value of the option as the first argument (in this case, the movie ID), and
// the cached option as the second argument (if it exists).
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
</script>

<template>
  <FormKit type="form" #default="{ value }" :actions="false">
    <FormKit
      name="movie"
      type="autocomplete"
      label="Search for your favorite movie"
      placeholder="Example: Harry Potter"
      :options="searchMovies"
      :value="597"
      :option-loader="loadMovie"
      popover
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
e
<style scoped>
:deep(.formkit-option) {
  display: flex;
  align-items: center;
}

:deep(.formkit-option img) {
  width: 20%;
  margin-right: 20px;
}

:deep(.option-overview) {
  font-size: 12px;
}
</style>
```

Notice in the example above that the optionLoader function is passed two arguments: the `value` of the selected option (in this case, the movie ID) and the `cachedOption`. The cachedOption prop is used for preventing unnecessary lookups. If the cachedOption is not `null` it means that the selected option has already been loaded, and you can return the cachedOption directly.

### Loading Style

Instead of requiring your users to click the *Load more* button to load additional options, you can set the `loadOnScroll` prop to true, which will paginate options as you scroll to the bottom of the options list.

### Load on created

If you would rather load options when the autocomplete is created, you can set the `load-on-created` prop to true, and our function, `loadCurrentlyPopularMovies` will be called without the user needing to expand the listbox:

### Example: Autocomplete

#### autocomplete-load-on-created.vue

```vue
<script setup>
// Search movie receives FormKit's context object
// which we are destructuring to get the search value.
async function searchMovies({ search }) {
  await new Promise((resolve) => setTimeout(resolve, 1000))
  if (!search)
    // With no search value, lets just return a list of common movies.
    return [
      { label: 'Saving Private Ryan', value: 857 },
      { label: 'Everything Everywhere All at Once', value: 545611 },
      { label: 'Gone with the Wind', value: 770 },
    ]
  const res = await fetch(
    `https://api.themoviedb.org/3/search/movie?query=${
      search || ''
    }&api_key=f48bcc9ed9cbce41f6c28ea181b67e14&language=en-US&page=1&include_adult=false`
  )
  if (res.ok) {
    const data = await res.json()
    // Iterating over results to set the required
    // `label` and `value` keys.
    return data.results.map((result) => {
      return {
        label: result.title,
        value: result.id,
      }
    })
  }
  // If the request fails, we return an empty array.
  return []
}
</script>

<template>
  <FormKit type="form" #default="{ value }" :actions="false">
    <!--Setting the `options` prop to async function `loadHorrorMovies`-->
    <FormKit
      name="movie"
      type="autocomplete"
      label="Search for your favorite movie"
      placeholder="Example: Shawshank Redemption"
      :options="searchMovies"
      load-on-created
      popover
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>

<style scoped>
:deep(.formkit-option) {
  display: flex;
  align-items: center;
}

:deep(.formkit-option img) {
  width: 20%;
  margin-right: 20px;
}

:deep(.option-overview) {
  font-size: 12px;
}
</style>
```

## Option appearance

### Option slot

The autocomplete input allows you to customize the look and feel of each option by using the option slot. In this example, we are using the option slot to display each option's asset, logo, and name:

### Example: Autocomplete

#### autocomplete-option-slot.vue

```vue
<script setup>
import carBrands from './_examples___data__car-brands.js'
</script>

<template>
  <FormKit
    type="autocomplete"
    name="autocomplete"
    label="Search for and select a car brand"
    placeholder="Example: Toyota"
    :options="carBrands"
    selection-appearance="option"
    popover
  >
    <!--OPTION SLOT-->
    <template #option="{ option, classes }">
      <div :class="classes.option">
        <img :src="option.logo" :alt="option.label + ' logo'" />
        <span>
          {{ option.label }}
        </span>
      </div>
    </template>
    <!--/OPTION SLOT-->
  </FormKit>
</template>

<style scoped>
.formkit-option {
  display: flex;
  align-items: center;
}

.formkit-option img {
  width: 20px;
  height: 20px;
  margin-right: 10px;
}
</style>
```

## Selection appearance

The autocomplete input allows you to customize the look and feel of the selected option.

### Selection appearance prop

The autocomplete input allows you to customize the look and feel of the selected option by using the `selection-appearance` prop. For either the single-select or multi-select
autocomplete, you can set the selection-appearance prop to `text-input` (default) or `option`:

### Example: Autocomplete

#### autocomplete-selection-appearance.vue

```vue
<script setup>
import countries from './_examples___data__countries.js'
</script>

<template>
  <FormKit
    type="autocomplete"
    label="Single-select text input"
    placheolder="Pick a country"
    :options="countries"
    popover
    value="FR"
  />
  <FormKit
    type="autocomplete"
    label="Single-select option"
    placheolder="Pick a country"
    :options="countries"
    popover
    selection-appearance="option"
    value="FR"
  />
  <FormKit
    type="autocomplete"
    label="Multiple text input"
    placheolder="Pick a country"
    :options="countries"
    popover
    multiple
    :value="['FR', 'GR', 'ES']"
  />
  <FormKit
    type="autocomplete"
    label="Multiple option"
    placheolder="Pick a country"
    :options="countries"
    multiple
    selection-appearance="option"
    :value="['FR', 'GR', 'ES']"
  />
</template>
```

### Selection slot

If you only want to customize the display of the selected option, set the selection appearance to `option`.

### Example: Autocomplete

#### autocomplete-slot-selection.vue

```vue
<FormKit
    type="autocomplete"
    name="autocomplete"
    label="Search and select a car brand"
    placeholder="Example: Toyota"
    :options="carBrands"
    popover
    selection-appearance="option"
    value="audi"
  >
    <!--SELECTION SLOT-->
    <template #selection="{ option, classes }">
      <div :class="classes.selection">
        <div :class="`${classes.option} flex items-center`">
          <img
            :src="option.logo"
            :alt="option.label + ' logo'"
            class="w-10 h-10 p-2"
          />
          <span>
            {{ option.label }}
          </span>
        </div>
      </div>
    </template>
    <!--/SELECTION SLOT-->
  </FormKit>
  <FormKit
    type="autocomplete"
    name="autocomplete"
    label="Search and select a car brand"
    placeholder="Example: Toyota"
    :options="carBrands"
    selection-appearance="option"
    multiple
    :value="['toyota', 'honda']"
  >
    <!--SELECTION SLOT-->
    <template #selection="{ option, classes }">
      <div :class="`${classes.selection} !p-0`">
        <div :class="`${classes.option} flex items-center`">
          <img
            :src="option.logo"
            :alt="option.label + ' logo'"
            class="w-10 h-10 p-2"
          />
          <span>
            {{ option.label }}
          </span>
        </div>
      </div>
    </template>
    <!--/SELECTION SLOT-->
  </FormKit>
```

## Behavioral props

### Empty message

The autocomplete input, by default, will not expand the listbox when no search results are found while filtering. You can change this behavior by assigning the `empty-message` prop a message to display when no results are found:

### Example: Autocomplete

#### autocomplete-empty-message.vue

```vue
<FormKit
    type="autocomplete"
    name="autocomplete"
    label="Search for a country"
    :options="countries"
    placeholder="Example: United States"
    empty-message="No countries found"
    popover
  />
```

### Close on select

If you would like the listbox to remain expanded after selecting a value, you can set `close-on-select` to `false`.

### Example: Autocomplete

#### autocomplete-close-on-select.vue

```vue
<FormKit
    type="autocomplete"
    name="autocomplete"
    label="Search for a country"
    :options="countries"
    multiple
    :close-on-select="false"
    placeholder="Example: United States"
    popover
  />
```

### Reload on commit

If you want the options to be reloaded when the user commits a selection, use the `reload-on-commit` prop:

### Example: Autocomplete

#### autocomplete-reload-on-commit.vue

```vue
<FormKit
    type="autocomplete"
    name="country"
    label="Search for a country"
    placeholder="Example: United States"
    :options="countries"
    :reload-on-commit="true"
    :close-on-select="false"
    multiple
    popover
  />
```

### Open on click

To enable opening the autocomplete's listbox on click of its search input, set the `open-on-click` prop to `true`:

### Example: Autocomplete

#### autocomplete-open-on-click.vue

```vue
<FormKit
    type="autocomplete"
    name="country"
    label="Search for a country"
    placeholder="Example: United States"
    :options="countries"
    open-on-click
    popover
  />
```

### Open on focus

If you would like to open the autocomplete's listbox anytime the input is clicked, set the `open-on-focus` prop to `true`:

### Example: Autocomplete

#### autocomplete-open-on-focus.vue

```vue
<FormKit type="button" @click="focusAutocomplete">
    Click me to focus autocomplete
  </FormKit>
  <FormKit
    id="autocomplete"
    type="autocomplete"
    name="framework"
    label="Choose a frontend framework"
    placeholder="Example placeholder"
    :options="frameworks"
    open-on-focus
    popover
  />
```

> **Warning:** If open-on-focus is used, open-on-click will implicitly be set.

### Clear search on open

For single-select autocompletes only, if you would like to clear the search input when the listbox is opened, set the `clear-search-on-open`:

### Example: Autocomplete

#### autocomplete-clear-search-on-open.vue

```vue
<script setup>
import countries from './_examples___data__countries.js'
</script>

<template>
  <FormKit type="form" #default="{ value }" :actions="false">
    <FormKit
      type="autocomplete"
      name="country"
      label="Search for a country"
      placeholder="Example: United States"
      :options="countries"
      clear-search-on-open
      value="US"
      popover
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

### Selection removable

For a single-select autocomplete, you can set the `selection-removable` prop. When set to `true`, a remove button will be displayed next to the selected option. This prop is by default set to `true` for autocompletes with selection appearance of `option`.

> **Warning:** The selection-removable prop cannot be used for multi-selects.

### Example: Autocomplete

#### autocomplete-selection-removable.vue

```vue
<script setup>
import countries from './_examples___data__countries.js'
</script>

<template>
  <FormKit type="form" #default="{ value }" :actions="false">
    <FormKit
      type="autocomplete"
      name="country"
      label="Search for a country"
      placeholder="Example: United States"
      :options="countries"
      value="US"
      popover
      selection-removable
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

### Open on remove

If you want the listbox to expand when an selection is removed, use the `open-on-remove` prop:

### Example: Autocomplete

#### autocomplete-open-on-remove.vue

```vue
<script setup>
import countries from './_examples___data__countries.js'
</script>

<template>
  <FormKit type="form" #default="{ value }" :actions="false">
    <FormKit
      type="autocomplete"
      name="country"
      label="Search for a country"
      placeholder="Example: United States"
      :options="countries"
      open-on-remove
      selection-removable
      popover
      value="US"
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

### Max

If you would like to limit the number of options that can be selected, you can use the `max` prop:

### Example: Autocomplete

#### autocomplete-max.vue

```vue
<script setup>
import countries from './_examples___data__countries.js'
</script>

<template>
  <FormKit
    type="autocomplete"
    label="Autocomplete (option appearance) with max prop set to 2"
    :options="countries"
    selection-appearance="option"
    multiple
    popover
    max="2"
  />
  <FormKit
    type="autocomplete"
    label="Autocomplete (text-input appearance) with max prop set to 2"
    :options="countries"
    selection-appearance="text-input"
    multiple
    popover
    max="2"
  />
</template>
```

## Full example

Now let's combine what we've learned so far by leveraging the `option` slot for custom markup, and setting the `options` prop to a function that will return pages of movies from an API:

### Example: Autocomplete

#### autocomplete-full.vue

```vue
<script setup>
import topMovies from './_examples___data__top-movies.js'
// Search movie receives FormKit's context object
// which we are destructuring to get the search value,
// the page, and the hasNextPage parameters.
async function searchMovies({ search, page, hasNextPage }) {
  if (!search) {
    // When there is no search value we return a static list of top movies
    return topMovies
  }
  const res = await fetch(
    `https://api.themoviedb.org/3/search/movie?query=${
      search || ''
    }&api_key=f48bcc9ed9cbce41f6c28ea181b67e14&language=en-US&page=${page}&include_adult=false`
  )
  if (res.ok) {
    const data = await res.json()
    if (page !== data.total_pages) hasNextPage()
    return data.results.map((result) => {
      return {
        label: result.title,
        value: result.id,
        poster_path: result.poster_path,
        overview: result.overview,
      }
    })
  }
  return []
}
</script>

<template>
  <FormKit type="form" #default="{ value }" :actions="false">
    <FormKit
      name="movie"
      type="autocomplete"
      label="Search for your favorite movie"
      placeholder="Example placeholder"
      :options="searchMovies"
      selection-appearance="option"
      multiple
      popover
      remove-selection-class="p-2 pl-0"
    >
      <template #option="{ option }">
        <div class="flex items-center justify-between">
          <div class="image-container w-1/4 mr-2">
            <img
              :src="`https://image.tmdb.org/t/p/w500${option.poster_path}`"
              alt="optionAvatar"
              class="w-full"
            />
          </div>
          <div class="text-container w-full">
            <div class="text-base leading-none font-bold">
              {{ option.label }}
            </div>
            <p class="option-overview text-xs">
              {{ option.overview }}
            </p>
          </div>
        </div>
      </template>
    </FormKit>
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `debounce` | `number` | `200` | Number of milliseconds to debounce calls to an options function. |
| `options` | `any` | `[]` | The list of options the user can select from. |
| `load-on-scroll` | `boolean` | `false` | When set to true, the autocomplete will try loading more options based on the end-user`s scroll position |
| `selection-appearance` | `string` | `text-input` | Changes the way the option label is display. |
| `multiple` | `boolean` | `false` | Allows for multiple selections. |
| `open-on-click` | `boolean` | `false` | The autocomplete is expanded upon focus of the input, as opposed to waiting to expand until a search value is entered. |
| `filter` | `function` | `null` | Used to apply your own custom filter function for static options. |
| `option-loader` | `function` | `null` | Used for hydrating initial value, or performing an additional request to load more information of a selected option. |
| `empty-message` | `string` | `undefined` | Renders a message when there are no options to display. |
| `max` | `number` | `undefined` | Limits the number of options that can be selected. |
| `open-on-remove` | `boolean` | `false` | When the selection-removable prop is set to true, the autocomplete will not open after the selected value is removed. You can change this behavior by setting the open-on-remove prop to true. |
| `open-on-focus` | `boolean` | `false` |  |
| `options-appearance` | `string` | `undefined` | For multi-select autocompletes, this prop allows you to customize the look and feel of the selected options. Possible values are default (the default) or checkbox. |
| `always-load-on-open` | `boolean` | `true` | Determines whether the autocomplete should always load its options when opened or whether it should reference the options that were previously found when opening. |
| `` | `boolean` | `false` | When set to true, the autocomplete will load the options when the node is created. |
| `` | `boolean` | `false` | When set to true, the search input will be cleared when the listbox is opened. |
| `` | `number | string` | `undefined` | If you would like to limit the number of options that can be selected, you can use the max prop (applies only to multi-select). |
| `popover` | `boolean` | `false` | Renders the input's listbox using the browser Popover API. |

## Sections & slot data

You can target specific sections of an input using the `section-key` attribute or slots. Each section can be styled or customized independently.

The autocomplete's structure changes depending on a few different scenarios:

- Whether `selection-appearance` has been set to `text-input` (the default) or `option`.
- Whether multiple selections are enabled via the `multiple` attribute.

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

Additional slot data specific to the `autocomplete` input:

| Property | Type | Description |
|----------|------|-------------|
| `options` | `FormKitOptionsList` | An array of option objects available for selection. |
| `isOpen` | `boolean` | Whether the dropdown listbox is currently open. |
| `selection` | `FormKitOptionsProp | FormKitOptionsProp[]` | The currently selected option(s). |
| `selectionAppearance` | `any` | How selected values are displayed (as text or chips). |
| `multiple` | `boolean` | Whether multiple options can be selected. |
| `fns` | `Record<string, (...args: any[]) => any>` | Utility functions for the autocomplete input. |
| `fns.isSelected` | `(option: FormKitOptionsProp) => boolean` | Returns true if the given option is currently selected. |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the autocomplete input. |
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
| `option` | `option`, `listitem`, `selection`, `selectionWrapper` | `FormKitOptionsProp` | The current option object when iterating. Contains value, label, and attrs. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```

#### Selection appearance text-input
When selection-appearance="text-input" (the default), the selected value(s) appear as comma-separated text in the input field.
- outer
  └─ wrapper
    └─ label
    └─ inner
      └─ prefixIcon
      └─ prefix
      └─ input
      └─ loaderIcon
      └─ listboxButton
        └─ selectIcon
      └─ listbox
      └─ suffix
      └─ suffixIcon
  └─ help
  └─ messages
    └─ message

#### Selection appearance option
When selection-appearance="option", the selected value(s) render as styled chips. For single-select, the selections section appears inside inner. For multi-select, it appears inside wrapper below inner.
- outer
  └─ wrapper
    └─ label
    └─ inner
      └─ prefixIcon
      └─ prefix
      └─ input
      └─ selections
        └─ selectionWrapper
          └─ selection
            └─ option
              └─ optionLoading
          └─ removeSelection
            └─ closeIcon
      └─ loaderIcon
      └─ listboxButton
        └─ selectIcon
      └─ listbox
      └─ suffix
      └─ suffixIcon
  └─ help
  └─ messages
    └─ message

#### Listbox (dropdown) structure
The listbox section contains the dropdown options. It is rendered inside a dropdownWrapper that handles positioning.
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
| `input` | `<select>` | The native HTML select element. |
| `loaderIcon` | `<span>` | Loading spinner icon. |
| `listboxButton` | `<div>` | The listboxButton section. |
| `selectIcon` | `<span>` | An icon displayed beside the select (typically a dropdown caret). |
| `listbox` | `<ul>` | The dropdown list containing available options. |
| `suffix` | (none) | Has no output by default, but allows content directly after an input element. |
| `suffixIcon` | `<span>` | An element for outputting an icon after the suffix section. |
| `help` | `<div>` | The element containing help text. |
| `messages` | `<ul>` | A wrapper around all the messages. |
| `message` | `<li>` | The element (or many elements) containing a message — most often validation and error messages. |
| `selections` | `<div>` | The selections section. |
| `selectionWrapper` | `<div>` | Wraps each individual selection. Iterates over selected options. |
| `selection` | `<div>` | Contains the display of a single selected option. |
| `option` | `<div>` | Wrapper for each individual toggle button option. |
| `optionLoading` | `<span>` | Loading indicator shown while an option is being loaded. |
| `removeSelection` | `<button>` | Button to clear the selected date (when clearable). |
| `closeIcon` | `<span>` | Icon for the search clear button. |
| `dropdownWrapper` | `<div>` | Wrapper element for the listbox, handles positioning (popover). |
| `emptyMessage` | `<li>` | Shown when there are no options to display. |
| `emptyMessageInner` | `<span>` | Inner span containing the empty message text. |
| `listitem` | `<li>` | A single option item in the listbox. |
| `selectedIcon` | `<span>` | Checkmark shown next to selected items. |
| `loadMore` | `<li>` | Element shown at the bottom of the list for loading more options. |
| `loadMoreInner` | `<span>` | Inner wrapper for the load more content. |

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
| `input` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `input` | `role` | `combobox` | Indicates to assistive technologies that this element functions as a combobox. |
| `input` | `readonly` | `-` | Restrict user edits, ensuring data integrity and a controlled, informative user experience. |
| `input` | `aria-autocomplete` | `list` | Guides input suggestions, presenting a collection of values that could complete the user's input. |
| `input` | `aria-activedescendant` | `-` | Manage focus to the current active descendent element. |
| `input` | `aria-expanded` | `-` | Conveys the expandable state when the element is in focus. |
| `input` | `aria-controls` | `-` | Associates the listbox element, with this element. |
| `listboxButton` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `listboxButton` | `role` | `button` | Indicates to assistive technologies that this element functions as a button. |
| `listboxButton` | `aria-haspopup` | `true` | Signals that an element triggers a pop-up or menu |
| `listboxButton` | `aria-expanded` | `-` | Conveys the expandable state when the element is in focus. |
| `listboxButton` | `aria-controls` | `-` | Associates the listbox element, with this element. |
| `listboxButton` | `aria-disabled` | `-` | Communicates the disabled state when the input is disabled. |
| `selectionWrapper` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when disabled and 0 when enabled. |
| `selections` | `aria-live` | `polite` | Communicates dynamic content changes when selections are on the screen. |
| `removeSelection` | `tabindex` | `-1` | Removes the prioritization of keyboard focus on this element. |
| `removeSelection` | `aria-controls` | `-` | Associates the input element, with this element. |

### Keyboard Interactions

| Key | Description |
|-----|-------------|
| `enter` | Opens the listbox when the input is focused. Selects an item when a list item is focused |
| `space` | Opens the listbox when the input is focused. Selects an item when a list item is focused |
| `esc` | Closes the listbox when the input is focused. |
| `up` | Navigates to previous list item in list box. Closes listbox if most-previous item is selected |
| `down` | Opens the listbox when input is focused. Navigates to next list item in list box. |
