# List Input

An invisible FormKit input that allows you to logically structure your form data as an array.

> **Warning:** The `list` input does not render any output to the DOM. It is used exclusively for structuring data in your form. It is equivalent to an array in JavaScript.

The `list` input allows you to structure data from child inputs as an array. The list itself outputs no markup (by default) and can be used in conjunction with any other type of input — including nested [groups](/inputs/group) and lists.

The value of a list input is an array where each item is the value of the input at that index. Sub-inputs do not need to be of the same type. In addition to structuring data, lists can determine the validation state, provide initial values, and supply plugins and configuration to all of its children.

## Basic example

### Example: List input

#### list.react.jsx

```jsx
<FormKit modelValue={list} onUpdateModelValue={setList} type="list">
        <p className="text-base mb-4">Please provide a list of emails.</p>
        <FormKit label="Email address" validation="required|email" />
        <FormKit label="Email address" validation="required|email" />
        <FormKit label="Email address" validation="required|email" />
      </FormKit>
      <pre>{JSON.stringify(list, null, 2)}</pre>
```

> **Tip:** FormKit supports <code>modelValue</code> and <code>onUpdateModelValue</code> even on lists and groups. However, if your form needs extremely high performance, consider using the [core node](/essentials/architecture) to read and write values instead of keeping every change in bound component state.

## List types

There are 2 flavors of lists:

- [Static lists (default)](#static-lists) have pre-determined children. They should not be used for iterating over values or adding/removing items.
- [Dynamic lists](#dynamic-lists) allow iteration over the list’s value to create its children. They are useful for creating dynamic-length lists like repeaters.

### Static lists

Static lists are the simplest type of list to create. Wrap any inputs in a `<FormKit type="list">` and those inputs will automatically be set as values of their array. Immediate children of lists do not have a name (even if specified) instead they are always identified by their index. In a static list, this index is *stable* and is based on the order of the inputs.

### Example: Simple static list

#### list-static.react.jsx

```jsx
<h2 className="text-2xl font-bold mb-4">NBA All Time Starting Five</h2>
      <FormKit type="list">
        {({ value }) => (
          <>
            <FormKit
              label="Point Guard"
              type="autocomplete"
              placeholder="Select a player"
              options={nbaTopPlayers}
            />
            <FormKit
              label="Shooting Guard"
              type="autocomplete"
              placeholder="Select a player"
              options={nbaTopPlayers}
            />
            <FormKit
              label="Small Forward"
              type="autocomplete"
              placeholder="Select a player"
              options={nbaTopPlayers}
            />
            <FormKit
              label="Power Forward"
              type="autocomplete"
              placeholder="Select a player"
              options={nbaTopPlayers}
            />
            <FormKit
              label="Center"
              type="autocomplete"
              placeholder="Select a player"
              options={nbaTopPlayers}
            />
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

> **Warning:** Static lists should not be used for iterating over their own value. While it is
safe to iterate over other arbitrary data iterating over the value of the list
itself will cause recursive rendering and infinite loops. Instead use a dynamic list.

### Dynamic lists

Dynamic lists allow you to iterate over the values of the list to create and
hydrate the inputs inside the list. Dynamic lists are useful for creating dynamic array structures like repeaters.

You can mutate the structure of your dynamic list by adding and removing items from the value array. FormKit will automatically update the underlying form structure to match the new value.

In order for dynamic lists to keep your data in sync, you must use `items` from the render-prop child function to render each row, and you must also pass the current `index` as the `index` prop to each child input in the list.

> **Tip:** To use a prebuilt repeater, check out the free [FormKit Pro repeater input](/inputs/repeater).

#### Dynamic list example

### Example: Dynamic list

#### list-dynamic.react.jsx

```jsx
<h2 className="text-2xl font-bold mb-4">Guest list</h2>
      <FormKit type="list" value={['']} dynamic>
        {({ items, node, value }) => (
          <>
            {items?.map((item, index) => (
              <FormKit
                key={`${item}-${index}`}
                index={index}
                label="Guest name"
                placeholder="Guest name"
                suffixIcon="trash"
                onSuffixIconClick={() =>
                  node.input(
                    value.filter((_, itemIndex) => itemIndex !== index)
                  )
                }
                sectionsSchema={{
                  suffixIcon: {
                    $el: 'button',
                  },
                }}
              />
            ))}
            <FormKit type="button" onClick={() => node.input(value.concat(''))}>
              + Add another
            </FormKit>
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### Dynamic list with a nested group

### Example: Dynamic list

#### list-dynamic-nested-group.react.jsx

```jsx
<h2>Guest list</h2>
      <FormKit type="list" value={[{}]} dynamic>
        {({ items, node, value }) => (
          <>
            {items?.map((item, index) => (
              <FormKit key={`guest-${index}`} type="group" index={index}>
                <div style={groupStyle}>
                  <FormKit
                    type="text"
                    name="name"
                    label="Guest name"
                    placeholder="Guest name"
                  />
                  <FormKit type="number" name="age" label="Guest age" />
                  <button
                    type="button"
                    onClick={() =>
                      node.input(
                        value.filter((_, itemIndex) => itemIndex !== index)
                      )
                    }
                    style={removeStyle}
                  >
                    - Remove
                  </button>
                </div>
              </FormKit>
            ))}

            <button
              type="button"
              onClick={() => node.input(value.concat({}))}
              style={addStyle}
            >
              + Add another
            </button>

            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### Dynamic list using bound state

### Example: Dynamic list

#### list-dynamic-v-model.react.jsx

```jsx
<h1>Todo list</h1>
      <FormKit
        modelValue={todos}
        onUpdateModelValue={setTodos}
        type="list"
        dynamic
        sync
      >
        {({ items, value }) => (
          <>
            {items?.map((item, index) => (
              <div key={`${item}-${index}`} style={todoStyle}>
                <FormKit type="text" index={index} />
                <ul style={controlsStyle}>
                  <li>
                    <button
                      type="button"
                      onClick={() => moveTodo(index, index - 1)}
                      style={buttonStyle}
                    >
                      <FormKitIcon icon="arrowUp" />
                    </button>
                  </li>
                  <li>
                    <button
                      type="button"
                      onClick={() => moveTodo(index, index + 1)}
                      style={buttonStyle}
                    >
                      <FormKitIcon icon="arrowDown" />
                    </button>
                  </li>
                  <li>
                    <button
                      type="button"
                      onClick={() =>
                        setTodos((current) =>
                          current.filter((_, todoIndex) => todoIndex !== index)
                        )
                      }
                      style={closeStyle}
                    >
                      <FormKitIcon icon="close" />
                    </button>
                  </li>
                </ul>
              </div>
            ))}
            <FormKit
              type="button"
              onClick={() => setTodos((current) => current.concat(''))}
            >
              Add a todo
            </FormKit>
            <pre>{JSON.stringify(value, null, 2)}</pre>
          </>
        )}
      </FormKit>
```

#### Dynamic list in schema

### Example: Dynamic list

#### list-dynamic-schema.react.jsx

```jsx
const data = {
  addItem: (node) => () => node.input(node._value.concat([''])),
  stringify: JSON.stringify,
}

const schema = {
  $formkit: 'form',
  children: [
    {
      $formkit: 'list',
      name: 'links',
      value: [''],
      dynamic: true,
      children: [
        {
          $formkit: 'text',
          for: ['item', 'index', '$items'],
          key: '$item',
          index: '$index',
          label: 'Link',
          validation: 'required|url',
          validationVisibility: 'submit',
        },
        {
          $formkit: 'button',
          onClick: '$addItem($node)',
          children: 'Add a link',
        },
      ],
    },
    {
      $el: 'pre',
      attrs: { wrap: true },
      children: '$stringify($value)',
    },
  ],
}

export default function App() {
  return <FormKitSchema schema={schema} data={data} library={{ FormKit }} />
}
```

## Validity of children

Lists (and [groups](/inputs/group)) are always aware of the validation state of their children (including nested children). You can access this data in the [context](/essentials/configuration) object of the input (`context.state.valid`).

### Example: List input

#### list-validity.react.jsx

```jsx
<FormKit name="social" type="list">
        {({ state: { valid } }) => (
          <>
            <h2 className="text-2xl font-bold mb-2">Social media handles</h2>
            <p className="text-base mb-4">
              Please provide a your twitter and facebook social media profiles.
            </p>
            {!valid ? (
              <div style={invalidStyle}>
                Your social profile is not complete!
              </div>
            ) : (
              <div style={validStyle}>{`It all looks good \u{1F44D}`}</div>
            )}
            <FormKit
              label="Twitter handle"
              placeholder="@your_profile"
              validation="required|starts_with:@"
              help="Enter your twitter profile handle"
            />
            <FormKit
              label="Facebook profile"
              placeholder="https://facebook.com/your-profile"
              validation="required|starts_with:https://www.facebook.com/"
              help="Enter the URL to your facebook profile."
            />
          </>
        )}
      </FormKit>
```

## Showing error & validation messages

Even though a `list` can have validation rules and input errors, it does not include any functionality to show validation messages and errors by default. The list ships no HTML at all. If you’d like to display those errors, you can add the `<FormKitMessages />` component as a child of the `list`.

> **Tip:** Further documentation on the `FormKitMessages` component can be found on the [form documentation page](/inputs/form#moving-validation-and-error-messages).

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `disabled` | `Boolean` | `false` | Disables all the inputs in the list. |
| `dynamic` | `Boolean` | `false` | Enables dynamic mode for the list and provides items to the default slot or render-prop child function for iteration. |

## Sections

The `list` input renders no output to the DOM so there are no sections to display. The `list` input is a renderless input that is used exclusively for structuring data in your form. It is equivalent to an array in JavaScript.
