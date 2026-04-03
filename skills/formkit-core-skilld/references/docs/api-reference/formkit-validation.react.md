# formkit/validation

# @formkit/validation

## Introduction

The first-party validation package/plugin for FormKit. Read the validation documentation for usage instructions.

## Functions

### createMessageName()

**Type:** Function

Given a node, this returns the name that should be used in validation messages. This is either the `validationLabel` prop, the `label` prop, or the name of the input (in that order).
#### Signature
```
createMessageName(node: FormKitNode): string;

```
#### Parameters
- `node` — The node to display


### createValidationPlugin()

**Type:** Function

The actual validation plugin function. Everything must be bootstrapped here.
#### Signature
```
createValidationPlugin(baseRules?: FormKitValidationRules): (node: FormKitNode) => void;

```
#### Parameters
- `baseRules` *optional* — Base validation rules to include in the plugin. By default, FormKit makes all rules in the @formkit/rules package available via the defaultConfig.


### getValidationMessages()

**Type:** Function

Extracts all validation messages from the given node and all its descendants. This is not reactive and must be re-called each time the messages change.
#### Signature
```
getValidationMessages(node: FormKitNode): Map<FormKitNode, FormKitMessage[]>;

```
#### Parameters
- `node` — The FormKit node to extract validation rules from — as well as its descendants.


## TypeScript

### FormKitValidationHints

**Type:** Interface

Special validation properties that affect the way validations are applied.
```
interface FormKitValidationHints {
    blocking: boolean;
    debounce: number;
    force: boolean;
    name: string;
    skipEmpty: boolean;
}

```


### FormKitValidationMessage

**Type:** Interface

The interface for the localized validation message function.
```
interface FormKitValidationMessage {
    (...args: FormKitValidationI18NArgs): string;
}

```


### FormKitValidationMessages

**Type:** Interface

The interface for the localized validation message registry.
```
interface FormKitValidationMessages {
    [index: string]: string | FormKitValidationMessage;
}

```


### FormKitValidationRules

**Type:** Interface

FormKit validation rules are structured as on object of key/function pairs where the key of the object is the validation rule name.
```
interface FormKitValidationRules {
    [index: string]: FormKitValidationRule;
}

```


### FormKitValidation

**Type:** Type

Defines what fully parsed validation rules look like.
```
export type FormKitValidation = {
    rule: FormKitValidationRule;
    args: any[];
    timer: number;
    state: boolean | null;
    queued: boolean;
    deps: FormKitDependencies;
    messageObserver?: FormKitObservedNode;
} & FormKitValidationHints;

```


### FormKitValidationI18NArgs

**Type:** Type

The arguments that are passed to the validation messages in the i18n plugin.
```
export type FormKitValidationI18NArgs = [
    {
        node: FormKitNode;
        name: string;
        args: any[];
        message?: string;
    }
];

```


### FormKitValidationIntent

**Type:** Type

Defines what validation rules look like when they are parsed, but have not necessarily had validation rules substituted in yet.
```
export type FormKitValidationIntent = [string | FormKitValidationRule, ...any[]];

```


### FormKitValidationRule

**Type:** Type

Signature for a generic validation rule. It accepts an input — often a string — but should be able to accept any input type, and returns a boolean indicating whether or not it passed validation.
```
export type FormKitValidationRule = {
    (node: FormKitNode, ...args: any[]): boolean | Promise<boolean>;
    ruleName?: string;
} & Partial<FormKitValidationHints>;

```

