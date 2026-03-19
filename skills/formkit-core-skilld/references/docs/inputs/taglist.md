# Taglist Input

A Pro input that allows users to search and select from a customizable options list. Supports single and multi-value selections.

The `taglist` input allows users to search through a list of options and apply any number of tags. Users can also drag and drop tags to re-order:

The `options` prop can accept three different formats of values:

- An array of objects with `value` and `label` keys (see example above)
- An array of strings `['A', 'B', 'C']`
- An object literal with key-value pairs `{ a: 'A', b: 'B', c: 'C' }`
- A function that returns any of the above

> **Warning:** If you assign options as an empty array, the input will be rendered in a disabled state.

## Basic example

The `taglist` input allows users to search through a list of options and apply any number of tags. Users can also drag and drop tags to re-order:

### Example: Taglist

#### taglist-base.vue

```vue
<script setup>
import carBrands from './_examples___data__car-brands.js'
</script>

<template>
  <FormKit type="form" #default="{ value }" :actions="false">
    <FormKit
      type="taglist"
      name="car_brands"
      label="Search for your favorite car brands"
      popover
      :options="carBrands"
      :value="['honda', 'toyota']"
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

## Filtering

The taglist input will filter options with its own internal search function. You can replace this search function by providing the `filter` prop a function of your own. Your function will receive two arguments, the `option` being iterated over and the current `search` value:

### Example: Taglist

#### taglist-filter.vue

```vue
<script setup>
import countries from './_examples___data__countries.js'
</script>

<template>
  <FormKit type="form" #default="{ value }" :actions="false">
    <FormKit
      type="taglist"
      name="taglist"
      label="Search for a country"
      popover
      :options="countries"
      :value="['AX', 'AL']"
      :filter="
        (option, search) =>
          option.label.toLowerCase().startsWith(search.toLowerCase())
      "
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

## Allow new values

The taglist input, unlike the dropdown or autocomplete inputs, allows you to enter an arbitrary value (a value not in the list of options). This is useful for creating new tags on the fly. To enable this feature, set the `allow-new-values` prop to `true`.

### Example: Taglist

#### taglist-allow-new-values.vue

```vue
<script setup>
const flavors = ['Chocolate', 'Vanilla', 'Strawberry'];
</script>

<template>
  <FormKit
    type="form"
    #default="{ value }"
    :actions="false"
  >
    <FormKit
      type="taglist"
      name="flavors"
      label="Select or add a flavor"
      popover
      :options="flavors"
      :value="['Chocolate', 'Vanilla']"
      :allow-new-values="true"
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

## Dynamic options

Instead of passing a static list to the `options` prop, you can assign it to a function. Doing so is useful when you need to load options from an API or another source.

### Search parameter

In this example, we'll assign the `options` prop the `searchMovies` function. By doing so, `searchMovies` will receive the `context` object as an argument. Within this `context` object is the `search` property, which is the current search value. To perform our search, we'll use the `search` value as the query parameter for our API request:

### Example: Taglist

#### taglist-single-request.vue

```vue
<script setup>
// Search movie receives FormKit's context object
// which we are destructuring to get the search value.
async function searchMovies({ search }) {
  if (!search) return [];
  const res = await fetch(`https://api.themoviedb.org/3/search/movie?query=${search || ''}&api_key=f48bcc9ed9cbce41f6c28ea181b67e14&language=en-US&page=1&include_adult=false`)
  if (res.ok) {
    const data = await res.json()
    // Iterating over results to set the required
    // `label` and `value` keys.
    return data.results.map((result) => {
      return {
        label: result.title,
        value: result.id
      }
    })
  }
  // If the request fails, we return an empty array.
  return []
}
</script>

<template>
  <FormKit
    type="form"
    #default="{ value }"
    :actions="false"
  >
    <!--Setting the `options` prop to async function `loadHorrorMovies`-->
    <FormKit
      name="movie"
      type="taglist"
      label="Search for your favorite movie"
      placeholder="Example: Shawshank Redemption"
      popovers
      :options="searchMovies"
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

### Page and hasNextPage parameters

A likely scenario you'll encounter is needing to search through a paginated API. This can be done by referencing the same `context` object as before. Within this object, we can utilize the `page` and `hasNextPage` properties. The `page` property is the current page number, and the `hasNextPage` property is a function to be called when there are more pages to load:

### Example: Taglist

#### taglist-pagination.vue

```vue
<script setup>
// Search movie receives FormKit's context object
// which we are destructuring to get the search value,
// the page, and the hasNextPage parameters.
async function searchMovies({ search, page, hasNextPage }) {
  if (!search) return [];
  const res = await fetch(`https://api.themoviedb.org/3/search/movie?query=${search || ''}&api_key=f48bcc9ed9cbce41f6c28ea181b67e14&language=en-US&page=${page}&include_adult=false`)
  if (res.ok) {
    const data = await res.json()
		if (page !== data.total_pages) hasNextPage()
    return data.results.map((result) => {
      return {
        label: result.title,
        value: result.id
      }
    })
  }
  return []
}
</script>

<template>
  <FormKit
    type="form"
    #default="{ value }"
    :actions="false"
  >
    <FormKit
      name="movie"
      type="taglist"
      label="Search for your favorite movie"
      placeholder="Example: Lord of the Rings"
      popover
      :options="searchMovies"
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

### Loading Style

Instead of requiring your users to click the *Load more* button to load additional options, you can set the `loadOnScroll` prop to true, which will paginate options as you scroll to the bottom of the options list.

### Option loader

#### Rehydrating values

FormKit's taglist input also provides an `optionLoader` prop that allows you to rehydrate values that are not in the options list. In this example, we'll provide the taglist an initial value (a movie ID), and assign the optionLoader to a function that will make a request to the API to get the movie:

### Example: Taglist

#### taglist-pagination-option-loader.vue

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
      type="taglist"
      label="Search for your favorite movie"
      placeholder="Example: Harry Potter"
      popover
      :options="searchMovies"
      :value="[597]"
      :option-loader="loadMovie"
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

Notice in the example above that the optionLoader function is passed two arguments: the `value` of the selected option (in this case, the movie ID) and the `cachedOption`. The cachedOption is used for preventing unnecessary lookups. If the cachedOption is not `null` it means that the selected option has already been loaded, and you can return the cachedOption directly.

### Loading Style

Instead of requiring your users to click the *Load more* button to load additional options, you can set the `loadOnScroll` prop to true, which will paginate options as you scroll to the bottom of the options list.

### Load on created

If you would rather load options when the taglist is created, you can set the `load-on-created` prop to true, and our function, `loadCurrentlyPopularMovies` will be called without the user needing to expand the listbox:

### Example: Taglist

#### taglist-load-on-created.vue

```vue
<script setup>
// Search movie receives FormKit's context object
// which we are destructuring to get the search value.
async function searchMovies({ search }) {
  await new Promise((resolve) => setTimeout(resolve, 1000))
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
    type="taglist"
    label="Search for your favorite movie"
    placeholder="Example: Shawshank Redemption"
    :options="searchMovies"
    popover
    load-on-created
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

## Tag appearance

Just like the [taglist input](/inputs/taglist) or [Autocomplete input](/inputs/autocomplete), the taglist input allows you to utilize slots to customize the look and feel of the options list and the selected option by leveraging the renderless component pattern.

In this example, we are going to use the `tag` slot to customize the look of the tags:

### Example: Taglist

#### taglist-slots.vue

```vue
<script setup>
import carBrands from './_examples___data__car-brands.js'
</script>

<template>
  <FormKit type="form" #default="{ value }" :actions="false">
    <FormKit
      type="taglist"
      name="taglist"
      label="Search and select a car brand"
      placeholder="Example: Toyota"
      :options="carBrands"
      popover
      selection-appearance="option"
      :value="['audi', 'bmw']"
      multiple
    >
      <!--TAG SLOT-->
      <template #tag="{ handlers, option, classes }">
        <div :class="classes.tag">
          <img :src="option.logo" class="w-5 mr-2 bg-white" />
          <span :class="classes.tagLabel">
            {{ option.label }}
          </span>
          <button
            @click.prevent="handlers.removeSelection(option)()"
            tabindex="-1"
            type="button"
            aria-controls="input_1"
            class="formkit-remove-selection"
          >
            <span class="formkit-close-icon formkit-icon"
              ><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 12 16">
                <path
                  d="M10,12.5c-.13,0-.26-.05-.35-.15L1.65,4.35c-.2-.2-.2-.51,0-.71,.2-.2,.51-.2,.71,0L10.35,11.65c.2,.2,.2,.51,0,.71-.1,.1-.23,.15-.35,.15Z"
                  fill="currentColor"
                ></path>
                <path
                  d="M2,12.5c-.13,0-.26-.05-.35-.15-.2-.2-.2-.51,0-.71L9.65,3.65c.2-.2,.51-.2,.71,0,.2,.2,.2,.51,0,.71L2.35,12.35c-.1,.1-.23,.15-.35,.15Z"
                  fill="currentColor"
                ></path></svg
            ></span>
          </button>
        </div>
      </template>
      <!--/TAG SLOT-->
    </FormKit>
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

## Behavioral props

### Empty message

The taglist input, by default, will not expand the listbox when no search results are found while filtering. You can change this behavior by assigning the `empty-message` prop a message to display when no results are found:

### Example: taglist

#### taglist-empty-message.vue

```vue
<script setup>
import countries from './_examples___data__countries.js'
</script>

<template>
  <FormKit type="form" #default="{ value }" :actions="false">
    <FormKit
      type="taglist"
      name="taglist"
      label="Search for a country"
      :options="countries"
      popover
      placeholder="Example: United States"
      empty-message="No countries found"
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

### Max

The `max` prop allows you to limit the number of options that can be selected. When the `max` limit is reached, the taglist input will disable the listbox:

### Example: Taglist

#### taglist-max.vue

```vue
<script setup>
import countries from './_examples___data__countries.js'
</script>

<template>
  <FormKit
    type="form"
    #default="{ value }"
    :actions="false"
  >
  <FormKit
    type="taglist"
    label="Taglist with max prop set to 2"
    :options="countries"
    popover
    max="2"
  />
  </FormKit>
</template>
```

### Close on select

If you would like the taglist's listbox to remain open in between selections, set the `close-on-select` prop to `false`:

### Example: Taglist

#### taglist-close-on-select.vue

```vue
<script setup>
import countries from './_examples___data__countries.js'
</script>

<template>
  <FormKit type="form" #default="{ value }" :actions="false">
    <FormKit
      type="taglist"
      name="taglist"
      label="Search for a country"
      popover
      :options="countries"
      :close-on-select="false"
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

### Reload on commit

If you want the options to be reloaded (with static options, this would filter the options with the value of empty string, and with dynamic options, this would make a request to the options loader with the value of empty string) when the user commits a selection, use the `reload-on-commit` prop:

### Example: Autocomplete

#### taglist-reload-on-commit.vue

```vue
<script setup>
import countries from './_examples___data__countries.js'
</script>

<template>
  <FormKit
    type="taglist"
    name="country"
    label="Search for a country"
    placeholder="Example: United States"
    popover
    :options="countries"
    :reload-on-commit="true"
    :close-on-select="false"
  />
</template>
```

### Open on click

To enable opening the taglist's listbox on click of its search input, set the `open-on-click` prop to `true`:

### Example: taglist

#### taglist-open-on-click.vue

```vue
<script setup>
import countries from './_examples___data__countries.js'
</script>

<template>
  <FormKit
    type="taglist"
    name="country"
    label="Search for a country"
    placeholder="Example: United States"
    :options="countries"
    popover
    open-on-click
  />
</template>
```

### Open on focus

If you would like to open the taglist's listbox anytime its search input is focused, set the `open-on-focus` prop to `true`:

### Example: taglist

#### taglist-open-on-focus.vue

```vue
<script setup>
const frameworks = [
  { label: 'React', value: 'react' },
  { label: 'Vue', value: 'vue' },
  { label: 'Angular', value: 'angular' },
  { label: 'Svelte', value: 'svelte' },
]

function focusTaglist() {
  document.querySelector('#taglist').focus()
}
</script>

<template>
  <FormKit type="form" #default="{ value }" :actions="false">
    <FormKit type="button" @click="focusTaglist"
      >Click me to focus taglist</FormKit
    >
    <FormKit
      id="taglist"
      type="taglist"
      name="framework"
      label="Choose a frontend framework"
      placeholder="Example placeholder"
      :options="frameworks"
      value="vue"
      popover
      open-on-focus
    />
    <pre wrap>{{ value }}</pre>
  </FormKit>
</template>
```

> **Warning:** Open on focus encompasses open on click.

### Open on remove

If you want the listbox to expand when an selection is removed, use the `open-on-remove` prop:

### Example: Autocomplete

#### taglist-open-on-remove.vue

```vue
<script setup>
import countries from './_examples___data__countries.js'
</script>

<template>
	<FormKit
		type="taglist"
		name="country"
		label="Search for a country"
		placeholder="Example: United States"
		:options="countries"
		open-on-remove
		popover
		:value="['US']"
	/>
	<pre wrap>{{ value }}</pre>
</template>
```

## Full example

Now let's combine what we've learned so far by leveraging the `tag` slot for custom markup, and setting the `options` prop to a function that will return pages of movies from an API:

### Example: Taglist

#### taglist-full-example.vue

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
      type="taglist"
      label="Search for your favorite movie"
      placeholder="Example placeholder"
      :options="searchMovies"
      selection-appearance="option"
      multiple
      popover
    >
      <!--HERE WE ARE DEFINING OUR TAG SLOT-->
      <template #tag="{ handlers, option, classes }">
        <div :class="classes.tag">
          <img
            class="w-5 mr-2"
            :src="`https://image.tmdb.org/t/p/w500${option.poster_path}`"
            alt="optionAvatar"
          />
          <span :class="classes.tagLabel">
            {{ option.label }}
          </span>
          <button
            @click.prevent="handlers.removeSelection(option)()"
            tabindex="-1"
            type="button"
            aria-controls="input_1"
            :class="classes.removeSelection"
          >
            <span :class="`${classes.closeIcon} ${classes.Icon}`"
              ><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 12 16">
                <path
                  d="M10,12.5c-.13,0-.26-.05-.35-.15L1.65,4.35c-.2-.2-.2-.51,0-.71,.2-.2,.51-.2,.71,0L10.35,11.65c.2,.2,.2,.51,0,.71-.1,.1-.23,.15-.35,.15Z"
                  fill="currentColor"
                ></path>
                <path
                  d="M2,12.5c-.13,0-.26-.05-.35-.15-.2-.2-.2-.51,0-.71L9.65,3.65c.2-.2,.51-.2,.71,0,.2,.2,.2,.51,0,.71L2.35,12.35c-.1,.1-.23,.15-.35,.15Z"
                  fill="currentColor"
                ></path></svg
            ></span>
          </button>
        </div>
      </template>
      <!---->
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
| `load-on-scroll` | `boolean` | `false` | When set to true, the taglist will try loading more options based on the end-user`s scroll position |
| `open-on-click` | `boolean` | `false` | The autocomplete is expanded upon focus of the input, as opposed to waiting to expand until a search value is entered. |
| `filter` | `function` | `null` | Used to apply your own custom filter function for static options. |
| `option-loader` | `function` | `null` | Used for hydrating initial value, or performing an additional request to load more information of a selected option. |
| `allow-new-values` | `boolean` | `false` | Allows end-user to enter a new value that does not exist within the options list. |
| `disable-drag-and-drop` | `boolean` | `true` | Disabled end-user from sorting tags by dragging and dropping. |
| `empty-message` | `string` | `undefined` | Renders a message when there are no options to display. |
| `max` | `number` | `undefined` | Limits the number of options that can be selected. |
| `close-on-select` | `boolean` | `true` | Closes the listbox when an option is selected. |
| `open-on-remove` | `boolean` | `false` | When the selection-removable prop is set to true, the taglist will not open after the selected value is removed. You can change this behavior by setting the open-on-remove prop to true. |
| `open-on-focus` | `boolean` | `false` |  |
| `options-appearance` | `string` | `undefined` | For multi-select taglists, this prop allows you to customize the look and feel of the selected options. Possible values are default (the default) or checkbox. |
| `always-load-on-open` | `boolean` | `true` | Determines whether the taglist should always load its options when opened or whether it should reference the options that were previously found when opening. |
| `` | `boolean` | `false` | When set to true, the taglist will load the options when the node is created. |
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

Additional slot data specific to the `taglist` input:

| Property | Type | Description |
|----------|------|-------------|
| `options` | `FormKitOptionsList` | An array of option objects available for selection. |
| `isOpen` | `boolean` | Whether the dropdown listbox is currently open. |
| `selections` | `FormKitOptionsProp[]` | Array of all currently selected options. |
| `allowNewValues` | `boolean` | Whether arbitrary values not in options can be entered. |
| `max` | `number` | Maximum number of selections allowed. |
| `fns` | `Record<string, (...args: any[]) => any>` | Utility functions for the taglist input. |
| `fns.isSelected` | `(option: FormKitOptionsProp) => boolean` | Returns true if the given option is currently selected. |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the taglist input. |
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
| `option` | `option`, `listitem`, `tagWrapper`, `tag`, `tagLabel` | `FormKitOptionsProp` | The current option object when iterating. Contains value, label, and attrs. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```

#### Input structure
The main taglist input with tag pills and search.
- outer
  └─ wrapper
    └─ label
    └─ inner
      └─ prefixIcon
      └─ prefix
      └─ tags
        └─ tagWrapper
          └─ tag
            └─ tagLabel
            └─ removeSelection
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

#### Listbox structure
The dropdown options list rendered inside dropdownWrapper.
- dropdownWrapper
  └─ listbox
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
| `tags` | `<div>` | Container for all the tag elements. |
| `tagWrapper` | `<div>` | Wrapper around each individual tag. |
| `tag` | `<div>` | A tag element containing the label and remove button. |
| `tagLabel` | `<span>` | The label text inside a tag. |
| `removeSelection` | `<button>` | Button to clear the selected date (when clearable). |
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
| `dropdownWrapper` | `<div>` | Wrapper element for the listbox, handles positioning (popover). |
| `listitem` | `<li>` | A single option item in the listbox. |
| `selectedIcon` | `<span>` | Checkmark shown next to selected items. |
| `option` | `<div>` | Wrapper for each individual toggle button option. |
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
| `input` | `tabindex` | `0` | Prioritizes keyboard focus order by setting it to 0. |
| `input` | `role` | `combobox` | Indicates to assistive technologies that this element functions as a combobox. |
| `input` | `readonly` | `-` | Restrict user edits, ensuring data integrity and a controlled, informative user experience. |
| `input` | `aria-autocomplete` | `list` | Guides input suggestions, presenting a collection of values that could complete the user's input. |
| `input` | `aria-expanded` | `-` | Conveys the expandable state when the element is in focus. |
| `input` | `aria-controls` | `-` | Associates the listbox element, with this element. |
| `input` | `aria-describedby` | `-` | Associates an element with a description, aiding screen readers. |
| `input` | `aria-activedescendant` | `-` | Manage focus to the current active descendent element. |
| `listboxButton` | `tabindex` | `-1` | Prioritizes keyboard focus order by setting it to -1. |
| `listboxButton` | `aria-haspopup` | `true` | Signals that an element triggers a pop-up or menu |
| `listboxButton` | `aria-expanded` | `-` | Conveys the expandable state when the element is in focus. |
| `listboxButton` | `aria-controls` | `-` | Associates the listbox element, with this element. |
| `tagWrapper` | `tabindex` | `-1` | Prioritizes keyboard focus order by setting it to -1. |
| `tag` | `role` | `button` | Indicates to assistive technologies that this element functions as a button. |
| `tags` | `aria-live` | `polite` | Communicates dynamic content changes when selections are on the screen. |
| `removeSelection` | `tabindex` | `-1` | Removes the prioritization of keyboard focus on this element. |
| `removeSelection` | `aria-controls` | `-` | Associates the input element, with this element. |

### Keyboard Interactions

| Key | Description |
|-----|-------------|
| `enter` | Opens the listbox when the input is focused. Selects an item when a list item is focused |
| `space` | Opens the listbox when the input is focused. Selects an item when a list item is focused |
| `esc` | Closes the listbox when the input is focused. |
| `up` | Navigates to previous list item in list box. Closes listbox if most-previous item is selected. |
| `down` | Opens the listbox when input is focused. Navigates to next list item in list box. |
| `left` | Navigates to previous existing tag in input list. |
| `right` | Navigates to next existing tag in input list. If pressed from last-most tag then input is focused. |
