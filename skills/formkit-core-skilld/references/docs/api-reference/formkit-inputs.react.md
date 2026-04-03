# formkit/inputs

# @formkit/inputs

## Introduction

The official FormKit Inputs plugin. This package contains the source code for all native HTML input types. Read the inputs documentation for usage instructions.

## Helpers

### $attrs()

**Type:** Function

Applies attributes to a given schema section by applying a higher order function that merges a given set of attributes into the node.
#### Signature
```
$attrs(attrs: FormKitSchemaAttributes | (() => FormKitSchemaAttributes), section: FormKitSchemaExtendableSection): FormKitSchemaExtendableSection;

```
#### Parameters
- `attrs` — Attributes to apply to a [FormKitSchemaExtendableSection](#formkitschemaextendablesection).
- `section` — A section to apply attributes to.
#### Returns
[FormKitSchemaExtendableSection](#formkitschemaextendablesection)


### $extend()

**Type:** Function

Extends a schema node with a given set of extensions.
#### Signature
```
$extend(section: FormKitSchemaExtendableSection, extendWith: Partial<FormKitSchemaNode>): FormKitSchemaExtendableSection;

```
#### Parameters
- `section` — A section to apply an extension to.
- `extendWith` — A partial schema snippet to apply to the section.
#### Returns
[FormKitSchemaExtendableSection](#formkitschemaextendablesection)


### $for()

**Type:** Function

Applies a condition to a given schema section.
#### Signature
```
$for(varName: string, inName: string, section: FormKitSchemaExtendableSection): (extensions: Record<string, Partial<FormKitSchemaNode>>) => FormKitSchemaNode;

```
#### Parameters
- `varName` — The name of the variable that holds the current instance.
- `inName` — The variable we are iterating over.
- `section` — A section to repeat.
#### Returns
[FormKitSchemaExtendableSection](#formkitschemaextendablesection)


### $if()

**Type:** Function

Applies a condition to a given schema section.
#### Signature
```
$if(condition: string, then: FormKitSchemaExtendableSection, otherwise?: FormKitSchemaExtendableSection): FormKitSchemaExtendableSection;

```
#### Parameters
- `condition` — A schema condition to apply to a section.
- `then` — The section that applies if the condition is true.
- `otherwise` *optional* — (else) The section that applies if the condition is false.
#### Returns
[FormKitSchemaExtendableSection](#formkitschemaextendablesection)


### $root()

**Type:** Function

Creates a root schema section.
#### Signature
```
$root(section: FormKitSchemaExtendableSection): FormKitExtendableSchemaRoot;

```
#### Parameters
- `section` — A section to make a root from.
#### Returns
[FormKitSchemaExtendableSection](#formkitschemaextendablesection)


## Features

### checkboxes()

**Type:** Function

A feature that adds checkbox selection support.
#### Signature
```
checkboxes(node: FormKitNode): void;

```
#### Parameters
- `node` — A [FormKitNode](/api-reference/formkit-core#formkitnode).


### defaultIcon()

**Type:** Function

Adds icon props definition.
#### Signature
```
defaultIcon(sectionKey: string, defaultIcon: string): (node: FormKitNode) => void;

```
#### Parameters
- `sectionKey` — the location the icon should be loaded.
- `defaultIcon` — the icon that should be loaded if a match is found in the user's CSS.
#### Returns
A [FormKitPlugin](/api-reference/formkit-core#formkitplugin).


### files()

**Type:** Function

A feature to add file handling support to an input.
#### Signature
```
files(node: FormKitNode): void;

```
#### Parameters
- `node` — A [FormKitNode](/api-reference/formkit-core#formkitnode).


### initialValue()

**Type:** Function

A feature that ensures the input has an `initialValue` prop.
#### Signature
```
initialValue(node: FormKitNode): void;

```
#### Parameters
- `node` — A [FormKitNode](/api-reference/formkit-core#formkitnode).


### localize()

**Type:** Function

Creates a new feature that generates a localization message of type ui for use on a given component.
#### Signature
```
localize(key: string, value?: string): (node: FormKitNode) => void;

```
#### Parameters
- `key` — The key of the message.
- `value` *optional* — The value of the message.
#### Returns
A [FormKitPlugin](/api-reference/formkit-core#formkitplugin).


### normalizeBoxes()

**Type:** Function

A feature that normalizes box types (checkboxes, radios).
#### Signature
```
normalizeBoxes(node: FormKitNode): FormKitMiddleware<{
    prop: string | symbol;
    value: any;
}>;

```
#### Parameters
- `node` — A [FormKitNode](/api-reference/formkit-core#formkitnode).
#### Returns
A [FormKitMiddleware](/api-reference/formkit-node#formkitmiddleware).


### options()

**Type:** Function

A feature that converts the options prop to usable values, to be used by a feature or a plugin.
#### Signature
```
options(node: FormKitNode): void;

```
#### Parameters
- `node` — A [FormKitNode](/api-reference/formkit-core#formkitnode).


### radios()

**Type:** Function

A feature to check if the value being checked is the current value.
#### Signature
```
radios(node: FormKitNode): void;

```
#### Parameters
- `node` — A [FormKitNode](/api-reference/formkit-core#formkitnode).


## Functions

### casts()

**Type:** Function

A feature that allows casting to numbers.
#### Signature
```
casts(node: FormKitNode): void;

```
#### Parameters
- `node` — A [FormKitNode](/api-reference/formkit-core#formkitnode).


### createLibraryPlugin()

**Type:** Function

Creates a plugin based on a list of [FormKitLibrary](/api-reference/formkit-core#formkitlibrary).
#### Signature
```
createLibraryPlugin(...libraries: FormKitLibrary[]): FormKitPlugin;

```
#### Parameters
- `libraries` — One or many [FormKitLibrary](/api-reference/formkit-core#formkitlibrary).
#### Returns
[FormKitPlugin](/api-reference/formkit-core#formkitplugin)


### createSection()

**Type:** Function

Creates a new reusable section.
#### Signature
```
createSection(section: string, el: string | null | (() => FormKitSchemaNode), fragment: true): FormKitSection<FormKitExtendableSchemaRoot>;
createSection(section: string, el: string | null | (() => FormKitSchemaNode)): FormKitSection<FormKitSchemaExtendableSection>;
createSection(section: string, el: string | (() => FormKitSchemaNode), fragment: false): FormKitSection<FormKitSchemaExtendableSection>;

```
#### Parameters
- `section` — A single section of schema
- `el` — The element or a function that returns a schema node.
- `fragment`
#### Returns
Returns a [FormKitExtendableSchemaRoot](/api-reference/formkit-core#formkitextendableschemaroot) or a [FormKitSchemaExtendableSection](/api-reference/formkit-core#formkitschemaextendablesection).


### disables()

**Type:** Function

A feature that allows disabling children of this node.
#### Signature
```
disables(node: FormKitNode): void;

```
#### Parameters
- `node` — A [FormKitNode](/api-reference/formkit-core#formkitnode).


### eachSection()

**Type:** Function

Runs a callback over every section in a schema. if stopOnCallbackReturn is true and the callback returns a value, the loop will stop and return that value.
#### Signature
```
eachSection<T>(schema: FormKitSchemaDefinition, callback: (section: FormKitSchemaComponent | FormKitSchemaDOMNode, schemaParent: FormKitSchemaNode[], schema: FormKitSchemaCondition) => T, stopOnCallbackReturn?: boolean, schemaParent?: FormKitSchemaNode[]): T | void;

```
#### Parameters
- `schema` — A [FormKitSchemaNode](/api-reference/formkit-core#formkitschemanode) array.
- `callback` — A callback to run on every section.
- `stopOnCallbackReturn` *optional* — If true, the loop will stop if the callback returns a value.
- `schemaParent` *optional* — The parent of the current schema node.


### extendSchema()

**Type:** Function

Extends a single schema node with an extension. The extension can be any partial node including strings.
#### Signature
```
extendSchema(schema: FormKitSchemaNode, extension?: Partial<FormKitSchemaNode>): FormKitSchemaNode;

```
#### Parameters
- `schema` — The base schema node.
- `extension` *optional* — The values to extend on the base schema node.
#### Returns
[FormKitSchemaNode](/api-reference/formkit-core#formkitschemanode)


### findSection()

**Type:** Function

Finds a seciton by name in a schema.
#### Signature
```
findSection(schema: FormKitSchemaDefinition, target: string): [false, false] | [FormKitSchemaNode[] | false, FormKitSchemaCondition];

```
#### Parameters
- `schema` — A [FormKitSchemaDefinition](/api-reference/formkit-core#formkitschemadefinition) array.
- `target` — The name of the section to find.
#### Returns
a tuple of the schema and the section or a tuple of `false` and `false` if not found.


### form()

**Type:** Function

A feature to add a submit handler and actions section.
#### Signature
```
form(node: FormKitNode): void;

```
#### Parameters
- `node` — A [FormKitNode](/api-reference/formkit-core#formkitnode).


### ignore()

**Type:** Function

A feature that applies `ignore="true"` by default.
#### Signature
```
ignore(node: FormKitNode): void;

```
#### Parameters
- `node` — A [FormKitNode](/api-reference/formkit-core#formkitnode).


### isGroupOption()

**Type:** Function

A helper to determine if an option is a group or an option.
#### Signature
```
isGroupOption(option: FormKitOptionsItem | FormKitOptionsGroupItem | FormKitOptionsGroupItemProp): option is FormKitOptionsGroupItem;

```
#### Parameters
- `option` — An option


### isSchemaObject()

**Type:** Function

Type guard for schema objects.
#### Signature
```
isSchemaObject(schema: Partial<FormKitSchemaNode>): schema is FormKitSchemaDOMNode | FormKitSchemaComponent | FormKitSchemaFormKit;

```
#### Parameters
- `schema` — returns `true` if the node is a schema node but not a string or conditional.
#### Returns
`boolean`


### isSlotCondition()

**Type:** Function

Checks if the current schema node is a slot condition.
#### Signature
```
isSlotCondition(node: FormKitSchemaNode): node is {
    if: string;
    then: string;
    else: FormKitSchemaNode | FormKitSchemaNode[];
};

```
#### Parameters
- `node` — A [FormKitSchemaNode](/api-reference/formkit-core#formkitschemanode).
#### Returns
`boolean`
#### Examples
```
{
 if: '$slot.name',
 then: '$slot.name',
 else: []
} // this schema node would return true.

```


### normalizeOptions()

**Type:** Function

A function to normalize an array of objects, array of strings, or object of key-values to use an array of objects with value and label properties.
#### Signature
```
normalizeOptions<T extends FormKitOptionsPropWithGroups>(options: T): T extends FormKitOptionsProp ? FormKitOptionsList : FormKitOptionsListWithGroups;

```
#### Parameters
- `options` — An un-normalized [FormKitOptionsProp](#formkitoptionsprop).
#### Returns
A list of [FormKitOptionsList](#formkitoptionslist).


### renamesRadios()

**Type:** Function

Automatically rename any radio inputs.
#### Signature
```
renamesRadios(node: FormKitNode): void;

```
#### Parameters
- `node` — A formkit node.


### select()

**Type:** Function

Converts the options prop to usable values.
#### Signature
```
select(node: FormKitNode): void;

```
#### Parameters
- `node` — A formkit node.


### useSchema()

**Type:** Function

Creates an input schema with all of the wrapping base schema.
#### Signature
```
useSchema(inputSection: FormKitSection): FormKitSchemaExtendableSection;

```
#### Parameters
- `inputSection` — Content to store in the input section key location.
#### Returns
[FormKitExtendableSchemaRoot](/api-reference/formkit-core#formkitextendableschemaroot)


## TypeScript

### FormKitBaseEvents

**Type:** Interface

General input events available to all FormKit inputs.
```
interface FormKitBaseEvents<Props extends FormKitInputs<Props>> {
    (event:'input', value: PropType<Props, 'value'>, node: FormKitNode): any;
    (event:'inputRaw', value: PropType<Props, 'value'>, node: FormKitNode): any;
    (event:'input-raw', value: PropType<Props, 'value'>, node: FormKitNode): any;
    (event:'update: modelValue', value: PropType<Props, 'value'>): any;
    (event:'update: model-value', value: PropType<Props, 'value'>): any;
    (event:'node', node: FormKitNode): any;
}

```


### FormKitBaseProps

**Type:** Interface

Base props that should be applied to all FormKit inputs. These are not actual runtime props and are pulled from the context.attrs object. Many of these are just html attributes that are passed through to the input element.
```
interface FormKitBaseProps {
    accept: string;
    action: string;
    actions:'true' | 'false' | boolean;
    dirtyBehavior:'touched' | 'compare';
    disabled:'true' | 'false' | boolean;
    enctype: string;
    help: string;
    ignore:'true' | 'false' | boolean;
    label: string;
    max: string | number;
    method: string;
    min: string | number;
    multiple:'true' | 'false' | boolean;
    placeholder: string;
    preserve:'true' | 'false' | boolean;
    preserveErrors:'true' | 'false' | boolean;
    step: string | number;
}

```


### FormKitBaseSlots

**Type:** Interface

Nearly all inputs in FormKit have a "base" set of slots. This is the "sandwich" around the input itself, like the wrappers, help text, error messages etc. Several other input's slots extend this base interface.
```
interface FormKitBaseSlots<Props extends FormKitInputs<Props>> {
    help: FormKitSlotData<Props>;
    inner: FormKitSlotData<Props>;
    input: FormKitSlotData<Props>;
    label: FormKitSlotData<Props>;
    message: FormKitSlotData<Props, {
        message: FormKitMessage;
    }>;
    messages: FormKitSlotData<Props>;
    outer: FormKitSlotData<Props>;
    prefix: FormKitSlotData<Props>;
    prefixIcon: FormKitSlotData<Props>;
    suffix: FormKitSlotData<Props>;
    suffixIcon: FormKitSlotData<Props>;
    wrapper: FormKitSlotData<Props>;
}

```


### FormKitBoxSlots

**Type:** Interface

The slots available to the radio and checkbox inputs when options are provided.
```
interface FormKitBoxSlots<Props extends FormKitInputs<Props>> {
    box: FormKitSlotData<Props, OptionSlotData<Props>>;
    decorator: FormKitSlotData<Props, OptionSlotData<Props>>;
    decoratorIcon: FormKitSlotData<Props, OptionSlotData<Props>>;
    fieldset: FormKitSlotData<Props>;
    help: FormKitSlotData<Props>;
    icon: FormKitSlotData<Props, OptionSlotData<Props>>;
    inner: FormKitSlotData<Props, OptionSlotData<Props>>;
    input: FormKitSlotData<Props, OptionSlotData<Props>>;
    label: FormKitSlotData<Props, OptionSlotData<Props>>;
    legend: FormKitSlotData<Props>;
    message: FormKitSlotData<Props, {
        message: FormKitMessage;
    }>;
    messages: FormKitSlotData<Props>;
    option: FormKitSlotData<Props, OptionSlotData<Props>>;
    optionHelp: FormKitSlotData<Props, OptionSlotData<Props>>;
    options: FormKitSlotData<Props>;
    prefix: FormKitSlotData<Props, OptionSlotData<Props>>;
    suffix: FormKitSlotData<Props, OptionSlotData<Props>>;
    wrapper: FormKitSlotData<Props, OptionSlotData<Props>>;
}

```


### FormKitConditionalProps

**Type:** Interface

These are props that are used as conditionals in one or more inputs, and as such they need to be defined on all input types. These should all be defined explicitly as "undefined" here, and then defined as their specific type in the FormKitInputProps interface only on the inputs that use them.
```
interface FormKitConditionalProps {
    number: undefined;
    offValue: undefined;
    onValue: undefined;
    options: undefined;
}

```


### FormKitFile

**Type:** Interface

A single file object in FormKit's synthetic "FileList".
```
interface FormKitFile {
    file?: File;
    name: string;
}

```


### FormKitFileSlots

**Type:** Interface

The slots available to the file input, these extend the base slots.
```
interface FormKitFileSlots<Props extends FormKitInputs<Props>> extends FormKitBaseSlots<Props> {
    fileItem: FormKitSlotData<Props>;
    fileItemIcon: FormKitSlotData<Props, {
        file: FormKitFile;
    }>;
    fileList: FormKitSlotData<Props>;
    fileName: FormKitSlotData<Props, {
        file: FormKitFile;
    }>;
    fileRemove: FormKitSlotData<Props, {
        file: FormKitFile;
    }>;
    fileRemoveIcon: FormKitSlotData<Props, {
        file: FormKitFile;
    }>;
    noFiles: FormKitSlotData<Props>;
}

```


### FormKitOptionsGroupItem

**Type:** Interface

Option groups should always be formatted as an array of objects with group and nested options
```
interface FormKitOptionsGroupItem {
    attrs?: Record<string, any>;
    group: string;
    options: FormKitOptionsList;
}

```


### FormKitOptionsGroupItemProp

**Type:** Interface

Option groups should always be formatted as an array of objects with group and nested options
```
interface FormKitOptionsGroupItemProp {
    attrs?: Record<string, any>;
    group: string;
    options: FormKitOptionsProp;
}

```


### FormKitOptionsItem

**Type:** Interface

Options should always be formatted as an array of objects with label and value properties.
```
interface FormKitOptionsItem<V = unknown> {
    __original?: any;
    [index: string]: any;
    attrs?:{
        disabled?: boolean;
    }&Record<string, any>;
    label: string;
    value: V;
}

```


### FormKitOptionsPropExtensions

**Type:** Interface

Allows for prop extensions to be defined by using an interface whose keys are ignored, but values are applied to a union type. This allows for any third party code to extend the options prop by using module augmentation to add new values to the union type.
```
interface FormKitOptionsPropExtensions {
    arrayOfNumbers: number[];
    arrayOfStrings: string[];
    optionsList: FormKitOptionsList;
    valueLabelPojo: Record<string | number, string>;
}

```


### FormKitSchemaExtendableSection

**Type:** Interface

A function that is called with an extensions argument and returns a valid schema node.
```
interface FormKitSchemaExtendableSection {
    _s?: string;
    (extensions: Record<string, Partial<FormKitSchemaNode>>): FormKitSchemaNode;
}

```


### FormKitSection

**Type:** Interface

A function that when called, returns a function that can in turn be called with an extension parameter.
```
interface FormKitSection<T = FormKitSchemaExtendableSection> {
    (...children: Array<FormKitSchemaExtendableSection | string | FormKitSchemaCondition>): T;
}

```


### FormKitSelectSlots

**Type:** Interface

The slots available to the sekect input, these extend the base slots.
```
interface FormKitSelectSlots<Props extends FormKitInputs<Props>> extends FormKitBaseSlots<Props> {
    default: FormKitSlotData<Props>;
    option: FormKitSlotData<Props, OptionSlotData<Props>>;
    selectIcon: FormKitSlotData<Props>;
}

```


### FormKitSlotData

**Type:** Interface

The shape of the context object that is passed to each slot.
```
interface FormKitSlotData<Props extends FormKitInputs<Props>, E extends Record<string, any> = {}> {
    (context: FormKitFrameworkContext<PropType<Props, 'value'>>&E): any;
}

```


### FormKitTextSlots

**Type:** Interface

The slots available to the FormKitText input, these extend the base slots.
```
interface FormKitTextSlots<Props extends FormKitInputs<Props>> extends FormKitBaseSlots<Props> {
}

```


### OptionSlotData

**Type:** Interface

The data available to slots that have an option in scope.
```
interface OptionSlotData<Props extends FormKitInputs<Props>> {
    option: FormKitOptionsItem<PropType<Props, 'value'>>;
}

```


### AllReals

**Type:** Type

An attempt to capture all non-undefined values. This is used to define various conditionals where undefined is not a concrete type, but all other values need to take one logical branch.
```
export type AllReals = number | string | boolean | CallableFunction | Array<any> | null | Record<any, any>;

```


### FormKitButtonSlots

**Type:** Type

The slots available to the button input, these extend the base slots.
```
export type FormKitButtonSlots<Props extends FormKitInputs<Props>> = Omit<FormKitBaseSlots<Props>, 'inner'> & {
    default: FormKitSlotData<Props>;
};

```


### FormKitEvents

**Type:** Type

All FormKit events should be included for a given set of props.
```
export type FormKitEvents<Props extends FormKitInputs<Props>> = MergedEvents<Props>;

```


### FormKitFileValue

**Type:** Type

A synthetic array-based "FileList".
```
export type FormKitFileValue = FormKitFile[];

```


### FormKitInputs

**Type:** Type

All FormKit inputs should be included for this type.
```
export type FormKitInputs<Props extends FormKitInputs<Props>> = MergedProps<Props>[keyof MergedProps<Props>];

```


### FormKitInputSchema

**Type:** Type

Either a schema node, or a function that returns a schema node.
```
export type FormKitInputSchema = ((children?: FormKitSchemaDefinition) => FormKitSchemaNode) | FormKitSchemaNode;

```


### FormKitOptionsList

**Type:** Type

An array of option items.
```
export type FormKitOptionsList = FormKitOptionsItem[];

```


### FormKitOptionsListWithGroups

**Type:** Type

An array of option items with a group.
```
export type FormKitOptionsListWithGroups = Array<FormKitOptionsItem | FormKitOptionsGroupItem>;

```


### FormKitOptionsListWithGroupsProp

**Type:** Type

An array of option items with a group support — where the `option` of the groups can be any valid FormKitOptionsProp type.
```
export type FormKitOptionsListWithGroupsProp = Array<FormKitOptionsItem | FormKitOptionsGroupItemProp>;

```


### FormKitOptionsProp

**Type:** Type

The types of options that can be passed to the options prop.
```
export type FormKitOptionsProp = FormKitOptionsPropExtensions[keyof FormKitOptionsPropExtensions];

```


### FormKitOptionsPropWithGroups

**Type:** Type

The types of options that can be passed to the options prop.
```
export type FormKitOptionsPropWithGroups = FormKitOptionsProp | FormKitOptionsListWithGroupsProp;

```


### FormKitOptionsValue

**Type:** Type

The proper shape of data to be passed to options prop.
```
export type FormKitOptionsValue<Options> = Options extends FormKitOptionsProp ? Options extends Record<infer T, string> ? T : Options extends FormKitOptionsItem[] ? Options[number]['value'] : Options extends Array<infer T> ? T : unknown : unknown;

```


### InputType

**Type:** Type

Selects the "type" from the props if it exists, otherwise it defaults to "text".
```
export type InputType<Props extends FormKitInputs<Props>> = Props['type'] extends string ? Props['type'] : 'text';

```


### MergedEvents

**Type:** Type

Merge all events into a single type. This is then used as the structure for
```
export type MergedEvents<Props extends FormKitInputs<Props>> = InputType<Props> extends keyof FormKitInputEvents<Props> ? FormKitBaseEvents<Props> & FormKitInputEvents<Props>[InputType<Props>] : FormKitBaseEvents<Props>;

```


### MergedProps

**Type:** Type

A merger of input props, base props, and conditional props. This is then used as the structure for the FormKitInputs type.
```
export type MergedProps<Props extends FormKitInputs<Props>> = {
    [K in keyof FormKitInputProps<Props>]: Omit<Partial<FormKitBaseProps>, keyof FormKitInputProps<Props>[K]> & Omit<Partial<FormKitRuntimeProps<Props>>, keyof FormKitInputProps<Props>[K]> & Omit<Partial<FormKitConditionalProps>, keyof FormKitInputProps<Props>[K]> & Partial<K extends keyof FormKitInputEventsAsProps<Props> ? Omit<FormKitEventsAsProps, keyof FormKitInputEventsAsProps<Props>[K]> & FormKitInputEventsAsProps<Props>[K] : FormKitEventsAsProps> & FormKitInputProps<Props>[K];
};

```


### PropType

**Type:** Type

Extracts the type from a given prop.
```
export type PropType<Props extends FormKitInputs<Props>, T extends keyof FormKitInputs<Props>> = Extract<FormKitInputs<Props>, {
    type: Props['type'] extends string ? Props['type'] : 'text';
}>[T];

```

