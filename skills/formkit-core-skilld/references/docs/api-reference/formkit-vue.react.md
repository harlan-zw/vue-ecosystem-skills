# formkit/vue

# @formkit/vue

## Introduction

The official FormKit/Vue integration. This package is responsible for integrating Vue with FormKit core and other first-party packages.

## Functions

### createInput()

**Type:** Function

Creates a new input from schema or a Vue component with the "standard" FormKit features in place such as labels, help text, validation messages, and class support.
#### Signature
```
createInput(schemaOrComponent: FormKitSchemaNode | FormKitSection | Component, definitionOptions?: Partial<FormKitTypeDefinition>): FormKitTypeDefinition;

```
#### Parameters
- `schemaOrComponent` — The actual schema of the input or the component.
- `definitionOptions` *optional* — Any options in the FormKitTypeDefinition you want to define.
#### Returns
[FormKitTypeDefinition](/api-reference/formkit-core#formkittypedefinition)


### defineFormKitConfig()

**Type:** Function

#### Signature
```
defineFormKitConfig(config: DefaultConfigOptions | (() => DefaultConfigOptions)): () => DefaultConfigOptions;

```
#### Parameters
- `config`


### onSSRComplete()

**Type:** Function

Register a callback for when SSR is complete. No-op if not in a server context.
#### Signature
```
onSSRComplete(app: App<any> | undefined, callback: CallableFunction): void;

```
#### Parameters
- `app` — The Vue application.
- `callback` — The callback to be called after SSR is complete.


### ssrComplete()

**Type:** Function

Flush all callbacks registered with onSSRComplete for a given app.
#### Signature
```
ssrComplete(app: App<any>): void;

```
#### Parameters
- `app` — The Vue application.


### useConfig()

**Type:** Function

#### Signature
```
useConfig(config?: FormKitOptions | ((...args: any[]) => FormKitOptions)): void;

```
#### Parameters
- `config` *optional*


### useInput()

**Type:** Function

A composable for creating a new FormKit node.
#### Signature
```
useInput<Props extends FormKitInputs<Props>, Context extends SetupContext<any, any>>(props: Props, context: Context, options?: FormKitOptions): FormKitNode;

```
#### Parameters
- `props`
- `context`
- `options` *optional*
#### Returns
[FormKitNode](/api-reference/formkit-core#formkitnode)


## TypeScript

### FormKitComponentLibrary

**Type:** Interface

A library of components available to the schema (in addition to globally registered ones)
```
interface FormKitComponentLibrary {
    [index: string]: Component;
}

```


### FormKitSetupContext

**Type:** Interface

Type definition for the FormKit component Vue context.
```
interface FormKitSetupContext<Props extends FormKitInputs<Props>> {
    attrs: any;
    emit: FormKitEvents<Props>;
    expose(exposed:{

    }): void;
    props:{

    }&Props;
    slots: Slots<Props>;
}

```


### FormKitSummaryMessage

**Type:** Interface

```
interface FormKitSummaryMessage {
    id: string;
    key: string;
    message: string;
    type: string;
}

```


### FormKitVuePlugin

**Type:** Interface

The global instance of the FormKit plugin.
```
interface FormKitVuePlugin {
    clearErrors: (formId: string) => void;
    get: (id: string) => FormKitNode | undefined;
    reset: (formId: string, resetTo?: unknown) => void;
    setErrors: (formId: string, errors: string[] | Record<string, string | string[]>, inputErrors?: string[] | Record<string, string | string[]>) => void;
    setLocale: (locale: string) => void;
    submit: (formId: string) => void;
}

```


### PluginConfigs

**Type:** Interface

Configuration for plugins
```
interface PluginConfigs {
    iconLoader: FormKitIconLoader;
    iconLoaderUrl: FormKitIconLoaderUrl;
    icons: Record<string, string | undefined>;
    inputs: FormKitLibrary;
    locale: string;
    locales: FormKitLocaleRegistry;
    messages: Record<string, Partial<FormKitLocale>>;
    rules: Record<string, FormKitValidationRule>;
    theme: string;
}

```


### DefaultConfigOptions

**Type:** Type

The allowed options for defaultConfig.
```
export type DefaultConfigOptions = FormKitOptions & Partial<PluginConfigs> & Record<string, unknown>;

```


### FormKitComponent

**Type:** Type

The TypeScript definition for the FormKit component.
```
export type FormKitComponent = <Props extends FormKitInputs<Props>>(props: Props & VNodeProps & AllowedComponentProps & ComponentCustomProps, context?: Pick<FormKitSetupContext<Props>, 'attrs' | 'emit' | 'slots'>, setup?: FormKitSetupContext<Props>) => VNode<RendererNode, RendererElement, {
    [key: string]: any;
}> & {
    __ctx?: FormKitSetupContext<Props>;
};

```


### Renderable

**Type:** Type

The types of values that can be rendered by Vue.
```
export type Renderable = null | string | number | boolean | VirtualNode;

```


### RenderableList

**Type:** Type

A list of renderable items.
```
export type RenderableList = Renderable | Renderable[] | (Renderable | Renderable[])[];

```


### RenderableSlot

**Type:** Type

A slot function that can be rendered.
```
export type RenderableSlot = (data?: Record<string, any>, key?: object) => RenderableList;

```


### RenderableSlots

**Type:** Type

An object of slots
```
export type RenderableSlots = Record<string, RenderableSlot>;

```


### Slots

**Type:** Type

The type definition for the FormKit's slots, this is not intended to be used directly.
```
export type Slots<Props extends FormKitInputs<Props>> = InputType<Props> extends keyof FormKitInputSlots<Props> ? FormKitInputSlots<Props>[InputType<Props>] : {};

```


### VirtualNode

**Type:** Type

The actual signature of a VNode in Vue.
```
export type VirtualNode = VNode<RendererNode, RendererElement, {
    [key: string]: any;
}>;

```

