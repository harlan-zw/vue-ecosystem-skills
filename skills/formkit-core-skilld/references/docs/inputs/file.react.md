# File Input

A native HTML file input with support for multiple files, drag and drop, clearing the input, and repopulating from an array.

The `file` input uses HTML's native file input. It allows users to select files from their device for upload. In addition to native input features, it adds support for:

- Drag and drop
- Clearing the input
- Repopulating from an array

In React JSX the icon props on this input are written as <code>fileItemIcon</code>, <code>fileRemoveIcon</code>, and <code>noFilesIcon</code>.

## Basic example

### Example: File input

#### file.react.jsx

```jsx
<FormKit
        type="file"
        label="Documents"
        accept=".pdf,.doc,.docx,.xml,.md,.csv"
        help="Select as many documents as you would like."
        multiple
      />
```

## Array value

The value of the `file` type should always be an array of objects where each object contains a `name` (string) and optional `file` (File) property. When selecting new files from a user’s device, FormKit will convert the native FileList to the required array-based structure automatically.

This structure can be used to pre-populate a file input with previously uploaded file values:

### Example: File input

#### file-populate.react.jsx

```jsx
<FormKit
        type="file"
        label="Your files"
        help='This input starts with files already "attached".'
        multiple
        value={[
          { name: 'purple-taste.pdf' },
          { name: 'chocolate-recipe.docx' },
        ]}
      />
```

> **Tip:** Pre-populating an input with file names is for display purposes only. It’s an optional feature that provides a consistent interface to convey that a file was *previously* uploaded — however — a FileList is not attached to the actual `<input>` tag for upload.

### Uploading files

The file upload process is left to your form’s submission handler. When submitting the form [via full page request](/inputs/form#submitting-as-a-page-request) no further processing is necessary, however when submitting [via XHR/Fetch request](/inputs/form#submitting-via-xhrfetch-request) you will need to create an instance of FormData with the files attached. Here is a working example:

### Example: File input

#### file-upload.react.jsx

```jsx
{!complete ? (
        <FormKit id="licenseForm" type="form" onSubmit={submitHandler}>
          <FormKit
            type="text"
            label="Full name"
            help="Your full name as it appears on your license"
            name="name"
            validation="required"
          />
          <FormKit
            type="file"
            label="Drivers license"
            name="license"
            help="Please add a scan of your driver's license"
            accept=".jpg,.png,.pdf"
            validation="required"
          />
        </FormKit>
      ) : (
        <div className="complete">License upload complete</div>
      )}
```

## Props & Attributes

The `file` input has a few unique props. There are also several commonly used native HTML attributes that assist in controlling file uploads.

### Universal Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `file-item-icon` | `String` | `’’` | Specifies an icon to put in the fileItemIcon section. Only shows when there is a file selected. Defaults to the fileDoc icon. |
| `file-remove-icon` | `String` | `’’` | Specifies an icon to put in the fileRemoveIcon section. Only shows when a file is selected. Defaults to the close icon. |
| `no-files-icon` | `String` | `’’` | Specifies an icon to put in the noFilesIcon section. Only shows when no file is selected. Defaults to the fileDoc icon. |

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

Additional slot data specific to the `file` input:

| Property | Type | Description |
|----------|------|-------------|
| `_value` | `FileList` | The internal file value. |
| `value` | `File[]` | Array of selected File objects. |

### Section-Specific Slot Data

Additional properties available only in specific sections:

| Property | Sections | Type | Description |
|----------|----------|------|-------------|
| `message` | `message` | `FormKitMessage` | The current message to display. |
| `files` | `fileList`, `fileItem` | `File[]` | Array of files currently selected. |
| `file` | `fileItem`, `fileName`, `fileRemove`, `fileItemIcon` | `File` | The current file being iterated. |

### Section Hierarchy

The following diagram shows the DOM structure of this input:

```

#### Single file
Structure when accepting a single file upload.
- outer
  └─ wrapper
    └─ label
    └─ inner
      └─ prefixIcon
      └─ prefix
      └─ input
      └─ noFiles
        └─ noFilesIcon
      └─ fileList
        └─ fileItem
          └─ fileItemIcon
          └─ fileName
          └─ fileRemove
            └─ fileRemoveIcon
      └─ suffix
      └─ suffixIcon
  └─ help
  └─ messages
    └─ message

#### Multiple files
Structure when accepting multiple file uploads. The fileRemove button removes all files.
- outer
  └─ wrapper
    └─ label
    └─ inner
      └─ prefixIcon
      └─ prefix
      └─ input
      └─ fileList
        └─ fileItem
          └─ fileItemIcon
          └─ fileName
      └─ fileRemove
      └─ noFiles
        └─ noFilesIcon
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
| `input` | `<select>` | The native HTML select element. |
| `noFiles` | `<span>` | Shown when no files have been selected. |
| `noFilesIcon` | `<span>` | Icon inside the noFiles section. |
| `fileList` | `<ul>` | Container for all selected file items. |
| `fileItem` | `<li>` | A single file item in the list. |
| `fileItemIcon` | `<span>` | Icon representing the file type. |
| `fileName` | `<span>` | The name of the selected file. |
| `fileRemove` | `<button>` | Button to remove a file (or all files in multi-mode). |
| `fileRemoveIcon` | `<span>` | Icon inside the file remove button. |
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
| `tab` | Moves the focus to the next focusable element on the page. |
| `shift` + `tab` | Moves the focus to the previous focusable element on the page. |
