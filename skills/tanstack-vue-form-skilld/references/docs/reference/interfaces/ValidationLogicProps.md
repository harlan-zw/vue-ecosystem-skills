---
id: ValidationLogicProps
title: ValidationLogicProps
---

# Interface: ValidationLogicProps

Defined in: packages/form-core/src/ValidationLogic.ts:20

## Properties

### event

```ts
event: object;
```

Defined in: packages/form-core/src/ValidationLogic.ts:28

#### async

```ts
async: boolean;
```

#### fieldName?

```ts
optional fieldName: string;
```

#### type

```ts
type: "change" | "blur" | "submit" | "mount" | "server";
```

***

### form

```ts
form: AnyFormApi;
```

Defined in: packages/form-core/src/ValidationLogic.ts:22

***

### runValidation()

```ts
runValidation: (props) => void;
```

Defined in: packages/form-core/src/ValidationLogic.ts:33

#### Parameters

##### props

###### form

[`AnyFormApi`](../type-aliases/AnyFormApi.md)

###### validators

(
  \| [`ValidationLogicValidatorsFn`](ValidationLogicValidatorsFn.md)
  \| `undefined`)[]

#### Returns

`void`

***

### validators

```ts
validators: 
  | FormValidators<any, any, any, any, any, any, any, any, any, any>
  | null
  | undefined;
```

Defined in: packages/form-core/src/ValidationLogic.ts:24
