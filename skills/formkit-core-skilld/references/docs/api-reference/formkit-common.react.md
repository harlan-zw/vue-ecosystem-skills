# formkit/common

# @formkit/common

## Introduction

Common types and utilities shared across FormKit packages.

## TypeScript

### FormKitLibrary

**Type:** Interface

The full library of available FormKit inputs.
#### Signature
```
interface FormKitLibrary {
    [index: string]: FormKitTypeDefinition;
}

```


### FormKitTypeDefinition

**Type:** Type

Definition of a library item — when registering a new library item, these are the required and available properties.
#### Signature
```
type FormKitTypeDefinition = {
    type: FormKitNodeType;
    schema: FormKitSchemaNode[] | FormKitSchemaCondition;
};

```

