# Repeater Input

A Pro input that allows users to add, remove, and re-arrange repeatable input groups.

## Basic example

The `repeater` input is for repeating groups of inputs. You can use any number of FormKit inputs within a repeater, and repeaters themselves can be infinitely nested.

By default, the repeater input has the ability to shift, add, and remove items:

### Example: Repeater

#### repeater-base.react.jsx

```jsx
<FormKit
            name="users"
            type="repeater"
            label="Users"
            draggable
          >
            {({ index }) => (
              <FormKit
                type="email"
                label={`${index + 1}. Email`}
                name="email"
                validation="required|email"
                placeholder="Add email address..."
              />
            )}
          </FormKit>
```

Unlike most other FormKit input types, the repeater input is of type [list](/inputs/list). You can see above that the `users` property (our repeater's value) is an array.

## Schema example

Like all other FormKit inputs, the Repeater is able to be used in a form written in FormKit [schema](/essentials/schema).

### Example: Repeater

#### repeater-schema.react.jsx

```jsx
const schema = [
  {
    $formkit: 'repeater',
    name: 'users',
    children: [
      {
        $formkit: 'text',
        name: 'email',
        label: '$: ($index + 1) + ". Email"',
        validation: 'required|email',
      },
    ],
  },
]
```

## Add button attrs

In the previous example, the 'Add Users' button is provided by default, and the button label is derived from the repeater's `label`. We're able to customize the label by using the `add-button` prop and setting it to a `string`, or remove it completely by setting it to `false`. Alternatively, similar to the `submit-attrs` prop on the [FormKit's forms](/inputs/form), we can provide an object of attributes to be applied to the button with `add-attrs`. In this example, we change the label of the repeater from `Add Users` to `My custom label` using the `add-label` prop:

### Example: Repeater

#### repeater-add-button-attrs.react.jsx

```jsx
<FormKit
        name="users"
        type="repeater"
        label="Philosophy Department Teaching Staff"
        addLabel="My custom 'Add Professor' button"
        help="Edit the staff page here."
      >
        <FormKit
          label="Professor Name"
          name="email"
          validation="required|email"
          placeholder="Add professor name..."
        />
        <FormKit
          name="bio"
          type="textarea"
          label="Professor Bio"
          placeholder="Enter bio here..."
        />
      </FormKit>
```

## Min/max

Like many other FormKit inputs, the repeater comes with a `min` and `max` prop. You can use these props to limit the number of items to be added or removed.

### Example: Repeater

#### repeater-min-max.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              name="users"
              type="repeater"
              label="Users"
              min={2}
              max={3}
            >
              <FormKit
                type="email"
                label="Email"
                name="email"
                validation="required|email"
              />
            </FormKit>
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

## Empty state

When a repeater is allowed to be empty by having its `min` prop set to `0` and having no values, you can control the content rendered in the empty state using the `empty` slot.

### Example: Repeater

#### repeater-empty-state.react.jsx

```jsx
<FormKit type="form" actions={false}>
        {({ value }) => (
          <>
            <FormKit
              name="users"
              type="repeater"
              label="Users"
              min={0}
              slots={{
                empty: () => (
                  <h2 className="text-xl font-bold mb-4">
                    Please add a user to get started.
                  </h2>
                ),
              }}
            >
              <FormKit
                type="email"
                label="Email"
                name="email"
                validation="required|email"
              />
            </FormKit>
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

## Controls

The repeater input by default comes with a set of controls that allow you to shift, add, and remove items. You can control the visibility of these controls by setting the `upControl`, `downControl`, `insertControl`, and `removeControl` props to `true` or `false`.

### Example: Repeater

#### repeater-insert-control.react.jsx

```jsx
<FormKit type="group">
        <FormKit
          id="no-model"
          type="repeater"
          label="Ice cream orders"
          help="Add as many ice cream orders as you want."
          insertControl
        >
          <FormKit name="name" label="Person this order is for" />
          <FormKit
            type="radio"
            label="Flavors"
            options={['Vanilla', 'Chocolate', 'Strawberry']}
          />
        </FormKit>
      </FormKit>
```

## Custom controls

With FormKit's repeater, you are not restricted to our default controls. You can manipulate the repeater in anyway you want:

### Example: Repeater

#### repeater-controls.react.jsx

```jsx
// Imports hidden for brevity
export default function App() {
  const [values, setValues] = useState(initialValues)

  return (
    <FormKit modelValue={values} onUpdateModelValue={setValues} type="group">
      {({ value }) => (
        <>
          <FormKit
            name="users"
            type="repeater"
            label="Users"
            insertControl
            addLabel="+ Add user"
            max={5}
          >
            <FormKit type="text" label="name" name="name" />
          </FormKit>
          <table>
            <thead>
              <tr>
                <th>Add</th>
                <th>Modify</th>
                <th>Remove</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td style={cellStyle}>
                  <button
                    id="push"
                    type="button"
                    onClick={() => pushLast(setValues)}
                    style={buttonStyle}
                  >
                    Push a value
                  </button>
                </td>
                <td style={cellStyle}>
                  <button
                    id="assign"
                    type="button"
                    onClick={() => changeFirst(setValues)}
                    style={buttonStyle}
                  >
                    Assign index 1
                  </button>
                </td>
                <td style={cellStyle}>
                  <button
                    id="shift"
                    type="button"
                    onClick={() => shiftFirst(setValues)}
                    style={buttonStyle}
                  >
                    Shift a value
                  </button>
                </td>
              </tr>
              <tr>
                <td style={cellStyle}>
                  <button
                    id="unshift"
                    type="button"
                    onClick={() => unshiftValue(setValues)}
                    style={buttonStyle}
                  >
                    Unshift a value
                  </button>
                </td>
                <td style={cellStyle}>
                  <button
                    id="splice"
                    type="button"
                    onClick={() => spliceIt(setValues)}
                    style={buttonStyle}
                  >
                    splice to assign (0, 2, [a, b])
                  </button>
                </td>
                <td style={cellStyle}>
                  <button
                    id="spliceRemove"
                    type="button"
                    onClick={() => spliceRemove(setValues)}
                    style={buttonStyle}
                  >
                    splice to delete (1, 4)
                  </button>
                </td>
              </tr>
              <tr>
                <td style={cellStyle}>
                  <button
                    id="inject"
                    type="button"
                    onClick={() => injectAtIndexOne(setValues)}
                    style={buttonStyle}
                  >
                    Inject at index 1
                  </button>
                </td>
                <td style={cellStyle}>
                  <button
                    id="replace"
                    type="button"
                    onClick={() => replaceIt(setValues)}
                    style={buttonStyle}
                  >
                    Replace it all
                  </button>
                </td>
                <td style={cellStyle}>
                  <button
                    id="pop"
                    type="button"
                    onClick={() => popValue(setValues)}
                    style={buttonStyle}
                  >
                    Pop off value
                  </button>
                </td>
              </tr>
              <tr>
                <td style={cellStyle}>&nbsp;</td>
                <td style={cellStyle}>
                  <button
                    id="sort"
                    type="button"
                    onClick={() => sortIt(setValues)}
                    style={buttonStyle}
                  >
                    Sort it
                  </button>
                </td>
                <td style={cellStyle}>&nbsp;</td>
              </tr>
            </tbody>
          </table>
          <pre>{JSON.stringify(value, null, 2)}</pre>
        </>
      )}
    </FormKit>
  )
}
```

#### controls.react.js

```js
export const initialValues = {
  users: [{ name: 'foofoo' }, { name: 'barbar' }],
}

export function unshiftValue(setValues) {
  setValues((current) => ({
    ...current,
    users: [{ name: 'first' }, ...current.users],
  }))
}

export function pushLast(setValues) {
  setValues((current) => ({
    ...current,
    users: [...current.users, { name: 'moomoo' }],
  }))
}

export function changeFirst(setValues) {
  setValues((current) => ({
    ...current,
    users: current.users.map((user, index) =>
      index === 1 ? { name: 'booboo' } : user
    ),
  }))
}

export function spliceIt(setValues) {
  setValues((current) => {
    const users = [...current.users]
    users.splice(1, 2, { name: 'spliced' }, { name: 'double splice' })
    return { ...current, users }
  })
}

export function shiftFirst(setValues) {
  setValues((current) => ({
    ...current,
    users: current.users.slice(1),
  }))
}

export function popValue(setValues) {
  setValues((current) => ({
    ...current,
    users: current.users.slice(0, -1),
  }))
}

export async function spliceRemove(setValues) {
  setValues((current) => {
    const users = [...current.users]
    users.splice(1, 4)
    return { ...current, users }
  })
  await new Promise((resolve) => setTimeout(resolve, 200))
}

export function replaceIt(setValues) {
  setValues({
    users: [
      { name: 'first' },
      { name: 'second' },
      { name: 'third' },
    ],
  })
}

export function injectAtIndexOne(setValues) {
  setValues((current) => {
    const users = [...current.users]
    users.splice(1, 0, { name: 'injected' })
    return { ...current, users }
  })
}

export function sortIt(setValues) {
  setValues((current) => ({
    ...current,
    users: [...current.users].sort((a, b) => (a.name > b.name ? 1 : -1)),
  }))
}
```

## Setting errors

You can set errors on a repeater or any repeatable item using dot notation. Here we are using the
[setErrors](/inputs/form#using-nodeseterrors) helper, but there are other methods as well:

```
// the 2nd argument of setErrors is input-level errors
formNode.setErrors( null, // no form errors,
  {
    // error on the repeater field:
    'teamMembers': ['There was a problem with 1 of your team members.']

    // error on a specific repeater item:
    'teamMembers.1.email': ['emily@formkit.com is already on a team.'],
  }
)

```

Remember, your submit handler is passed the form's core `node` and can be used
to conveniently set errors at depth. Read more about error handling
[here](/inputs/form#error-handling). Here's an example of a fake backend
returning errors for both the repeater and one child:

### Example: Repeater

#### repeater-errors.react.jsx

```jsx
<p>
        <em>Submit to see the errors.</em>
      </p>
      <FormKit
        type="form"
        id="teamMemberForm"
        submitLabel="Submit to see the errors"
        help="hello"
        onSubmit={submitTeamMembers}
      >
        {({ value }) => (
          <>
            <FormKit
              name="teamMembers"
              type="repeater"
              label="Additional Team Members"
              addLabel="Add Team Member"
              defaultValue={[
                { email: 'john@formkit.com' },
                { email: 'emily@formkit.com' },
              ]}
            >
              <FormKit
                type="email"
                label="Team Member email"
                name="email"
                validation="required|email"
                placeholder="Add email address..."
              />
            </FormKit>
            <pre style={preStyle}>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `add-label` | `string` | `null` | Used to change the label of the add button. |
| `add-attrs` | `object` | `[object Object]` | Used to apply attributes to the add button element. |
| `add-button` | `boolean` | `true` | Conditional for whether to show the add button. |
| `up-control` | `boolean` | `true` | Conditional for whether to show the up control. |
| `down-control` | `boolean` | `true` | Conditional for whether to show the down control. |
| `insert-control` | `boolean` | `false` | Conditional for whether to show the insert control. |
| `remove-control` | `boolean` | `true` | Conditional for whether to show the remove control. |
| `min` | `Number` | `1` | The minimum number of children. |
| `max` | `Number` | `null` | The maximum number of children. |

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

Additional slot data specific to the `repeater` input:

| Property | Type | Description |
|----------|------|-------------|
| `min` | `number` | Minimum number of items required. |
| `max` | `number` | Maximum number of items allowed. |
| `addLabel` | `string` | Custom label for the add button. |
| `upControl` | `boolean` | Whether to show the move-up control. |
| `downControl` | `boolean` | Whether to show the move-down control. |
| `removeControl` | `boolean` | Whether to show the remove control. |
| `insertControl` | `boolean` | Whether to show the insert control. |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the repeater input. |
| `handlers.add` | `() => void` | Adds a new item to the end of the list. |
| `handlers.insert` | `(index: number) => void` | Inserts a new item at the given index. |
| `handlers.remove` | `(index: number) => void` | Removes the item at the given index. |
| `handlers.moveUp` | `(index: number) => void` | Moves the item at the given index up. |
| `handlers.moveDown` | `(index: number) => void` | Moves the item at the given index down. |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |
| `index` | `item`, `content`, `group`, `controls`, `up`, `down`, `insert`, `remove` | `number` | The index of the current item in the list. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```
- outer
  └─ fieldset
    └─ legend
    └─ help
    └─ inner
      └─ prefix
      └─ items
        └─ item
          └─ dragHandleWrapper
            └─ dragHandle
              └─ dragHandleIcon
          └─ content
            └─ group
          └─ controls
            └─ up
              └─ upControl
                └─ controlLabel
                └─ moveUpIcon
            └─ remove
              └─ removeControl
                └─ controlLabel
                └─ removeIcon
            └─ insert
              └─ insertControl
                └─ controlLabel
                └─ addIcon
            └─ down
              └─ downControl
                └─ controlLabel
                └─ moveDownIcon
      └─ suffix
    └─ addButton
  └─ messages
    └─ message
```

### Section Keys Reference

| Section Key | Element | Description |
|-------------|---------|-------------|
| `outer` | `<div>` | The outermost wrapping element. |
| `fieldset` | `<fieldset>` | A fieldset element that acts as the root element. |
| `legend` | `<legend>` | A legend element that renders the label. |
| `help` | `<div>` | The element containing help text. |
| `inner` | `<span>` | A span wrapping the input, decorator, prefix, and suffix sections. |
| `prefix` | (none) | Has no output by default, but allows content directly before an input element. |
| `items` | `<ul>` | A ul element that wraps all repeater items. |
| `item` | `<li>` | A li element rendered for each repeater item. |
| `dragHandleWrapper` | `<div>` | Wrapper around the drag handle for reordering items. |
| `dragHandle` | `<div>` | The draggable handle element. |
| `dragHandleIcon` | `<span>` | Icon inside the drag handle. |
| `content` | `<div>` | A container wrapping the group section (repeated fields). |
| `group` | (none) | Structures the default slot into an object data structure. Does not render an element. |
| `controls` | `<ul>` | A ul element wrapping the repeater |
| `up` | `<li>` | A li element containing the move-up control. |
| `upControl` | `<button>` | Button to move an item up in the list. |
| `controlLabel` | `<span>` | Text label inside a transfer control button. |
| `moveUpIcon` | `<span>` | Icon inside the up control button. |
| `remove` | `<li>` | A li element containing the remove control. |
| `removeControl` | `<button>` | Button to remove this item. |
| `removeIcon` | `<span>` | Icon inside the remove control button. |
| `insert` | `<li>` | A li element containing the insert control. |
| `insertControl` | `<button>` | Button to insert a new item after this one. |
| `addIcon` | `<span>` | Icon inside the insert control button. |
| `down` | `<li>` | A li element containing the move-down control. |
| `downControl` | `<button>` | Button to move an item down in the list. |
| `moveDownIcon` | `<span>` | Icon inside the down control button. |
| `suffix` | (none) | Has no output by default, but allows content directly after an input element. |
| `addButton` | `<button>` | Button to add a new item to the repeater. |
| `messages` | `<ul>` | A wrapper around all the messages. |
| `message` | `<li>` | The element (or many elements) containing a message — most often validation and error messages. |

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
| `items` | `role` | `list` | Indicates to assistive technologies that this element functions as a list. |
| `item` | `role` | `listitem` | Indicates to assistive technologies that this element functions as a list. |

### Keyboard Interactions

| Key | Description |
|-----|-------------|
| `enter` | Invokes the currently selected UI control. |
| `space` | Invokes the currently selected UI control. |
