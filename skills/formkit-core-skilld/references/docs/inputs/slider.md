# Slider Input

An advanced range input with support for multiple values.

## Introduction

The `slider` input is an advanced and highly configurable version of the native HTML `range` input. Some notable additions compared to the standard `range` input are:

- Support for multi-value inputs.
- Display tooltips to show selected values.
- Show linked inputs for min and max values.
- Render tick marks for value steps.
- Add arbitrary tick marks.
- Force selection to snap to tick marks.
- Render bar chart data linked to selection values.

## Basic example

### Example: Slider Input

#### basic.vue

```vue
<FormKit
    type="slider"
    label="A very basic slider"
    help="Out of the box I'm not much different than a range input."
  />
```

## Native props

if you're familar with using the native HTML `range` input you'll find than many of the existing props you're familiar with work as expected with the `slider` input.

### Example: Slider Input

#### native-props.vue

```vue
<FormKit
    type="slider"
    label="Native Props"
    value="500"
    min="100"
    max="1000"
    step="25"
    help="Feels natural"
  />
```

### Keyboard modifier keys

Even in its simplest form the `slider` input has a few tricks up its sleeve. Just like the native `range` input you can use your arrow keys to adjust the input value when it is focused — but with the `slider` input you can hold the `shift` key to increment by 10x and your system's modifer key (`command` or `ctrl`) to jump to the min / max values.

### Keyboard number entry

Whenever you have a handle focused on a `slider` input you can type a value on your keyboard and after a slight debounce your `slider` handle will be set to the value you provided — or the closest available match.

## Multi-value

To render two value handles on a `slider` input supply an array as the input's value. Control handles can be dragged through each other and your resulting array value will always be returned sorted in order from smallest to largest.

### Example: Slider Input

#### multiple-values.vue

```vue
<FormKit
      type="slider"
      name="slider"
      label="Multiple Values"
      :value="[50, 350]"
      min="0"
      max="500"
      help="I now render two control handles"
    />
```

## Customizing handles

Using the `maxHandleInner` (default) and `minHandleInner` slots you can customize the appearance of your `slider` handles. The `maxHandleInner` slot is used for single-value `slider` inputs.

### Example: Slider Input

#### customizing-handle.vue

```vue
<template>
  <FormKit
    type="slider"
    label="A slider with styled marks and a custom handle"
    value="50"
    handle-class="!w-auto !h-auto"
  >
    <template #handleMaxInner>
      <div class="p-2">
        <svg xmlns="http://www.w3.org/2000/svg" height="1em" style="display: block;" viewBox="0 0 512 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M406.6 374.6l96-96c12.5-12.5 12.5-32.8 0-45.3l-96-96c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L402.7 224l-293.5 0 41.4-41.4c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-96 96c-12.5 12.5-12.5 32.8 0 45.3l96 96c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L109.3 288l293.5 0-41.4 41.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0z"/></svg>
      </div>
    </template>
  </FormKit>
</template>
```

## Customizing tooltips

### Tooltip visibility

By default `slider` tooltips show on hover and when a selection handle is being dragged. You can force tooltips into an on or off state by using the `tooltip` prop and providing a boolean value.

### Example: Slider Input

#### tooltip-visibility.vue

```vue
<FormKit
    type="slider"
    label="Default Tooltip Visibility"
    value="25"
    help="I show my tooltip on hover and drag"
  />
  <FormKit
    type="slider"
    label="Force Show Tooltip"
    value="50"
    tooltip="true"
    help="I always show my tooltip"
  />
  <FormKit
    type="slider"
    label="Force Hide Tooltip"
    value="75"
    tooltip="false"
    help="I never show my tooltip. I'm basically a native range input"
  />
```

### Tooltip formating

By providing a function to the `tooltip-format` prop you can customize the value of your `slider` tooltip. Your `tooltip-format` function will be provided two arguments:

`value`: The current value that would be displayed in the tooltip by default.
`handle`: The current handle being affected by the funciton. Either `min` or `max`.

### Example: Slider Input

#### tooltip-formatting.vue

```vue
<FormKit
    type="slider"
    label="Default Tooltip Visibility"
    :value="[60, 100]"
    :tooltip-format="
      (value, handle) => {
        return `${handle === 'min' ? 'Min' : 'Max'}: ${value}`
      }
    "
    tooltip="true"
    help="I apply custom formatting to my tooltips"
  />
```

By using the `tooltip-format` prop you can introduce variety to your `slider` inputs — especially when combined with [FormKit's section-key class prop system](/essentials/styling#section-key-class-props).

### Example: Slider Input

#### fun-formatting.vue

```vue
<FormKit
    type="slider"
    label="About how large should the spacing be?"
    help="This is a rough estimate."
    :value="[25, 75]"
    :tooltip-format="(value, handle) => (handle === 'min' ? '👉' : '👈')"
    tooltip-class="large"
  />

  <FormKit
    type="slider"
    label="What do you think of FormKit?"
    help="be honest."
    value="80"
    :tooltip-format="
      (value) => {
        if (value < 25) {
          return '😡'
        } else if (value < 50) {
          return '😐'
        } else if (value < 75) {
          return '😀'
        } else if (value < 100) {
          return '😍'
        } else if (value === 100) {
          return '🦄'
        }
      }
    "
    tooltip="true"
    :fill-class="emotionClass"
    tooltip-class="large"
  />
```

## Linked number inputs

Sometimes a range-style input is more useful for users if they're also able to directly enter numeric values in linked fields. You can reveal `number` inputs that are bound to the values of the `slider` range handles by setting the `show-input` prop to `true`.

### Example: Linked Inputs

#### linked-inputs.vue

```vue
<FormKit
    type="slider"
    value="33"
    label="A single slider with a visible input"
    help="I have a single linked input"
    show-input
  />

  <FormKit
    type="slider"
    :value="[33, 66]"
    label="A slider with multiple inputs"
    show-input
  />
```

### Linked input attributes

The linked `number` inputs are FormKit inputs. You can apply props to them using the provided props:

- `input-attrs`: will bind your provided object to both the `min` and `max` inputs.
- `min-input-attrs`: Object to bind to the linked `min` input.
- `max-input-attrs`: Object to bind to the linked `max` input.

### Example: Linked Inputs

#### linked-input-attrs.vue

```vue
<FormKit
    type="slider"
    max="1000"
    :value="[300, 800]"
    label="Linked input attrs"
    show-input
    :input-attrs="{
      sectionsSchema: {
        prefix: {
          $el: 'span',
          children: '&dollar;',
        },
      },
    }"
    :min-input-attrs="{
      label: 'Minimum Price',
    }"
    :max-input-attrs="{
      label: 'Maximum Price',
    }"
  />
```

## Marks

### Basic usage

The `slider` input supports the rendering of marks on the input's track. By setting the `marks` property to `true` marks will be rendered at every `steps` interval.

### Example: Marks

#### marks.vue

```vue
<FormKit
    type="slider"
    label="I show marks on my track"
    help="By default, marks are rendered at every step interval."
    value="50"
    step="10"
    marks
  />
```

### With labels

You can enable labels for your marks by setting the `mark-labels` prop to `true`.

### Example: Marks with Labels

#### mark-labels.vue

```vue
<FormKit
    type="slider"
    label="I show marks on my track with labels"
    help="Labels can be enabled via prop."
    value="50"
    step="10"
    marks
    mark-labels
  />
```

### Custom marks

By supplying an array of objects to the `marks` prop instead of a boolean you can place arbirtary marks on the slider's track. Mark objects shold have the folloing properties:

- `at`: The position (value) on the track where the mark should render.
- `label`: The label to render for the mark if the `mark-labels` prop is enabled.
- `class`: A string of classes to apply to the mark element.
- `labelClasses`: A string of classes to apply to the mark label element.

### Example: Custom Marks

#### custom-marks.vue

```vue
<FormKit
    type="slider"
    label="I render custom marks"
    value="50"
    :marks="[
      { at: 0, label: '0°C' },
      { at: 20, label: '20°C' },
      { at: 37, label: '37°C' },
      { at: 100, label: '100°C' },
    ]"
    mark-labels
  />
```

### Snap to marks

When supplying custom marks you may want to force the selection to snap to the provided marks. This can be achieved with the `snap-to-marks` prop. When `snap-to-marks` is `true` keyboard events will jump to the next closest mark and entered values through keyboard or linked inputs will snap to the nearest available mark.

### Example: Snap to Marks

#### snap-to-marks.vue

```vue
<FormKit
    type="slider"
    label="I render custom marks"
    value="37"
    :marks="[
      { at: 0, label: '0°C' },
      { at: 20, label: '20°C' },
      { at: 37, label: '37°C' },
      { at: 100, label: '100°C' },
    ]"
    mark-labels
    snap-to-marks
  />
```

### Styling marks

You can apply custom classes to your marks and mark labels by using the `class` and `labelClasses` properties on your mark objects.

### Example: Custom Marks

#### styling-marks.vue

```vue
<script setup>
/* ::javascript:: */
const styledMarks = [
  {
    at: 0,
    label: '0',
    class: 'tiny',
    labelClass: 'red',
  },
  {
    at: 25,
    label: '25',
    class: 'small',
    labelClass: 'orange',
  },
  {
    at: 50,
    label: '50',
    class: 'normal',
    labelClass: 'yellow',
  },
  {
    at: 75,
    label: '75',
    class: 'large',
    labelClass: 'blue-green',
  },
  {
    at: 100,
    label: '100',
    class: 'xlarge',
    labelClass: 'green',
  },
]
/*  */
</script>

<template>
  <FormKit
    type="slider"
    label="I have styled marks"
    value="90"
    :marks="styledMarks"
    mark-labels
  />
</template>

<style scoped>
[data-type='slider'] .formkit-mark {
  box-shadow: 0 0 0 0.1em rgba(0, 0, 0, 0.75);
}

[data-type='slider'] .formkit-mark.tiny {
  width: 0.1em;
  height: 0.1em;
}
[data-type='slider'] .formkit-mark.small {
  width: 0.25em;
  height: 0.25em;
}
[data-type='slider'] .formkit-mark.normal {
  width: 0.5em;
  height: 0.5em;
}
[data-type='slider'] .formkit-mark.large {
  width: 0.75em;
  height: 0.75em;
}
[data-type='slider'] .formkit-mark.xlarge {
  width: 1em;
  height: 1em;
}

[data-type='slider'] .formkit-mark-label.red {
  color: #f44336;
}
[data-type='slider'] .formkit-mark-label.orange {
  color: #ff9800;
}
[data-type='slider'] .formkit-mark-label.yellow {
  color: #baac2e;
}
[data-type='slider'] .formkit-mark-label.blue-green {
  color: #009688;
}
[data-type='slider'] .formkit-mark-label.green {
  color: #4caf50;
}
</style>
```

## Scaling slider values

By default the `slider` input scales values linearly across its entire range. However, you can use the provided `scaling-function` or `intervals` props to change this behavior.

### Using functions

The `scaling-function` prop accepts 3 values:

- The string `linear` — this is the default behavior
- The string `log` which will apply a logarithmic scaling function to your `slider`
- An object which consits of two functions named `forward` and `reverse` which will apply your own scaling logic.

### Example: Scaling functions

#### scaling-functions.vue

```vue
<FormKit
    v-model="scalingValue"
    type="slider"
    label="Scaling: Linear"
    scaling-function="linear"
    v-bind="sharedProps"
  />
  <FormKit
    v-model="scalingValue"
    type="slider"
    label="Scaling: Logarithmic"
    scaling-function="log"
    v-bind="sharedProps"
  />
  <FormKit
    v-model="scalingValue"
    type="slider"
    label="Scaling: Custom Quadratic"
    :scaling-function="customQuad"
    v-bind="sharedProps"
  />
  <FormKit
    v-model="scalingValue"
    type="slider"
    label="Scaling: Custom Sine Wave"
    :scaling-function="customSine"
    v-bind="sharedProps"
  />
```

#### scaling-utils.js

```js
export const customQuad = {
  forward: (value, min, max) => {
    return Math.sqrt(value / max) * max
  },
  reverse: (percentage, min, max) => {
    return percentage ** 2 / max
  },
}
export const customSine = {
  forward: (value, min, max) => {
    return max * (Math.asin(value / 50 - 1) / Math.PI + 0.5)
  },
  reverse: (percentage, min, max) => {
    return 50 * (Math.sin((Math.PI * (percentage - max / 2)) / max) + 1)
  },
}
```

### Using Intervals

The `intervals` prop accepts an array of object where each object defines an interval range on the `slider`. Each obect contains:

- `value`: The point on the `slider` at which the interval begins
- `step`: The step size that should be used within the interval

Your last interval will cover the range extending from your specified `value` to the `max` prop value on your `slider`. If your lowest interval does not begin at the minimum possible value of your `slider` then an interval covering the range from your `min` slider prop to your first interval will be created for you. Its `step` value will be the value of the `step` prop on your `slider` input.

It's important to note that the visual representation of intervals on a `slider` track is based on the total number of possible steps within a given interval and not the interval's raw numeric value.

### Example: Intervals

#### intervals.vue

```vue
<script setup>
const intervals = [
  { value: 0, step: 10 },
  { value: 100, step: 50 },
  { value: 800, step: 100 },
]
const marks = [
  { at: 0, label: '0' },
  { at: 100, label: '100' },
  { at: 800, label: '800' },
  { at: 3000, label: '3000' },
]
</script>

<template>
  <FormKit
    type="slider"
    label="Scaling: Interval"
    :value="100"
    :intervals="intervals"
    :marks="marks"
    mark-labels
    min="0"
    max="3000"
  />
</template>
```

## Chart

You can render a bar chart above the slider with arbitrary values by suppling an array to the `chart` prop. The `chart` array has a similar structure to the `marks` array. Each nested object should contain:

- `at`: The position (value) on the track where the bar for the chart should render.
- `value`: A numeric value that will be used to calculate the relative height of the bar in the chart.

The `slider` input will iterate over you `chart` array and determine the largest `value` contained in the array, and then divide all other values by that largest value to determine the relative heights for rendering the bars of the chart.

### Example: Chart

#### chart.vue

```vue
<FormKit
    type="slider"
    label="I render a bar chart above my track"
    value="30"
    :chart="[
      { at: 0, value: 10 },
      { at: 10, value: 15 },
      { at: 20, value: 20 },
      { at: 30, value: 25 },
      { at: 40, value: 30 },
      { at: 50, value: 35 },
      { at: 60, value: 30 },
      { at: 70, value: 25 },
      { at: 80, value: 15 },
      { at: 90, value: 5 },
    ]"
  />
```

## Full-featured example

By combining the provided props for the `slider` component you can create a robust input to cover a variety of usecases. Here is an example for a price-range slider.

### Example: Kitchen Sink

#### kitchen-sink.vue

```vue
<FormKit
    type="slider"
    label="Choose your price range"
    :value="[800, 1200]"
    :tooltip-format="(v) => `&dollar;${v}`"
    tooltip="true"
    min="0"
    max="2000"
    show-input
    step="25"
    :input-attrs="{
      floatingLabel: true,
      prefixIcon: 'dollar',
    }"
    :min-input-attrs="{
      label: 'Minimum',
    }"
    :max-input-attrs="{
      label: 'Maximum',
    }"
    :marks="[
      { at: 0, label: '$0' },
      { at: 500, label: '$500' },
      { at: 1000, label: '$1000' },
      { at: 1500, label: '$1500' },
      { at: 2000, label: '$2000' },
    ]"
    mark-labels
    :chart="chartData"
  />
```

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `chart` | `array` | `none` | An array of objects containing at and value keys. Renders a relative-height bar-chart above the slider track. |
| `input-attrs` | `object` | `{}` | Applies custom attributes to the nested linked FormKit inputs for both min and max values. |
| `intervals` | `array` | `none` | An array of interval values consisting of value and step used to define differing scaling for different sections of a slider track. |
| `marks` | `boolean || array` | `false` | When true, renders marks on the track at every step value. When an Array of objects with at and label keys, renders a mark on the track at every object's at value. |
| `mark-labels` | `boolean` | `false` | Enables rendering of labels belowe marks on track |
| `max` | `number` | `100` | The maximum possible value of the slider range. |
| `max-input-attrs` | `object` | `{}` | Applies custom attributes to the nested linked FormKit input for the max value. |
| `min` | `number` | `0` | The minimum possible value of the slider range. |
| `min-input-attrs` | `object` | `{}` | Applies custom attributes to the nested linked FormKit input for the min value. |
| `prefix` | `string` | `none` | Characters that will always appear at the beginning of the input. |
| `scaling-function` | `string || object` | `linear` | Defines scaling behavior for values on the rendered slider track using either a preset value string or a set of custom functions. |
| `show-input` | `boolean` | `false` | Renders FormKit type="number" input(s) that are linked to the slider's value(s) |
| `snap-to-marks` | `boolean` | `false` | When enabled, forces user selection to snap to marks |
| `step` | `number` | `1` | The minimum value at which the slider value can increment / decrement. |
| `suffix` | `string` | `none` | Characters that will always appear at the end of the input. |
| `tooltip` | `boolean` | `none` | When set with a boolean value, forces the display of the slider's handle tooltip(s). |
| `tooltip-format` | `function` | `none` | A function that is provided the value and handle for each slider handle which should return a string. |

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

Additional slot data specific to the `slider` input:

| Property | Type | Description |
|----------|------|-------------|
| `min` | `number` | Minimum value of the slider range. |
| `max` | `number` | Maximum value of the slider range. |
| `step` | `number` | Increment step for the slider. |
| `showInput` | `boolean` | Whether to show value input fields. |
| `tooltip` | `boolean` | Whether to show tooltips on handles. |
| `isMulti` | `boolean` | Whether the slider has min/max handles (range). |
| `minValueNum` | `number` | Current minimum value. |
| `maxValueNum` | `number` | Current maximum value. |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the slider input. |
| `handlers.setMin` | `(value: number) => void` | Sets the minimum value. |
| `handlers.setMax` | `(value: number) => void` | Sets the maximum value. |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |
| `markValue` | `mark`, `markLabel` | `number` | The value at this mark position. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```
- outer
  └─ wrapper
    └─ label
    └─ help
    └─ sliderInner
      └─ prefixIcon
      └─ prefix
      └─ track
        └─ chart
          └─ chartBar
        └─ trackWrapper
          └─ trackInner
            └─ fill
            └─ marks
              └─ mark
                └─ markLabel
            └─ handles
              └─ handleMin
                └─ tooltipMin
                └─ handleMinInner
              └─ handleMax
                └─ tooltipMax
                └─ handleMaxInner
      └─ suffix
      └─ suffixIcon
      └─ maxValue
    └─ linkedValues
      └─ minValue
      └─ maxValue
  └─ messages
    └─ message
```

### Section Keys Reference

| Section Key | Element | Description |
|-------------|---------|-------------|
| `outer` | `<div>` | The outermost wrapping element. |
| `wrapper` | `<label>` | A label element wrapping the inner section and label text. Clicking anywhere toggles the checkbox/radio. |
| `label` | `<span>` | A span containing the label text beside the checkbox/radio. |
| `help` | `<div>` | The element containing help text. |
| `sliderInner` | `<div>` | Container for the slider track and value inputs. |
| `prefixIcon` | `<label>` | An element for outputting an icon before the prefix section. |
| `prefix` | (none) | Has no output by default, but allows content directly before an input element. |
| `track` | `<label>` | The track (background) that the thumb slides on. |
| `chart` | `<div>` | Container for the chart bar elements. |
| `chartBar` | `<div>` | An individual bar in the chart. |
| `trackWrapper` | `<div>` | Wrapper around the track inner. |
| `trackInner` | `<div>` | Inner container for the track fill, marks, and handles. |
| `fill` | `<div>` | The fill indicating the selected range on the slider. |
| `marks` | `<div>` | Container for the slider tick marks. |
| `mark` | `<div>` | An individual tick mark on the track. |
| `markLabel` | `<span>` | Label text for a tick mark. |
| `handles` | `<div>` | Container for the slider handles. |
| `handleMin` | `<div>` | The minimum value selection handle. |
| `tooltipMin` | `<div>` | Tooltip showing the minimum value. |
| `handleMinInner` | `<div>` | Inner element of the minimum handle. |
| `handleMax` | `<div>` | The maximum value selection handle (default for single-value). |
| `tooltipMax` | `<div>` | Tooltip showing the maximum value. |
| `handleMaxInner` | `<div>` | Inner element of the maximum handle. |
| `suffix` | (none) | Has no output by default, but allows content directly after an input element. |
| `suffixIcon` | `<span>` | An element for outputting an icon after the suffix section. |
| `maxValue` | `<input>` | Input for the maximum value (or single value). |
| `linkedValues` | `<div>` | Wrapper for linked min/max value inputs (multi-slider). |
| `minValue` | `<input>` | Input for the minimum value. |
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
| `maxValue` | `tabindex` | `-1` | Prioritizes keyboard focus order by setting it to -1 when input is disabled. |
| `minValue` | `tabindex` | `-1` | Prioritizes keyboard focus order by setting it to -1 when input is disabled. |
| `handleMax` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when input is disabled and 0 when its not. |
| `handleMin` | `tabindex` | `-1 or 0` | Prioritizes keyboard focus order by setting it to -1 when input is disabled and 0 when its not. |

### Keyboard Interactions

| Key | Description |
|-----|-------------|
| `up` | Adjust the input value of the active handle up by the current step. |
| `right` | Adjust the input value of the active handle up by the current step. |
| `left` | Adjust the input value of the active handle down by the current step. |
| `down` | Adjust the input value of the active handle down by the current step. |
| `shift` + `up` | Adjust the input value of the active handle up by 10x the current step. |
| `shift` + `right` | Adjust the input value of the active handle up by 10x the current step. |
| `shift` + `left` | Adjust the input value of the active handle down by 10x the current step. |
| `shift` + `down` | Adjust the input value of the active handle down by 10x the current step. |
| `PageUp` | Adjust the input value of the active handle up by 10x the current step. |
| `PageDown` | Adjust the input value of the active handle down by 10x the current step. |
| `Home` | Set the input value of the active handle to the min value. |
| `End` | Set the input value of the active handle to the max value. |
