# Transfer List Input

The transfer list input allows users to transfer values between two lists. It is useful for situations where you need to select multiple values from a large list of options.

## Introduction

The transfer list input is ideal for situations where the end-user needs to select and sort multiple values from a list of options. In this example, we are allowing the end-user to select from a group of guests and move them to a VIP list:

In React JSX props like <code>sourceLabel</code>, <code>targetLabel</code>, <code>sourceEmptyMessage</code>, <code>targetEmptyMessage</code>, <code>clearOnSelect</code>, and <code>transferOnSelect</code> use the standard prop casing for that framework.

### Example: Transfer List

#### transfer-list-full-example.react.jsx

```jsx
<FormKit
        type="form"
        actions={false}
        value={{
          vips: [3, 6],
        }}
      >
        <FormKit
          name="vips"
          type="transferlist"
          label="Choose VIPs for the party"
          sourceLabel="Guests"
          targetLabel="VIPs"
          sourceEmptyMessage="No guests found"
          targetEmptyMessage="No VIPs selected"
          options={getGuests}
          optionLoader={loadGuest}
          slots={{
            targetOption: ({ option }) => (
              <div style={rowStyle}>
                <span style={avatarStyle}>
                  <span style={initialsStyle}>{initials(option.label)}</span>
                </span>
                <div style={infoStyle}>
                  <div style={primaryStyle}>{option.label}</div>
                  <div style={secondaryStyle}>{option.email}</div>
                  <div style={secondaryStyle}>{option.phone}</div>
                </div>
              </div>
            ),
          }}
        />
      </FormKit>
```

#### api.js

```js
export async function getGuests() {
  try {
    const res = await fetch(
      'https://api-formkit-docs-examples.formkit.workers.dev/guests'
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function paginateGuests({ page, hasNextPage }) {
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests?page=${page}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        if (data.current_page < data.total_pages) {
          hasNextPage()
        }
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function searchGuests({ search }) {
  if (!search) {
    return []
  }
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests?search=${search}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function getGuest(id, cachedOption) {
  if (cachedOption) return cachedOption
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests/${id}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return {
          label: data.data.name,
          value: data.data.id,
        }
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return null
}

export async function loadGuest(id, cachedOption) {
  if (cachedOption && cachedOption.hasLoaded) return cachedOption
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests/${id}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return {
          name: data.data.name,
          label: data.data.name + ` (age ${data.data.age})`,
          value: data.data.id,
          age: data.data.age,
          phone: data.data.phone,
          email: data.data.email,
          hasLoaded: true,
        }
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return null
}
```

#### utils.js

```js
export function initials(str) {
  return str
    .split(' ')
    .slice(0, 2)
    .map((item) => item.charAt(0).toUpperCase())
    .join('')
}

export const michaelJordan = (node) => {
  return node.value[0] === '34'
}
```

## Getting started

In this section, we will be covering the basics of how to replicate the 'Guests vs VIPs' example from above.

### Base input

Below is an example of the transfer list input with the minimum required props. As you can see, there are two list boxes: the source list box and the target list box. The source list box will contain the list of options, and the target list box will contain the selected options:

### Example: Transfer List

#### transfer-list-base.react.jsx

```jsx
<FormKit type="transferlist" />
```

### Labels

Let's add some label props to make clear to the end-user how to use the transfer list input. We'll add a `label` prop to explain the directive to the user, and `source-label` and `target-label` props to indicate which list box is the source and which is the target:

### Example: Transfer List

#### transfer-list-labels.react.jsx

```jsx
<FormKit
        type="transferlist"
        label="Choose VIPs for the party"
        sourceLabel="Guests"
        targetLabel="VIPs"
        options={[]}
      />
```

#### Source and target empty messages

In this state, with no options passed and no values selected, we can display a custom message to the user by setting the `source-empty-message` and `target-empty-message` props:

### Example: Transfer List

#### transfer-list-empty-messages.react.jsx

```jsx
<FormKit
        type="transferlist"
        name="vips"
        label="Choose VIPs for the party"
        sourceLabel="Guests"
        targetLabel="VIPs"
        sourceEmptyMessage="No guests found"
        targetEmptyMessage="No VIPs selected"
      />
```

### Defining options

The `options` prop can accept three different formats of values:

- An array of objects with `value` and `label` keys
- An array of strings `'A', 'B', 'C'`
- An object literal with key-value pairs `{ a: 'A', b: 'B', c: 'C' }`
- A function that returns any of the above

Let's go ahead and populate the transfer list's options with a list of guest names:

### Example: Transfer List

#### transfer-list-options.react.jsx

```jsx
<FormKit
        type="transferlist"
        label="Choose VIPs for the party"
        sourceLabel="Guests"
        targetLabel="VIPs"
        sourceEmptyMessage="No guests found"
        targetEmptyMessage="No VIPs selected"
        options={guests}
      />
```

#### guests.js

```js
export const guests = [
  'Monica Baker',
  'Marion Blanchard',
  'Bilal Cline',
  'Harmony Mcdowell',
  'Ellen Dunlap',
  'Anish Ruiz',
  'Edward Mcpherson',
  'Lulu Cabrera',
  'Faizan Donnelly',
  'Jonty Wilkins',
  'Jaime Gibbons',
  'Rhonda Pugh',
  'Mathilda Elliott',
  'Wilbur Chavez',
  'Barnaby Gray',
  'Rachael Bright',
  'Vincent Sherman',
  'Tina Doherty',
  'Lara Robinson',
  'Nathanael Duffy',
  'Millicent Gibbs',
  'Kye Crosby',
  'Martin Michael',
  'Randy Howard',
  'Fraser York',
  'Warren Hoffman',
  'Nannie Savage',
  'Samira Keller',
  'Ioan Hardy',
  'Markus Hanson',
  'Aiza Alvarez',
  'Chelsey Dawson',
  'Aine Bean',
  'Steffan Sullivan',
  'Meghan Ramirez',
  'Tom Parsons',
  'Fleur Franco',
  'Eileen Beltran',
  'Danny Combs',
  'Thomas Barrett',
  'Shreya Pena',
  'Harold Matthams',
  'Lilian Odling',
  'Ismaeel Byrne',
  'Clyde Solis',
  'Wilson Hebert',
  'Libbie Jensen',
  'Ida Dickson',
  'Theodore Eaton',
  'Velma Rivers',
  'Julie Foley',
  'Eloise Potts',
  'Blanche Perez',
  'Candice Howe',
  'Myah Mcmillan',
  'Lyra Fuller',
  'Alastair Rice',
  'Hannah Horton',
  'Sally Chen',
  'John Copeland',
  'Miranda Swanson',
  'Gladys Nichols',
  'Erika Newman',
  'Albie Davenport',
  'Haris Carson',
  'Minnie Perry',
  'Beatrice Connolly',
  'Halle Whitaker',
  'Damien Miles',
  'Damian Blackwell',
  'Hamish Fuentes',
  'Lisa Mcgee',
  'Keanu Bonner',
  'Jaxson Marks',
  'Umair Buckley',
  'Natalie Gentry',
  'Emre Finch',
  'Maddison Ellis',
  'Esme Long',
  'Gareth Stevenson',
  'Beth Mckee',
  'Autumn Todd',
  'Lucie Bonilla',
  'Grace Suarez',
  'Cecil Edwards',
  'Leena Blake',
  'Anya Beck',
  'Flora Benton',
  'Aleena Mcmahon',
  'Caiden Stein',
  'Mario Flores',
  'Cara Nielsen',
  'Leanne Hodges',
  'Inaya Tapia',
  'Hasnain Waller',
  'Serena Pineda',
  'Wojciech Mercado',
  'Jose Gallagher',
  'Zachary Bridges',
  'Ariana Wang',
]
```

### Values

The *value* of the transfer list input is an array. Selected option values from the source list will be appended to the array. To show the value changing in the example below, let's wrap the transfer list input in a FormKit form, set the name of the transfer list input to `vips`, and show the value of the form itself in a `<pre>` tag (if you are unfamiliar with FormKit forms, you can read more [here](/getting-started/your-first-form)):

### Example: Transfer List

#### transfer-list-values.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              name="vips"
              type="transferlist"
              label="Choose VIPs for the party"
              sourceLabel="Guests"
              targetLabel="VIPs"
              sourceEmptyMessage="No guests found"
              targetEmptyMessage="No VIPs selected"
              options={guests}
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### guests.js

```js
export const guests = [
  'Monica Baker',
  'Marion Blanchard',
  'Bilal Cline',
  'Harmony Mcdowell',
  'Ellen Dunlap',
  'Anish Ruiz',
  'Edward Mcpherson',
  'Lulu Cabrera',
  'Faizan Donnelly',
  'Jonty Wilkins',
  'Jaime Gibbons',
  'Rhonda Pugh',
  'Mathilda Elliott',
  'Wilbur Chavez',
  'Barnaby Gray',
  'Rachael Bright',
  'Vincent Sherman',
  'Tina Doherty',
  'Lara Robinson',
  'Nathanael Duffy',
  'Millicent Gibbs',
  'Kye Crosby',
  'Martin Michael',
  'Randy Howard',
  'Fraser York',
  'Warren Hoffman',
  'Nannie Savage',
  'Samira Keller',
  'Ioan Hardy',
  'Markus Hanson',
  'Aiza Alvarez',
  'Chelsey Dawson',
  'Aine Bean',
  'Steffan Sullivan',
  'Meghan Ramirez',
  'Tom Parsons',
  'Fleur Franco',
  'Eileen Beltran',
  'Danny Combs',
  'Thomas Barrett',
  'Shreya Pena',
  'Harold Matthams',
  'Lilian Odling',
  'Ismaeel Byrne',
  'Clyde Solis',
  'Wilson Hebert',
  'Libbie Jensen',
  'Ida Dickson',
  'Theodore Eaton',
  'Velma Rivers',
  'Julie Foley',
  'Eloise Potts',
  'Blanche Perez',
  'Candice Howe',
  'Myah Mcmillan',
  'Lyra Fuller',
  'Alastair Rice',
  'Hannah Horton',
  'Sally Chen',
  'John Copeland',
  'Miranda Swanson',
  'Gladys Nichols',
  'Erika Newman',
  'Albie Davenport',
  'Haris Carson',
  'Minnie Perry',
  'Beatrice Connolly',
  'Halle Whitaker',
  'Damien Miles',
  'Damian Blackwell',
  'Hamish Fuentes',
  'Lisa Mcgee',
  'Keanu Bonner',
  'Jaxson Marks',
  'Umair Buckley',
  'Natalie Gentry',
  'Emre Finch',
  'Maddison Ellis',
  'Esme Long',
  'Gareth Stevenson',
  'Beth Mckee',
  'Autumn Todd',
  'Lucie Bonilla',
  'Grace Suarez',
  'Cecil Edwards',
  'Leena Blake',
  'Anya Beck',
  'Flora Benton',
  'Aleena Mcmahon',
  'Caiden Stein',
  'Mario Flores',
  'Cara Nielsen',
  'Leanne Hodges',
  'Inaya Tapia',
  'Hasnain Waller',
  'Serena Pineda',
  'Wojciech Mercado',
  'Jose Gallagher',
  'Zachary Bridges',
  'Ariana Wang',
]
```

#### Initial values

The transfer list input can be pre-populated with values by setting the `value` prop on the `transferlist` itself or a wrapping `form` or `group`. Remember that the values you pass to the `value` prop need to match the keys of the values in your option list:

### Example: Transfer List

#### transfer-list-initial-values.react.jsx

```jsx
<FormKit
        type="form"
        value={{
          vips: ['Monica Baker', 'Marion Blanchard'],
        }}
        actions={false}
      >
        {({ value }) => (
          <>
            <FormKit
              name="vips"
              type="transferlist"
              label="Choose VIPs for the party"
              sourceLabel="Guests"
              targetLabel="VIPs"
              sourceEmptyMessage="No guests found"
              targetEmptyMessage="No VIPs selected"
              options={guests}
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### guests.js

```js
export const guests = [
  'Monica Baker',
  'Marion Blanchard',
  'Bilal Cline',
  'Harmony Mcdowell',
  'Ellen Dunlap',
  'Anish Ruiz',
  'Edward Mcpherson',
  'Lulu Cabrera',
  'Faizan Donnelly',
  'Jonty Wilkins',
  'Jaime Gibbons',
  'Rhonda Pugh',
  'Mathilda Elliott',
  'Wilbur Chavez',
  'Barnaby Gray',
  'Rachael Bright',
  'Vincent Sherman',
  'Tina Doherty',
  'Lara Robinson',
  'Nathanael Duffy',
  'Millicent Gibbs',
  'Kye Crosby',
  'Martin Michael',
  'Randy Howard',
  'Fraser York',
  'Warren Hoffman',
  'Nannie Savage',
  'Samira Keller',
  'Ioan Hardy',
  'Markus Hanson',
  'Aiza Alvarez',
  'Chelsey Dawson',
  'Aine Bean',
  'Steffan Sullivan',
  'Meghan Ramirez',
  'Tom Parsons',
  'Fleur Franco',
  'Eileen Beltran',
  'Danny Combs',
  'Thomas Barrett',
  'Shreya Pena',
  'Harold Matthams',
  'Lilian Odling',
  'Ismaeel Byrne',
  'Clyde Solis',
  'Wilson Hebert',
  'Libbie Jensen',
  'Ida Dickson',
  'Theodore Eaton',
  'Velma Rivers',
  'Julie Foley',
  'Eloise Potts',
  'Blanche Perez',
  'Candice Howe',
  'Myah Mcmillan',
  'Lyra Fuller',
  'Alastair Rice',
  'Hannah Horton',
  'Sally Chen',
  'John Copeland',
  'Miranda Swanson',
  'Gladys Nichols',
  'Erika Newman',
  'Albie Davenport',
  'Haris Carson',
  'Minnie Perry',
  'Beatrice Connolly',
  'Halle Whitaker',
  'Damien Miles',
  'Damian Blackwell',
  'Hamish Fuentes',
  'Lisa Mcgee',
  'Keanu Bonner',
  'Jaxson Marks',
  'Umair Buckley',
  'Natalie Gentry',
  'Emre Finch',
  'Maddison Ellis',
  'Esme Long',
  'Gareth Stevenson',
  'Beth Mckee',
  'Autumn Todd',
  'Lucie Bonilla',
  'Grace Suarez',
  'Cecil Edwards',
  'Leena Blake',
  'Anya Beck',
  'Flora Benton',
  'Aleena Mcmahon',
  'Caiden Stein',
  'Mario Flores',
  'Cara Nielsen',
  'Leanne Hodges',
  'Inaya Tapia',
  'Hasnain Waller',
  'Serena Pineda',
  'Wojciech Mercado',
  'Jose Gallagher',
  'Zachary Bridges',
  'Ariana Wang',
]
```

### Searchable

The transfer list input can be made searchable by setting the `searchable` prop. In this example we'll set the `searchable` prop and also set a `placeholder` prop for the search input:

### Example: Transfer List

#### transfer-list-searchable.react.jsx

```jsx
<FormKit
        type="form"
        value={{
          vips: ['Monica Baker', 'Marion Blanchard'],
        }}
        actions={false}
      >
        {({ value }) => (
          <>
            <FormKit
              name="vips"
              type="transferlist"
              label="Choose VIPs for the party"
              sourceLabel="Guests"
              targetLabel="VIPs"
              sourceEmptyMessage="No guests found"
              targetEmptyMessage="No VIPs selected"
              options={guests}
              searchable
              placeholder="Search guests"
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### guests.js

```js
export const guests = [
  'Monica Baker',
  'Marion Blanchard',
  'Bilal Cline',
  'Harmony Mcdowell',
  'Ellen Dunlap',
  'Anish Ruiz',
  'Edward Mcpherson',
  'Lulu Cabrera',
  'Faizan Donnelly',
  'Jonty Wilkins',
  'Jaime Gibbons',
  'Rhonda Pugh',
  'Mathilda Elliott',
  'Wilbur Chavez',
  'Barnaby Gray',
  'Rachael Bright',
  'Vincent Sherman',
  'Tina Doherty',
  'Lara Robinson',
  'Nathanael Duffy',
  'Millicent Gibbs',
  'Kye Crosby',
  'Martin Michael',
  'Randy Howard',
  'Fraser York',
  'Warren Hoffman',
  'Nannie Savage',
  'Samira Keller',
  'Ioan Hardy',
  'Markus Hanson',
  'Aiza Alvarez',
  'Chelsey Dawson',
  'Aine Bean',
  'Steffan Sullivan',
  'Meghan Ramirez',
  'Tom Parsons',
  'Fleur Franco',
  'Eileen Beltran',
  'Danny Combs',
  'Thomas Barrett',
  'Shreya Pena',
  'Harold Matthams',
  'Lilian Odling',
  'Ismaeel Byrne',
  'Clyde Solis',
  'Wilson Hebert',
  'Libbie Jensen',
  'Ida Dickson',
  'Theodore Eaton',
  'Velma Rivers',
  'Julie Foley',
  'Eloise Potts',
  'Blanche Perez',
  'Candice Howe',
  'Myah Mcmillan',
  'Lyra Fuller',
  'Alastair Rice',
  'Hannah Horton',
  'Sally Chen',
  'John Copeland',
  'Miranda Swanson',
  'Gladys Nichols',
  'Erika Newman',
  'Albie Davenport',
  'Haris Carson',
  'Minnie Perry',
  'Beatrice Connolly',
  'Halle Whitaker',
  'Damien Miles',
  'Damian Blackwell',
  'Hamish Fuentes',
  'Lisa Mcgee',
  'Keanu Bonner',
  'Jaxson Marks',
  'Umair Buckley',
  'Natalie Gentry',
  'Emre Finch',
  'Maddison Ellis',
  'Esme Long',
  'Gareth Stevenson',
  'Beth Mckee',
  'Autumn Todd',
  'Lucie Bonilla',
  'Grace Suarez',
  'Cecil Edwards',
  'Leena Blake',
  'Anya Beck',
  'Flora Benton',
  'Aleena Mcmahon',
  'Caiden Stein',
  'Mario Flores',
  'Cara Nielsen',
  'Leanne Hodges',
  'Inaya Tapia',
  'Hasnain Waller',
  'Serena Pineda',
  'Wojciech Mercado',
  'Jose Gallagher',
  'Zachary Bridges',
  'Ariana Wang',
]
```

> **Info:** The search input only searches through the options in the source options list. It does not return options that have already been transferred to the target list.

#### Filtering

The transfer list input will filter options with its own internal search function. You can replace this search function by providing the `filter` prop a function of your own. Your function will receive two arguments, the option being iterated over and the current search value:

### Example: Taglist

#### transfer-list-filter.react.jsx

```jsx
const customFilter = (option, search) =>
  option.label.toLowerCase().startsWith((search || '').toLowerCase())

export default function App() {
  return (
    <>

      <FormKit
        type="form"
        value={{
          vips: ['Monica Baker', 'Marion Blanchard'],
        }}
        actions={false}
      >
        {({ value }) => (
          <>
            <FormKit
              name="vips"
              type="transferlist"
              label="Choose VIPs for the party"
              sourceLabel="Guests"
              targetLabel="VIPs"
              sourceEmptyMessage="No guests found"
              targetEmptyMessage="No VIPs selected"
              options={guests}
              searchable
              placeholder="Search guests"
              filter={customFilter}
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### guests.js

```js
export const guests = [
  'Monica Baker',
  'Marion Blanchard',
  'Bilal Cline',
  'Harmony Mcdowell',
  'Ellen Dunlap',
  'Anish Ruiz',
  'Edward Mcpherson',
  'Lulu Cabrera',
  'Faizan Donnelly',
  'Jonty Wilkins',
  'Jaime Gibbons',
  'Rhonda Pugh',
  'Mathilda Elliott',
  'Wilbur Chavez',
  'Barnaby Gray',
  'Rachael Bright',
  'Vincent Sherman',
  'Tina Doherty',
  'Lara Robinson',
  'Nathanael Duffy',
  'Millicent Gibbs',
  'Kye Crosby',
  'Martin Michael',
  'Randy Howard',
  'Fraser York',
  'Warren Hoffman',
  'Nannie Savage',
  'Samira Keller',
  'Ioan Hardy',
  'Markus Hanson',
  'Aiza Alvarez',
  'Chelsey Dawson',
  'Aine Bean',
  'Steffan Sullivan',
  'Meghan Ramirez',
  'Tom Parsons',
  'Fleur Franco',
  'Eileen Beltran',
  'Danny Combs',
  'Thomas Barrett',
  'Shreya Pena',
  'Harold Matthams',
  'Lilian Odling',
  'Ismaeel Byrne',
  'Clyde Solis',
  'Wilson Hebert',
  'Libbie Jensen',
  'Ida Dickson',
  'Theodore Eaton',
  'Velma Rivers',
  'Julie Foley',
  'Eloise Potts',
  'Blanche Perez',
  'Candice Howe',
  'Myah Mcmillan',
  'Lyra Fuller',
  'Alastair Rice',
  'Hannah Horton',
  'Sally Chen',
  'John Copeland',
  'Miranda Swanson',
  'Gladys Nichols',
  'Erika Newman',
  'Albie Davenport',
  'Haris Carson',
  'Minnie Perry',
  'Beatrice Connolly',
  'Halle Whitaker',
  'Damien Miles',
  'Damian Blackwell',
  'Hamish Fuentes',
  'Lisa Mcgee',
  'Keanu Bonner',
  'Jaxson Marks',
  'Umair Buckley',
  'Natalie Gentry',
  'Emre Finch',
  'Maddison Ellis',
  'Esme Long',
  'Gareth Stevenson',
  'Beth Mckee',
  'Autumn Todd',
  'Lucie Bonilla',
  'Grace Suarez',
  'Cecil Edwards',
  'Leena Blake',
  'Anya Beck',
  'Flora Benton',
  'Aleena Mcmahon',
  'Caiden Stein',
  'Mario Flores',
  'Cara Nielsen',
  'Leanne Hodges',
  'Inaya Tapia',
  'Hasnain Waller',
  'Serena Pineda',
  'Wojciech Mercado',
  'Jose Gallagher',
  'Zachary Bridges',
  'Ariana Wang',
]
```

#### Clear on select

By default, the transfer list input will clear the search input on select. You can change this behavior by setting the `clear-on-select` prop to `false`:

### Max

The transfer list input can be limited to a maximum number of selected values by setting the `max` prop. For just this example, let's set the max prop to 2 to limit the number of VIPs that can be selected:

### Example: Transfer List

#### transfer-list-max.react.jsx

```jsx
const customFilter = (option, search) =>
  option.label.toLowerCase().startsWith((search || '').toLowerCase())

export default function App() {
  return (
    <>

      <FormKit
        type="form"
        value={{
          vips: ['Monica Baker', 'Marion Blanchard'],
        }}
        actions={false}
      >
        {({ value }) => (
          <>
            <FormKit
              name="vips"
              type="transferlist"
              label="Choose VIPs for the party"
              sourceLabel="Guests"
              targetLabel="VIPs"
              sourceEmptyMessage="No guests found"
              targetEmptyMessage="No VIPs selected"
              options={guests}
              searchable
              placeholder="Search guests"
              filter={customFilter}
              max={2}
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### guests.js

```js
export const guests = [
  'Monica Baker',
  'Marion Blanchard',
  'Bilal Cline',
  'Harmony Mcdowell',
  'Ellen Dunlap',
  'Anish Ruiz',
  'Edward Mcpherson',
  'Lulu Cabrera',
  'Faizan Donnelly',
  'Jonty Wilkins',
  'Jaime Gibbons',
  'Rhonda Pugh',
  'Mathilda Elliott',
  'Wilbur Chavez',
  'Barnaby Gray',
  'Rachael Bright',
  'Vincent Sherman',
  'Tina Doherty',
  'Lara Robinson',
  'Nathanael Duffy',
  'Millicent Gibbs',
  'Kye Crosby',
  'Martin Michael',
  'Randy Howard',
  'Fraser York',
  'Warren Hoffman',
  'Nannie Savage',
  'Samira Keller',
  'Ioan Hardy',
  'Markus Hanson',
  'Aiza Alvarez',
  'Chelsey Dawson',
  'Aine Bean',
  'Steffan Sullivan',
  'Meghan Ramirez',
  'Tom Parsons',
  'Fleur Franco',
  'Eileen Beltran',
  'Danny Combs',
  'Thomas Barrett',
  'Shreya Pena',
  'Harold Matthams',
  'Lilian Odling',
  'Ismaeel Byrne',
  'Clyde Solis',
  'Wilson Hebert',
  'Libbie Jensen',
  'Ida Dickson',
  'Theodore Eaton',
  'Velma Rivers',
  'Julie Foley',
  'Eloise Potts',
  'Blanche Perez',
  'Candice Howe',
  'Myah Mcmillan',
  'Lyra Fuller',
  'Alastair Rice',
  'Hannah Horton',
  'Sally Chen',
  'John Copeland',
  'Miranda Swanson',
  'Gladys Nichols',
  'Erika Newman',
  'Albie Davenport',
  'Haris Carson',
  'Minnie Perry',
  'Beatrice Connolly',
  'Halle Whitaker',
  'Damien Miles',
  'Damian Blackwell',
  'Hamish Fuentes',
  'Lisa Mcgee',
  'Keanu Bonner',
  'Jaxson Marks',
  'Umair Buckley',
  'Natalie Gentry',
  'Emre Finch',
  'Maddison Ellis',
  'Esme Long',
  'Gareth Stevenson',
  'Beth Mckee',
  'Autumn Todd',
  'Lucie Bonilla',
  'Grace Suarez',
  'Cecil Edwards',
  'Leena Blake',
  'Anya Beck',
  'Flora Benton',
  'Aleena Mcmahon',
  'Caiden Stein',
  'Mario Flores',
  'Cara Nielsen',
  'Leanne Hodges',
  'Inaya Tapia',
  'Hasnain Waller',
  'Serena Pineda',
  'Wojciech Mercado',
  'Jose Gallagher',
  'Zachary Bridges',
  'Ariana Wang',
]
```

### Transfer on select

By default, the transfer list input will add or remove options on click. You can change this behavior by setting the `transfer-on-select` prop to `false`. Now, the transfer list will behave more like a traditional transfer list:

### Example: Transfer List

#### transfer-list-transfer-on-select.react.jsx

```jsx
const customFilter = (option, search) =>
  option.label.toLowerCase().startsWith((search || '').toLowerCase())

export default function App() {
  return (
    <>

      <FormKit
        type="form"
        value={{
          vips: ['Monica Baker', 'Marion Blanchard'],
        }}
        actions={false}
      >
        {({ value }) => (
          <>
            <FormKit
              name="vips"
              type="transferlist"
              label="Choose VIPs for the party"
              sourceLabel="Guests"
              targetLabel="VIPs"
              sourceEmptyMessage="No guests found"
              targetEmptyMessage="No VIPs selected"
              options={guests}
              searchable
              placeholder="Search guests"
              filter={customFilter}
              transferOnSelect={false}
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### guests.js

```js
export const guests = [
  'Monica Baker',
  'Marion Blanchard',
  'Bilal Cline',
  'Harmony Mcdowell',
  'Ellen Dunlap',
  'Anish Ruiz',
  'Edward Mcpherson',
  'Lulu Cabrera',
  'Faizan Donnelly',
  'Jonty Wilkins',
  'Jaime Gibbons',
  'Rhonda Pugh',
  'Mathilda Elliott',
  'Wilbur Chavez',
  'Barnaby Gray',
  'Rachael Bright',
  'Vincent Sherman',
  'Tina Doherty',
  'Lara Robinson',
  'Nathanael Duffy',
  'Millicent Gibbs',
  'Kye Crosby',
  'Martin Michael',
  'Randy Howard',
  'Fraser York',
  'Warren Hoffman',
  'Nannie Savage',
  'Samira Keller',
  'Ioan Hardy',
  'Markus Hanson',
  'Aiza Alvarez',
  'Chelsey Dawson',
  'Aine Bean',
  'Steffan Sullivan',
  'Meghan Ramirez',
  'Tom Parsons',
  'Fleur Franco',
  'Eileen Beltran',
  'Danny Combs',
  'Thomas Barrett',
  'Shreya Pena',
  'Harold Matthams',
  'Lilian Odling',
  'Ismaeel Byrne',
  'Clyde Solis',
  'Wilson Hebert',
  'Libbie Jensen',
  'Ida Dickson',
  'Theodore Eaton',
  'Velma Rivers',
  'Julie Foley',
  'Eloise Potts',
  'Blanche Perez',
  'Candice Howe',
  'Myah Mcmillan',
  'Lyra Fuller',
  'Alastair Rice',
  'Hannah Horton',
  'Sally Chen',
  'John Copeland',
  'Miranda Swanson',
  'Gladys Nichols',
  'Erika Newman',
  'Albie Davenport',
  'Haris Carson',
  'Minnie Perry',
  'Beatrice Connolly',
  'Halle Whitaker',
  'Damien Miles',
  'Damian Blackwell',
  'Hamish Fuentes',
  'Lisa Mcgee',
  'Keanu Bonner',
  'Jaxson Marks',
  'Umair Buckley',
  'Natalie Gentry',
  'Emre Finch',
  'Maddison Ellis',
  'Esme Long',
  'Gareth Stevenson',
  'Beth Mckee',
  'Autumn Todd',
  'Lucie Bonilla',
  'Grace Suarez',
  'Cecil Edwards',
  'Leena Blake',
  'Anya Beck',
  'Flora Benton',
  'Aleena Mcmahon',
  'Caiden Stein',
  'Mario Flores',
  'Cara Nielsen',
  'Leanne Hodges',
  'Inaya Tapia',
  'Hasnain Waller',
  'Serena Pineda',
  'Wojciech Mercado',
  'Jose Gallagher',
  'Zachary Bridges',
  'Ariana Wang',
]
```

## Asynchrony

### Asynchronous options

Here we have a transfer list input that loads its options from an asynchronous function. The function is called when the component is mounted and the options are subsequently loaded into the source list box:

### Example: Transfer List

#### transfer-list-async-options.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              name="vips"
              type="transferlist"
              label="Choose VIPs for the party"
              sourceLabel="Guests"
              targetLabel="VIPs"
              sourceEmptyMessage="No guests found"
              targetEmptyMessage="No VIPs selected"
              options={getGuests}
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### api.js

```js
export async function getGuests() {
  try {
    const res = await fetch(
      'https://api-formkit-docs-examples.formkit.workers.dev/guests'
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function paginateGuests({ page, hasNextPage }) {
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests?page=${page}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        if (data.current_page < data.total_pages) {
          hasNextPage()
        }
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function searchGuests({ search }) {
  if (!search) {
    return []
  }
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests?search=${search}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function getGuest(id, cachedOption) {
  if (cachedOption) return cachedOption
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests/${id}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return {
          label: data.data.name,
          value: data.data.id,
        }
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return null
}

export async function loadGuest(id, cachedOption) {
  if (cachedOption && cachedOption.hasLoaded) return cachedOption
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests/${id}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return {
          name: data.data.name,
          label: data.data.name + ` (age ${data.data.age})`,
          value: data.data.id,
          age: data.data.age,
          phone: data.data.phone,
          email: data.data.email,
          hasLoaded: true,
        }
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return null
}
```

#### Pagination

Now let's say that our API request does not fetch all the options we need, but instead returns a paginated response. The transfer list input can handle pagination with minor configuration to the asynchronous function.

When assigning the options prop to an asynchronous function, the function will be called with the FormKit context object as its first argument. This context object contains a `page` property (the current page we are attempting to load) that is tracked by the transfer list input, and `hasNextPage`, which is a callback function we can use to tell the transfer list that there are more options to load:

### Example: Transfer List

#### transfer-list-async-options-pagination.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              name="vips"
              type="transferlist"
              label="Choose VIPs for the party"
              sourceLabel="Guests"
              targetLabel="VIPs"
              sourceEmptyMessage="No guests found"
              targetEmptyMessage="No VIPs selected"
              options={paginateGuests}
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### api.js

```js
export async function getGuests() {
  try {
    const res = await fetch(
      'https://api-formkit-docs-examples.formkit.workers.dev/guests'
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function paginateGuests({ page, hasNextPage }) {
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests?page=${page}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        if (data.current_page < data.total_pages) {
          hasNextPage()
        }
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function searchGuests({ search }) {
  if (!search) {
    return []
  }
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests?search=${search}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function getGuest(id, cachedOption) {
  if (cachedOption) return cachedOption
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests/${id}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return {
          label: data.data.name,
          value: data.data.id,
        }
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return null
}

export async function loadGuest(id, cachedOption) {
  if (cachedOption && cachedOption.hasLoaded) return cachedOption
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests/${id}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return {
          name: data.data.name,
          label: data.data.name + ` (age ${data.data.age})`,
          value: data.data.id,
          age: data.data.age,
          phone: data.data.phone,
          email: data.data.email,
          hasLoaded: true,
        }
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return null
}
```

#### Search

The transfer list input can also load options asynchronously when the user searches. In this example, we'll add back the `searchable` prop, and change `getGuests()` to `searchGuests()`. When the user searches, `searchGuests()` will now be called with the same context object as before, but this time, we will destructure just the `search` property. Additionally, we'll modify `getGuests()` to only return guests when a search value is provided:

### Example: Transfer List

#### transfer-list-async-options-search.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              name="vips"
              type="transferlist"
              label="Choose VIPs for the party"
              sourceLabel="Guests"
              targetLabel="VIPs"
              sourceEmptyMessage="No guests found"
              targetEmptyMessage="No VIPs selected"
              options={searchGuests}
              searchable
              placeholder="Search guests"
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### api.js

```js
export async function getGuests() {
  try {
    const res = await fetch(
      'https://api-formkit-docs-examples.formkit.workers.dev/guests'
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function paginateGuests({ page, hasNextPage }) {
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests?page=${page}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        if (data.current_page < data.total_pages) {
          hasNextPage()
        }
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function searchGuests({ search }) {
  if (!search) {
    return []
  }
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests?search=${search}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function getGuest(id, cachedOption) {
  if (cachedOption) return cachedOption
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests/${id}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return {
          label: data.data.name,
          value: data.data.id,
        }
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return null
}

export async function loadGuest(id, cachedOption) {
  if (cachedOption && cachedOption.hasLoaded) return cachedOption
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests/${id}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return {
          name: data.data.name,
          label: data.data.name + ` (age ${data.data.age})`,
          value: data.data.id,
          age: data.data.age,
          phone: data.data.phone,
          email: data.data.email,
          hasLoaded: true,
        }
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return null
}
```

### Option loader

#### Rehydrating values

The transfer list input also provides an `optionLoader` prop that allows you to rehydrate values that are not in the options list. In this example, we'll provide the transfer list an initial value (a guest ID), and assign the `optionLoader` to a function that will make a request to the API to fetch the individual guest data:

### Example: Transfer List

#### transfer-list-rehydrating-values.react.jsx

```jsx
<FormKit
        type="form"
        value={{
          vips: [22, 10],
        }}
        actions={false}
      >
        {({ value }) => (
          <>
            <FormKit
              name="vips"
              type="transferlist"
              label="Choose VIPs for the party"
              sourceLabel="Guests"
              targetLabel="VIPs"
              sourceEmptyMessage="No guests found"
              targetEmptyMessage="No VIPs selected"
              options={searchGuests}
              searchable
              placeholder="Search guests"
              optionLoader={getGuest}
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### api.js

```js
export async function getGuests() {
  try {
    const res = await fetch(
      'https://api-formkit-docs-examples.formkit.workers.dev/guests'
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function paginateGuests({ page, hasNextPage }) {
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests?page=${page}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        if (data.current_page < data.total_pages) {
          hasNextPage()
        }
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function searchGuests({ search }) {
  if (!search) {
    return []
  }
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests?search=${search}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function getGuest(id, cachedOption) {
  if (cachedOption) return cachedOption
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests/${id}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return {
          label: data.data.name,
          value: data.data.id,
        }
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return null
}

export async function loadGuest(id, cachedOption) {
  if (cachedOption && cachedOption.hasLoaded) return cachedOption
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests/${id}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return {
          name: data.data.name,
          label: data.data.name + ` (age ${data.data.age})`,
          value: data.data.id,
          age: data.data.age,
          phone: data.data.phone,
          email: data.data.email,
          hasLoaded: true,
        }
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return null
}
```

Notice in the example above that the optionLoader function `getGuest` is passed two arguments: the value of the selected option (in this case, the movie ID) and the `cachedOption`. The `cachedOption` is used for preventing unnecessary lookups; if the `cachedOption` is not `null` it means the selected option has already been loaded, and you can return the `cachedOption` directly.

#### Fetching additional data

You can also use use the `optionLoader` to fetch additional data on selected values that is not already in the options list. In this example, after selecting an option, we are going to perform a look-up to load the selected guest's age:

### Example: Transfer List

#### transfer-list-additional-data.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              name="vips"
              type="transferlist"
              label="Choose VIPs for the party"
              sourceLabel="Guests"
              targetLabel="VIPs"
              sourceEmptyMessage="No guests found"
              targetEmptyMessage="No VIPs selected"
              options={getGuests}
              optionLoader={loadGuest}
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### api.js

```js
export async function getGuests() {
  try {
    const res = await fetch(
      'https://api-formkit-docs-examples.formkit.workers.dev/guests'
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function paginateGuests({ page, hasNextPage }) {
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests?page=${page}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        if (data.current_page < data.total_pages) {
          hasNextPage()
        }
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function searchGuests({ search }) {
  if (!search) {
    return []
  }
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests?search=${search}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function getGuest(id, cachedOption) {
  if (cachedOption) return cachedOption
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests/${id}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return {
          label: data.data.name,
          value: data.data.id,
        }
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return null
}

export async function loadGuest(id, cachedOption) {
  if (cachedOption && cachedOption.hasLoaded) return cachedOption
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests/${id}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return {
          name: data.data.name,
          label: data.data.name + ` (age ${data.data.age})`,
          value: data.data.id,
          age: data.data.age,
          phone: data.data.phone,
          email: data.data.email,
          hasLoaded: true,
        }
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return null
}
```

## Slots

Just like any other FormKit input, the transfer list input allows you to utilize slots to customize its markup.

### Source and target options

Now that we are loading additional data on selected values (the age and email address of the selected guest), let's customize the look of the selected values by using the `target-option` slots:

### Example: Transfer List

#### transfer-list-options-slot.react.jsx

```jsx
<FormKit
        type="form"
        actions={false}
        value={{
          vips: [3, 6],
        }}
      >
        <FormKit
          name="vips"
          type="transferlist"
          label="Choose VIPs for the party"
          sourceLabel="Guests"
          targetLabel="VIPs"
          sourceEmptyMessage="No guests found"
          targetEmptyMessage="No VIPs selected"
          options={getGuests}
          optionLoader={loadGuest}
          slots={{
            targetOption: ({ option }) => (
              <div style={rowStyle}>
                <span style={avatarStyle}>
                  <span style={initialsStyle}>{initials(option.label)}</span>
                </span>
                <div style={infoStyle}>
                  <div style={primaryStyle}>{option.label}</div>
                  <div style={secondaryStyle}>{option.email}</div>
                  <div style={secondaryStyle}>{option.phone}</div>
                </div>
              </div>
            ),
          }}
        />
      </FormKit>
```

#### api.js

```js
export async function getGuests() {
  try {
    const res = await fetch(
      'https://api-formkit-docs-examples.formkit.workers.dev/guests'
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function paginateGuests({ page, hasNextPage }) {
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests?page=${page}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        if (data.current_page < data.total_pages) {
          hasNextPage()
        }
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function searchGuests({ search }) {
  if (!search) {
    return []
  }
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests?search=${search}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return data.data.map((result) => {
          return {
            label: result.name,
            value: result.id,
          }
        })
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return []
}

export async function getGuest(id, cachedOption) {
  if (cachedOption) return cachedOption
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests/${id}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return {
          label: data.data.name,
          value: data.data.id,
        }
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return null
}

export async function loadGuest(id, cachedOption) {
  if (cachedOption && cachedOption.hasLoaded) return cachedOption
  try {
    const res = await fetch(
      `https://api-formkit-docs-examples.formkit.workers.dev/guests/${id}`
    )
    if (res.ok) {
      const data = await res.json()
      if (data.data) {
        return {
          name: data.data.name,
          label: data.data.name + ` (age ${data.data.age})`,
          value: data.data.id,
          age: data.data.age,
          phone: data.data.phone,
          email: data.data.email,
          hasLoaded: true,
        }
      }
    }
  } catch (e) {
    // Handle network errors gracefully
  }
  return null
}
```

#### utils.js

```js
export function initials(str) {
  return str
    .split(' ')
    .slice(0, 2)
    .map((item) => item.charAt(0).toUpperCase())
    .join('')
}

export const michaelJordan = (node) => {
  return node.value[0] === '34'
}
```

## Examples

### Ranked order

The transfer list input can be used to create a ranked list, let's do that with the greatest NBA players:

### Example: Transfer List

#### transfer-list-ranking.react.jsx

```jsx
<FormKit
        type="transferlist"
        label="Rank the top 10 NBA players"
        help="Drag and drop to rank your top 10 NBA players."
        options={nbaTopPlayers}
        searchable
        placeholder="Search"
        targetLabel="Your top 10"
        sourceLabel="All-time NBA players"
        validation="michaelJordan"
        validationRules={{ michaelJordan }}
        validationVisibility="dirty"
        validationMessages={{
          michaelJordan: 'Michael Jordan is the undisputed GOAT.',
        }}
        slots={{
          sourceOption: ({ option }) => (
            <div style={rowStyle}>
              <span style={avatarStyle}>
                <img src={option.img_url} alt="" style={imageStyle} />
              </span>
              <span style={nameStyle}>{option.label}</span>
            </div>
          ),
          targetOption: ({ option, index }) => (
            <div style={rowStyle}>
              <span style={rankStyle}>{(index ?? 0) + 1}</span>
              <span style={avatarStyle}>
                <img src={option.img_url} alt="" style={imageStyle} />
              </span>
              <span style={nameStyle}>{option.label}</span>
            </div>
          ),
        }}
      />
```

#### utils.js

```js
export function initials(str) {
  return str
    .split(' ')
    .slice(0, 2)
    .map((item) => item.charAt(0).toUpperCase())
    .join('')
}

export const michaelJordan = (node) => {
  return node.value[0] === '34'
}
```

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `debounce` | `number` | `200` | Number of milliseconds to debounce calls to an options function. |
| `options` | `any` | `[]` | The list of options the user can select from. |
| `filter` | `function` | `null` | Used to apply your own custom filter function for static options. |
| `option-loader` | `function` | `null` | Used for hydrating initial value, or performing an additional request to load more information of a selected option. |
| `source-empty-message` | `string` | `undefined` | Renders a message when there are no options to display. |
| `target-empty-message` | `string` | `undefined` | Renders a message when there are no values to display |
| `max` | `number` | `undefined` | Limits the number of options that can be selected. |
| `clear-on-select` | `boolean` | `true` | Clears the search input after selecting an option (only for options that are not loaded via function). |
| `searchable` | `boolean` | `false` | Enables the search input. |
| `source-label` | `string` | `undefined` | Renders a label for the source list. |
| `target-label` | `string` | `undefined` | Renders a label for the target list. |
| `transfer-on-select` | `boolean` | `true` | Automatically transfers selected options to the target list. If set to false, will render transfer forward and transfer backward buttons. |

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

Additional slot data specific to the `transfer-list` input:

| Property | Type | Description |
|----------|------|-------------|
| `options` | `FormKitOptionsList` | The list of available options for the source list. |
| `transferOnSelect` | `boolean` | Whether items are transferred immediately on click or require transfer button. |
| `max` | `number | undefined` | Maximum number of items that can be selected. |
| `fns` | `Record<string, (...args: any[]) => any>` | Utility functions for the transfer list input. |
| `fns.isSelected` | `(option: FormKitOptionsProp) => boolean` | Returns true if the given option is currently selected. |
| `fns.isSourceSelected` | `(option: FormKitOptionsProp) => boolean` | Returns true if the option is selected in the source list. |
| `fns.isTargetSelected` | `(option: FormKitOptionsProp) => boolean` | Returns true if the option is selected in the target list. |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the transfer list input. |
| `handlers.transferForward` | `() => void` | Transfers selected items from source to target. |
| `handlers.transferBackward` | `() => void` | Transfers selected items from target to source. |
| `handlers.transferForwardAll` | `() => void` | Transfers all items from source to target. |
| `handlers.transferBackwardAll` | `() => void` | Transfers all items from target to source. |
| `handlers.selectSource` | `(option: FormKitOptionsProp) => void` | Selects an option in the source list. |
| `handlers.selectTarget` | `(option: FormKitOptionsProp) => void` | Selects an option in the target list. |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |
| `option` | `sourceListItem`, `sourceOption`, `targetListItem`, `targetOption` | `FormKitOptionsProp` | The current option object when iterating over list items. |
| `sourceOptions` | `source`, `sourceListItems`, `sourceListItem`, `sourceOption` | `FormKitOptionsList` | Filtered options available in the source list. |
| `targetOptions` | `target`, `targetListItems`, `targetListItem`, `targetOption` | `FormKitOptionsList` | Options that have been transferred to the target list. |
| `sourceSearch` | `sourceSearch`, `sourceSearchInput`, `sourceSearchClear` | `string` | The current search query for filtering source options. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```

#### Wrapper structure
The outer container structure showing the source list, transfer controls, and target list.
- outer
  └─ fieldset
    └─ legend
    └─ help
    └─ wrapper
      └─ source
      └─ transferControls
      └─ target
    └─ messages
      └─ message

#### Source list
The source list structure containing search controls and available options.
- source
  └─ sourceHeader
    └─ sourceHeaderLabel
    └─ sourceHeaderItemCount
  └─ sourceControls
    └─ sourceSearch
      └─ sourceSearchInput
      └─ sourceSearchClear
        └─ closeIcon
  └─ sourceListItems
    └─ sourceEmptyMessage
      └─ emptyMessageInner
  └─ sourceListItem
    └─ selectedIcon
    └─ sourceOption
  └─ sourceLoadMore
    └─ loadMoreInner
      └─ loaderIcon

#### Transfer controls
The transfer control buttons for moving items between source and target lists.
- transferControls
  └─ transferButtonForwardAll
    └─ controlLabel
    └─ fastForwardIcon
  └─ transferButtonForward
    └─ controlLabel
    └─ forwardIcon
  └─ transferButtonBackward
    └─ controlLabel
    └─ backwardIcon
  └─ transferButtonBackwardAll
    └─ controlLabel
    └─ rewindIcon

#### Target list
The target list structure showing selected items with empty message and load more.
- target
  └─ targetHeader
    └─ targetHeaderLabel
    └─ targetHeaderItemCount
  └─ targetListItems
    └─ targetEmptyMessage
      └─ emptyMessageInner
    └─ targetListItem
      └─ selectedIcon
      └─ targetOption
    └─ targetLoadMore
      └─ loadMoreInner
        └─ loaderIcon
```

### Section Keys Reference

| Section Key | Element | Description |
|-------------|---------|-------------|
| `outer` | `<div>` | The outermost wrapping element. |
| `fieldset` | `<fieldset>` | A fieldset element that acts as the root element. |
| `legend` | `<legend>` | A legend element that renders the label. |
| `help` | `<div>` | The element containing help text. |
| `wrapper` | `<label>` | A label element wrapping the inner section and label text. Clicking anywhere toggles the checkbox/radio. |
| `source` | `<div>` | Container for the source list (options to choose from). |
| `transferControls` | `<div>` | Container for the forward/backward transfer buttons. |
| `target` | `<div>` | Container for the target list (selected values). |
| `messages` | `<ul>` | A wrapper around all the messages. |
| `message` | `<li>` | The element (or many elements) containing a message — most often validation and error messages. |
| `sourceHeader` | `<div>` | Header area containing the source label and item count. |
| `sourceHeaderLabel` | `<label>` | Label element showing the source list title. |
| `sourceHeaderItemCount` | `<span>` | Displays the count of items in the source list. |
| `sourceControls` | `<div>` | Container for the source search controls. |
| `sourceSearch` | `<div>` | Wrapper for the search input and clear button. |
| `sourceSearchInput` | `<input>` | Text input for searching source options. |
| `sourceSearchClear` | `<button>` | Button to clear the search input. |
| `closeIcon` | `<span>` | Icon for the search clear button. |
| `sourceListItems` | `<ul>` | List containing all source option items. |
| `sourceEmptyMessage` | `<li>` | Message shown when no source options are available. |
| `emptyMessageInner` | `<span>` | Inner span containing the empty message text. |
| `sourceListItem` | `<li>` | A single item in the source list. |
| `selectedIcon` | `<span>` | Checkmark shown next to selected items. |
| `sourceOption` | `<div>` | The option label content within a source list item. |
| `sourceLoadMore` | `<li>` | Element for loading more source options (pagination). |
| `loadMoreInner` | `<span>` | Inner wrapper for the load more content. |
| `loaderIcon` | `<span>` | Loading spinner icon. |
| `transferButtonForwardAll` | `<button>` | Button to transfer all options to the target list. |
| `controlLabel` | `<span>` | Text label inside a transfer control button. |
| `fastForwardIcon` | `<span>` | Icon for the transfer-all-forward button. |
| `transferButtonForward` | `<button>` | Button to transfer selected options to the target list. |
| `forwardIcon` | `<span>` | Icon for the transfer-forward button. |
| `transferButtonBackward` | `<button>` | Button to transfer selected items back to the source list. |
| `backwardIcon` | `<span>` | Icon for the transfer-backward button. |
| `transferButtonBackwardAll` | `<button>` | Button to transfer all items back to the source list. |
| `rewindIcon` | `<span>` | Icon for the transfer-all-backward button. |
| `targetHeader` | `<div>` | Header area containing the target label and item count. |
| `targetHeaderLabel` | `<label>` | Label element showing the target list title. |
| `targetHeaderItemCount` | `<span>` | Displays the count of items in the target list. |
| `targetListItems` | `<ul>` | List containing all target (selected) items. |
| `targetEmptyMessage` | `<li>` | Message shown when no items are selected. |
| `targetListItem` | `<li>` | A single item in the target list. |
| `targetOption` | `<div>` | The option label content within a target list item. |
| `targetLoadMore` | `<li>` | Element for loading more target items. |

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
| `fieldset` | `role` | `presentation` | Indicates to assistive technologies that this element functions as presentation. |
| `fieldset` | `aria-describedby` | `-` | Associates an element with a description, aiding screen readers. |
| `sourceHeader` | `role` | `presentation` | Indicates to assistive technologies that this element functions as presentation. |
| `sourceHeaderLabel` | `for` | `-` | Associates the label to an input element. Users can click on the label to focus the input or to toggle between states. |
| `sourceHeaderItemCount` | `role` | `presentation` | Indicates to assistive technologies that this element functions as presentation. |
| `sourceHeaderItemCount` | `aria-label` | `-` | Provides an accessible name. |
| `sourceSearchInput` | `role` | `searchbox` | Indicates to assistive technologies that this element functions as a searchbox. |
| `sourceSearchInput` | `aria-label` | `-` | Provides an accessible name. |
| `sourceSearchClear` | `aria-label` | `-` | Provides an accessible name. |
| `sourceListItems` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when searchable or there are no source options and 0 when otherwise. |
| `sourceListItems` | `aria-activedescendant` | `-` | Manage focus to the current active descendent element. |
| `sourceListItems` | `role` | `listbox` | Indicates to assistive technologies that this element functions as a listbox. |
| `sourceListItems` | `aria-multiselectable` | `true` | Indicate it allows multiple items to be selected simultaneously. |
| `sourceListItems` | `aria-roledescription` | `-` | Provides a description that this element role. |
| `sourceListItem` | `aria-selected` | `-` | Indicate this element is currently selected. |
| `sourceListItem` | `role` | `option` | Indicates to assistive technologies that this element functions as a option. |
| `sourceLoadMore` | `tabindex` | `-1` | Prioritizes keyboard focus order by setting it to -1. |
| `sourceLoadMore` | `aria-selected` | `false` | Indicate this element is never selected. |
| `sourceEmptyMessage` | `role` | `presentation` | Indicates to assistive technologies that this element functions as presentation. |
| `targetHeader` | `role` | `presentation` | Indicates to assistive technologies that this element functions as presentation. |
| `targetHeaderLabel` | `for` | `-` | Associates the label to an input element. Users can click on the label to focus the input or to toggle between states. |
| `targetHeaderItemCount` | `role` | `presentation` | Indicates to assistive technologies that this element functions as presentation. |
| `targetHeaderItemCount` | `aria-label` | `-` | Provides an accessible name. |
| `targetListItems` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when searchable or there are no source options and 0 when otherwise. |
| `targetListItems` | `aria-activedescendant` | `-` | Manage focus to the current active descendent element. |
| `targetListItems` | `role` | `listbox` | Indicates to assistive technologies that this element functions as a listbox. |
| `targetListItems` | `aria-multiselectable` | `true` | Indicate it allows multiple items to be selected simultaneously. |
| `targetListItems` | `aria-roledescription` | `-` | Provides a description that this element role. |
| `targetListItem` | `aria-selected` | `-` | Indicate this element is currently selected. |
| `targetListItem` | `role` | `option` | Indicates to assistive technologies that this element functions as a option. |
| `targetLoadMore` | `tabindex` | `-1` | Prioritizes keyboard focus order by setting it to -1. |
| `targetLoadMore` | `aria-selected` | `false` | Indicate this element is never selected. |
| `targetEmptyMessage` | `role` | `presentation` | Indicates to assistive technologies that this element functions as presentation. |
| `transferButtonForward` | `aria-label` | `-` | Provides an accessible name. |
| `transferButtonForwardAll` | `aria-label` | `-` | Provides an accessible name. |
| `transferButtonBackward` | `aria-label` | `-` | Provides an accessible name. |
| `transferButtonBackwardAll` | `aria-label` | `-` | Provides an accessible name. |

### Keyboard Interactions

| Key | Description |
|-----|-------------|
| `space` | Invokes the currently selected UI button. |
| `enter` | Moves the currently selected list item between lists |
| `up` + `down` | Moves focus between list items. |
