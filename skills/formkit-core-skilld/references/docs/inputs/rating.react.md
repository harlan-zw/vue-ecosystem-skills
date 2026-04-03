# Rating Input

A Pro input that allows users to provide feedback based on a numeric scale represented by icons/images.

## Basic example

The `rating` input allows users to provide feedback based on a numeric scale represented by icons/images:

In React JSX props like <code>ratingIcon</code>, <code>hoverHighlight</code>, <code>offColor</code>, and <code>onColor</code> use the standard prop casing for that framework.

### Example: Rating

#### rating-base.react.jsx

```jsx
<FormKit
            type="rating"
            name="rating"
            label="Did we provide good service?"
          />
```

## Min/max

The `min` and `max` props define the minimum and maximum values an end-user can select. The `max` determines the number of icons rendered:

### Example: Rating

#### rating-min-max.react.jsx

```jsx
<FormKit
            type="rating"
            min={1}
            max={10}
            label="Rate the durability of the Vitamix 5200 Blender"
            name="ratingVitamix"
            id="rating-max"
            innerClass="!w-[250px]"
            onItemWrapperClass="!basis-[25px]"
            offItemWrapperClass="!basis-[25px]"
          />
```

## Step

By default, the `rating` input will increment by 1. The `step` prop will allow you to set the step size between each value. For example, if you set `step="0.5"`, the end-user can select any value that is a multiple of `0.5`. Steps must be a value between `0.01` and `1`:

### Example: Rating

#### rating-step.react.jsx

```jsx
<FormKit
            type="rating"
            step="0.5"
            name="ratingLaCasa"
            slots={{
              label: ({ classes }) => (
                <label className={classes.label}>
                  Rate your stay at <em>La Casa Madrigal</em>
                </label>
              ),
            }}
          />
```

## Icons

By default, the `rating` input uses FormKit's own star icon. You can change which icon is being used by setting the `rating-icon` prop. This prop accepts a string that will use FormKit's [icon plugin](/essentials/icons):

### Example: Rating

#### rating-icon.react.jsx

```jsx
<FormKit
            type="rating"
            ratingIcon="android"
            name="ratingAmongUs"
            label="Rate the Android video game: Among Us"
          />
```

### Slots for icons

#### Default slot

Instead of specifying an icon via the FormKit icon plugin, you can pass a raw SVG using the `default` slot:

In React this is usually implemented with a <code>default</code> entry on the <code>slots</code> prop.

### Example: Rating

#### rating-default-slot.react.jsx

```jsx
<FormKit
            type="rating"
            name="priceCategory"
            label="How expensive was the meal?"
          >
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16">
              <path
                d="M8,8.5s-.04,0-.07,0c-1.14-.15-2.51-.68-2.51-2.38,0-1.02,.68-2.12,2.57-2.12s2.51,1.36,2.57,2.08c.02,.28-.18,.52-.46,.54-.27,.02-.51-.18-.54-.45-.02-.19-.19-1.16-1.58-1.16-1.04,0-1.57,.38-1.57,1.12,0,.38,0,1.18,1.64,1.39,.27,.04,.47,.29,.43,.56-.03,.25-.25,.44-.5,.44Z"
                fill="currentColor"
              />
              <path
                d="M8,12c-1.9,0-2.51-1.36-2.57-2.08-.02-.28,.18-.52,.46-.54,.27-.02,.51,.18,.54,.45,.02,.19,.19,1.16,1.58,1.16,1.04,0,1.57-.38,1.57-1.12,0-.38,0-1.18-1.64-1.39-.27-.04-.47-.29-.43-.56,.04-.27,.29-.47,.56-.43,1.14,.15,2.51,.68,2.51,2.38,0,1.02-.68,2.12-2.57,2.12Z"
                fill="currentColor"
              />
              <path
                d="M8,15c-3.86,0-7-3.14-7-7S4.14,1,8,1s7,3.14,7,7-3.14,7-7,7Zm0-13c-3.31,0-6,2.69-6,6s2.69,6,6,6,6-2.69,6-6-2.69-6-6-6Z"
                fill="currentColor"
              />
              <path
                d="M8,13c-.28,0-.5-.22-.5-.5V3.5c0-.28,.22-.5,.5-.5s.5,.22,.5,.5V12.5c0,.28-.22,.5-.5,.5Z"
                fill="currentColor"
              />
            </svg>
          </FormKit>
```

#### Named slots

Lastly, you can use the `offItem` and `onItem` slots to pass whatever assets you want.In this example, we'll use different images for the `off` and `on` states:

In React this uses <code>offItem</code> and <code>onItem</code> entries on the <code>slots</code> prop.

### Example: Rating

#### rating-named-slots.react.jsx

```jsx
<FormKit
            type="rating"
            name="rating"
            defaultValue={3}
            label="Rate our t-rex exhibit!"
            slots={{
              offItem: () => (
                <img
                  src="https://cdn.formk.it/example-assets/t-rex-outline-s.png"
                  alt=""
                />
              ),
              onItem: () => (
                <img
                  src="https://cdn.formk.it/example-assets/dino-s.png"
                  alt=""
                />
              ),
            }}
          />
```

## Colors

In addition to supplying an icon, you can also specify the color via props. Setting the `off-color` prop will change the color of the icons when they are not selected. The `on-color` prop will change the color of the icons when they are selected:

### Example: Rating

#### rating-colors.react.jsx

```jsx
<FormKit
            type="rating"
            offColor="black"
            onColor="#DA012D"
            ratingIcon="heart"
            label="How much love do you have for FormKit?"
            name="love"
          />
```

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `min` | `Number` | `0` | The minimum number of icons that can be selected. |
| `max` | `Number` | `5` | The maximum number of icons that are rendered. |
| `step` | `Number` | `1` | The step or increment that should be applied to the rating icons. Accepted values are between 0.01 and 1 |
| `hover-highlight` | `Boolean` | `true` | Determines whether to show the selected state of the icon/image when hovered over. |
| `off-color` | `String` | `undefined` | Sets the color to be applied on the given icons when they have not been selected. |
| `on-color` | `String` | `undefined` | Sets the color to be applied on the given icons when they have been selected. |

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

Additional slot data specific to the `rating` input:

| Property | Type | Description |
|----------|------|-------------|
| `max` | `number` | Maximum rating value (number of items). |
| `step` | `number` | Step increment (1 for whole stars, 0.5 for half). |
| `ratingValue` | `number` | Current rating value. |
| `hoveredValue` | `number` | Rating value currently being hovered. |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the rating input. |
| `handlers.setRating` | `(value: number) => void` | Sets the rating value. |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |
| `item` | `ratingItem`, `itemLabel`, `onItemRow`, `offItemRow`, `onItem`, `offItem` | `{ value: number; isOn: boolean }` | The current rating item being rendered. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```
- outer
  └─ wrapper
    └─ label
    └─ inner
      └─ prefixIcon
      └─ prefix
      └─ itemsWrapper
        └─ ratingItem
          └─ template
            └─ itemLabel
              └─ onItemRow
                └─ onItemWrapper
                  └─ onItem
              └─ offItemRow
                └─ offItemWrapper
                  └─ offItem
              └─ itemLabelInner
            └─ input
      └─ suffix
      └─ suffixIcon
  └─ help
  └─ messages
    └─ message
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
| `itemsWrapper` | `<div>` | Wrapper for all rating items (both on and off states). |
| `ratingItem` | `<div>` | A single rating item (iterates for each rating step). |
| `template` | `<div>` | Template wrapper containing the label and input. |
| `itemLabel` | `<label>` | Label element for a rating item. |
| `onItemRow` | `<span>` | Container for the on-state item display. |
| `onItemWrapper` | `<span>` | Wrapper around the on-state item content. |
| `onItem` | `<span>` | The visual element for a selected rating item. |
| `offItemRow` | `<span>` | Container for the off-state item display. |
| `offItemWrapper` | `<span>` | Wrapper around the off-state item content. |
| `offItem` | `<span>` | The visual element for an unselected rating item. |
| `itemLabelInner` | `<span>` | Inner span for screen reader label text. |
| `input` | `<select>` | The native HTML select element. |
| `suffix` | (none) | Has no output by default, but allows content directly after an input element. |
| `suffixIcon` | `<span>` | An element for outputting an icon after the suffix section. |
| `help` | `<div>` | The element containing help text. |
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
| `label` | `for` | `-` | Associates a label to an input element. Users can click on the label to focus the input or to toggle between states. |
| `input` | `disabled` | `-` | Disables an HTML element, preventing user interaction and signaling a non-interactive state. |
| `input` | `aria-describedby` | `-` | Associates an element with a description, aiding screen readers. |
| `input` | `aria-required` | `true` | Added when input validation is set to required. |
| `icon` | `for` | `-` | Links icon to input element when icon in rendered as a label. |

### Keyboard Interactions

| Key | Description |
|-----|-------------|
| `up` | Increases the rating input value by one step. |
| `right` | Increases the rating input value by one step. |
| `down` | Decreases the rating input value by one step. |
| `left` | Decreases the rating input value by one step. |
| `home` | Sets the rating input value to the min value. |
| `end` | Sets the rating input value to the max value. |
