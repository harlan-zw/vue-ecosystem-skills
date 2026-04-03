# Barcode input

Scan barcodes and QR codes

## Introduction

The `barcode` input type is a standalone input published by FormKit. It is powered by the zxing library and allows scanning of a variety of 1D and 2D barcode types using cameras connected to your browsing device.

## Installation

> **Warning:** The `barcode` input has a dependency on `@zxing/library` which is rather heavy (about 100kb minified + gzipped). You should only include this input in your project if you specifically need barcode scanning capability via connected cameras. For manual barcode entry please consider using a `mask` or `text` input with custom validation rules.

To install the `barcode` input add the `@formkit/barcode` package to your project's dependencies.

```
npm install @formkit/barcode

```

Then, in your FormKit configuration file import the input and its styles. Then add the input to your global FormKit configuration.

```
import { defineFormKitConfig } from '@formkit/react'
import { barcode } from '@formkit/barcode'
import '@formkit/barcode/genesis'

export default defineFormKitConfig({
  inputs: {
    barcode,
  },
})

```

## Usage

### Basic

You can now use the `barcode` input type in your `<FormKit />` components. By interacting with the barcode icon you can open an overlay with a video feed from a connected camera. You will need to approve access to the camera via your browser.

In React JSX props like <code>barcodeIcon</code>, <code>loaderIcon</code>, and <code>closeIcon</code> use the standard prop casing for that framework.

### Example: Barcode basic usage

#### basic.react.jsx

```jsx
<FormKit type="barcode" label="Barcode" help="Please scan a barcode" />
```

#### formkit.config.react.jsx

```jsx
import { defineFormKitConfig } from '@formkit/react'
import { genesisIcons } from '@formkit/icons'
import { barcode } from '@formkit/barcode'
import '@formkit/barcode/genesis'

export default defineFormKitConfig({
  inputs: {
    barcode,
  },
  icons: {
    ...genesisIcons,
  },
})
```

### Customizing target barcodes

By default the `barcode` input will scan every supported barcode type. The list of target barcode formats can be changed using the `formats` prop. A full list of supported formats can be seen in the zxing documentation. All format names will be uppercased with `_` separators. So `QR Code` becomes `QR_CODE`, `UPC-A` becomes `UPC_A`, etc.

### Example: Barcode formats

#### formats.react.jsx

```jsx
<FormKit
        type="barcode"
        label="UPC-A Scanner"
        help="I only scan UPC-A barcodes"
        formats={['UPC_A']}
      />
      <FormKit
        type="barcode"
        label="QR Code Scanner"
        help="I only scan QR codes"
        formats={['QR_CODE']}
      />
```

#### formkit.config.react.jsx

```jsx
import { defineFormKitConfig } from '@formkit/react'
import { genesisIcons } from '@formkit/icons'
import { barcode } from '@formkit/barcode'
import '@formkit/barcode/genesis'

export default defineFormKitConfig({
  inputs: {
    barcode,
  },
  icons: {
    ...genesisIcons,
  },
})
```

## Props & Attributes

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `formats` | `Array` | `[]` | An array of available formats in uppercase with _ separators (eg. QR_CODE) from the available set on the zxing documentation. If no formats array is provided then all parsable code formats will be considered valid inputs. |
| `barcode-icon` | `String` | `inline SVG code` | Specifies an icon to put in the barcodeIcon section. The barcodeIcon section is hidden while the camera interface is loading. |
| `loader-icon` | `String` | `spinner` | Specifies an icon to put in the loaderIcon section. The loaderIcon section is shown while the camera interface is loading. |
| `close-icon` | `String` | `close` | Specifies an icon to put in the closeIcon section. |

## Sections

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

Additional slot data specific to the `barcode` input:

| Property | Type | Description |
|----------|------|-------------|
| `formats` | `string[]` | Array of barcode format names to accept. |
| `scannerLoading` | `boolean` | Whether the camera interface is currently loading. |
| `handlers` | `Record<string, (...args: any[]) => void>` | Event handlers for the barcode input. |
| `handlers.openCamera` | `() => void` | Opens the camera dialog for scanning. |
| `handlers.closeCamera` | `() => void` | Closes the camera dialog. |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```

#### Input
The barcode input with scanner icon.
- outer
  └─ wrapper
    └─ label
    └─ inner
      └─ prefixIcon
      └─ prefix
      └─ input
      └─ barcodeIcon
      └─ loaderIcon
      └─ suffix
      └─ suffixIcon
  └─ help
  └─ messages
    └─ message

#### Overlay
The camera dialog overlay for scanning barcodes.
- dialog
  └─ scannerContainer
    └─ closeIcon
    └─ video
    └─ overlay
      └─ overlayDecorators
        └─ overlayDecoratorTopLeft
        └─ overlayDecoratorTopRight
        └─ overlayDecoratorBottomLeft
        └─ overlayDecoratorBottomRight
      └─ laser
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
| `barcodeIcon` | `<span>` | Icon button that opens the camera overlay for scanning. |
| `loaderIcon` | `<span>` | Loading spinner icon. |
| `suffix` | (none) | Has no output by default, but allows content directly after an input element. |
| `suffixIcon` | `<span>` | An element for outputting an icon after the suffix section. |
| `help` | `<div>` | The element containing help text. |
| `messages` | `<ul>` | A wrapper around all the messages. |
| `message` | `<li>` | The element (or many elements) containing a message — most often validation and error messages. |
| `dialog` | `<dialog>` | The dialog element containing the camera interface. |
| `scannerContainer` | `<div>` | Wrapper around the close icon, video stream, and scanning overlay. |
| `closeIcon` | `<span>` | Icon for the search clear button. |
| `video` | `<video>` | Video element showing the connected camera feed. |
| `overlay` | `<div>` | Outer wrapper for the overlay used to style different parts of the mask text. |
| `overlayDecorators` | `<div>` | Container for the corner decorators that frame the scan area. |
| `overlayDecoratorTopLeft` | `<div>` | Top-left corner decorator. |
| `overlayDecoratorTopRight` | `<div>` | Top-right corner decorator. |
| `overlayDecoratorBottomLeft` | `<div>` | Bottom-left corner decorator. |
| `overlayDecoratorBottomRight` | `<div>` | Bottom-right corner decorator. |
| `laser` | `<div>` | Decorative element that imitates a scanning laser line. |
