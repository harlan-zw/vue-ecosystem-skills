# formkit/addons

# @formkit/addons

## Introduction

Common, optional, first-party add on features for FormKit.

You can add this package by using `npm install @formkit/addons` or `yarn add @formkit/addons`.

## Functions

### createAutoAnimatePlugin()

**Type:** Function

Adds auto-animate to each input automatically:
#### Signature
```
createAutoAnimatePlugin(options?: AutoAnimateOptions, animationTargets?: Record<string, string[]>): FormKitPlugin;

```
#### Parameters
- `options` *optional* — AutoAnimateOptions
- `animationTargets` *optional* — A map of input types and an array of their sections that should be animated.
#### Returns
[FormKitPlugin](/api-reference/formkit-core#formkitplugin)
#### Examples
```
import { createApp } from 'vue'
import App from 'App.vue'
import { createAutoAnimatePlugin } from '@formkit/addons'
import { plugin, defaultConfig } from '@formkit/vue'

createApp(app).use(plugin, defaultPlugin({
  plugins: [
    createAutoAnimatePlugin({
      // optional config
      duration: 250,
      easing: 'ease-in-out',
      delay: 0,
    },
    {
      // optional animation targets object
      global: ['outer', 'inner'],
      form: ['form'],
      repeater: ['items'],
    })
  ]
}))

```


### createAutoHeightTextareaPlugin()

**Type:** Function

Creates a new auto-height textarea plugin.
#### Signature
```
createAutoHeightTextareaPlugin(): FormKitPlugin;

```
#### Returns
[FormKitPlugin](/api-reference/formkit-core#formkitplugin)


### createFloatingLabelsPlugin()

**Type:** Function

Creates a new floating label plugin.
#### Signature
```
createFloatingLabelsPlugin(FloatingLabelsOptions?: FloatingLabelsOptions): FormKitPlugin;

```
#### Parameters
- `FloatingLabelsOptions` *optional* — The options of [FloatingLabelsOptions](#floatinglabelsoptions) to pass to the plugin
#### Returns
[FormKitPlugin](/api-reference/formkit-core#formkitplugin)


### createLocalStoragePlugin()

**Type:** Function

Creates a new save-to-local-storage plugin.
#### Signature
```
createLocalStoragePlugin(localStorageOptions?: LocalStorageOptions): FormKitPlugin;

```
#### Parameters
- `localStorageOptions` *optional*
#### Returns
[FormKitPlugin](/api-reference/formkit-core#formkitplugin)


### createMultiStepPlugin()

**Type:** Function

Creates a new multi-step plugin.
#### Signature
```
createMultiStepPlugin(options?: MultiStepOptions): FormKitPlugin;

```
#### Parameters
- `options` *optional* — The options of [MultiStepOptions](#multistepoptions) to pass to the plugin
#### Returns
[FormKitPlugin](/api-reference/formkit-core#formkitplugin)


## TypeScript

### BeforeStepChange

**Type:** Interface

The typing for the beforeStepChange function.
```
interface BeforeStepChange {
    (data: BeforeStepChangeData): any;
}

```


### BeforeStepChangeData

**Type:** Interface

```
interface BeforeStepChangeData<T = unknown> {
    currentStep: FormKitFrameworkContext<T>;
    delta: number;
    nextStep: FormKitFrameworkContext<T>;
}

```


### FloatingLabelsOptions

**Type:** Interface

The options to be passed to [createFloatingLabelsPlugin](#createfloatinglabelsplugin)
```
interface FloatingLabelsOptions {
    useAsDefault?: boolean;
}

```


### FormKitMultiStepSlots

**Type:** Interface

```
interface FormKitMultiStepSlots<Props extends FormKitInputs<Props>> {
    badge: FormKitSlotData<Props, MultiStepSlotData&{
        step: FormKitFrameworkContext;
        index: number;
    }>;
    default: FormKitSlotData<Props, MultiStepSlotData>;
    multiStepOuter: FormKitSlotData<Props, MultiStepSlotData>;
    steps: FormKitSlotData<Props, MultiStepSlotData>;
    tab: FormKitSlotData<Props, MultiStepSlotData>;
    tabLabel: FormKitSlotData<Props, MultiStepSlotData&{
        step: FormKitFrameworkContext;
        index: number;
    }>;
    tabs: FormKitSlotData<Props, MultiStepSlotData>;
    validStepIcon: FormKitSlotData<Props, MultiStepSlotData&{
        step: FormKitFrameworkContext;
        index: number;
    }>;
    wrapper: FormKitSlotData<Props, MultiStepSlotData>;
}

```


### FormKitStepSlots

**Type:** Interface

```
interface FormKitStepSlots<Props extends FormKitInputs<Props>> {
    default: FormKitSlotData<Props, StepSlotData>;
    stepActions: FormKitSlotData<Props, StepSlotData>;
    stepInner: FormKitSlotData<Props, StepSlotData>;
    stepNext: FormKitSlotData<Props, StepSlotData>;
    stepPrevious: FormKitSlotData<Props, StepSlotData>;
}

```


### LocalStorageOptions

**Type:** Interface

The options to be passed to [createLocalStoragePlugin](#createlocalstorageplugin)
```
interface LocalStorageOptions {
    beforeLoad?: (payload: any) => any;
    beforeSave?: (payload: any) => any;
    control?: string;
    debounce?: number;
    key?: string | number;
    maxAge?: number;
    prefix?: string;
}

```


### MultiStepHandlers

**Type:** Interface

```
interface MultiStepHandlers {
    incrementStep: (delta: number, currentStep: FormKitFrameworkContext | undefined) => () => void;
    setActiveStep: (step: FormKitFrameworkContext) => (e?: Event) => void;
    showStepErrors: (step: FormKitFrameworkContext) => boolean | undefined;
    triggerStepValidations: (step: FormKitFrameworkContext) => void;
}

```


### MultiStepNodeAdditions

**Type:** Interface

Additional arguments that are added to the FormKitNode of a multistep input.
```
interface MultiStepNodeAdditions {
    goTo: (target: number | string) => void;
    next: () => void;
    previous: () => void;
}

```


### MultiStepOptions

**Type:** Interface

The options to be passed to [createMultiStepPlugin](#createmultistepplugin)
```
interface MultiStepOptions {
    allowIncomplete?: boolean;
    hideProgressLabels?: boolean;
    tabStyle?:'tab' | 'progress';
}

```


### MultiStepSlotData

**Type:** Interface

```
interface MultiStepSlotData {
    activeStep: string;
    allowIncomplete?: boolean;
    beforeStepChange?: BeforeStepChange;
    handlers: FormKitFrameworkContext['handlers']&MultiStepHandlers;
    hideProgressLabels: boolean;
    node: FormKitMultiStepNode;
    steps: Array<FormKitMultiStepSlotData>;
    tabStyle:'tab' | 'progress';
    validStepIcon: string | undefined;
}

```


### StepHandlers

**Type:** Interface

```
interface StepHandlers {
    incrementStep: (delta: number) => () => void;
    next: () => void;
    previous: () => void;
}

```


### StepSlotData

**Type:** Interface

Slot data unique to the step input.
```
interface StepSlotData {
    beforeStepChange?: BeforeStepChange;
    blockingCount: number;
    errorCount: number;
    handlers: FormKitFrameworkContext['handlers']&StepHandlers;
    hasBeenVisited: true | undefined;
    isActiveStep: boolean;
    isFirstStep: boolean;
    isLastStep: boolean;
    isValid: boolean;
    makeActive: () => void;
    nextAttrs?: Record<string, any>;
    nextLabel?: string;
    ordered: boolean;
    previousAttrs?: Record<string, any>;
    previousLabel?: string;
    showStepErrors: boolean;
    stepIndex: number;
    stepName: string;
    steps: Array<FormKitMultiStepSlotData>;
    totalErrorCount: number;
    validStepIcon?: string;
}

```


### FormKitMultiStepNode

**Type:** Type

The node type that is augmented with next and previous and goTo functions.
```
export type FormKitMultiStepNode = FormKitNode & MultiStepNodeAdditions;

```


### FormKitMultiStepSlotData

**Type:** Type

The typing for the slot data for a FormKit multi-step input.
```
export type FormKitMultiStepSlotData = FormKitFrameworkContext<Record<string, any>> & StepSlotData;

```

