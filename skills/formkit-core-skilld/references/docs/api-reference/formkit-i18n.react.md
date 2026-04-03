# formkit/i18n

# @formkit/i18n

## Introduction

The official FormKit internationalization (i18n) plugin. This package contains the locales and the plugin that integrates FormKit with these locales. Read the internationalization documentation for usage instructions.

## Functions

### createI18nPlugin()

**Type:** Function

Create a new internationalization plugin for FormKit.
#### Signature
```
createI18nPlugin(registry: FormKitLocaleRegistry): FormKitPlugin;

```
#### Parameters
- `registry` — The registry of [FormKitLocales](/api-reference/formkit-i18n#formkitlocaleregistry).
#### Returns
[FormKitPlugin](/api-reference/formkit-core#formkitplugin)


### date()

**Type:** Function

Given a string or a date, return a nice human-readable version.
#### Signature
```
date(date: string | Date): string;

```
#### Parameters
- `date` — A string or a date.
#### Returns
`string`


### list()

**Type:** Function

Creates an oxford-comma separated list of items.
#### Signature
```
list(items: string[], conjunction?: string): string;

```
#### Parameters
- `items` — the items to list out.
- `conjunction` *optional* — in the list "x, y, and z", "and" is the conjunction. Defaults to "or".
#### Returns
`string`


### order()

**Type:** Function

Orders two variables from smallest to largest.
#### Signature
```
order(first: string | number, second: string | number): [smaller: number | string, larger: number | string];

```
#### Parameters
- `first` — The first number or string.
- `second` — The second number or string.
#### Returns
`[smaller: number | string, larger: number | string]`


### sentence()

**Type:** Function

Given a string, convert it to sentence case.
#### Signature
```
sentence(str: string): string;

```
#### Parameters
- `str` — The string to sentence case.
#### Returns
`string`


## TypeScript

### FormKitLocale

**Type:** Interface

A locale is just a collection of locale message registries, they are keyed by the type (like a namespace) ex: "validation" or "ui". Plugin authors can declare their own types too.
```
interface FormKitLocale {
    [index: string]: FormKitLocaleMessages;
    ui: FormKitLocaleMessages;
}

```


### FormKitLocaleMessages

**Type:** Interface

A registry of locale messages — this is a keyed/value object with string keys (message name) and either string values (for simple returns) or functions that receive a context object.
```
interface FormKitLocaleMessages {
    [index: string]: string | ((...args: any[]) => string);
}

```


### FormKitLocaleRegistry

**Type:** Interface

The locale registry is just a key-value pair of locale indexes ('ar', 'en', 'it', etc.) to their respective locales.
```
interface FormKitLocaleRegistry {
    [index: string]: FormKitLocale;
}

```

