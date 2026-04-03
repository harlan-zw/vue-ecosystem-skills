# formkit/themes

# @formkit/themes

## Introduction

This package contains the official themes for FormKit. Read the installation documentation for more information.

## Functions

### createIconHandler()

**Type:** Function

Returns a function responsible for loading an icon by name.
#### Signature
```
createIconHandler(iconLoader?: FormKitIconLoader, iconLoaderUrl?: FormKitIconLoaderUrl): FormKitIconLoader;

```
#### Parameters
- `iconLoader` *optional* — a function for loading an icon when it's not found in the iconRegistry.
- `iconLoaderUrl` *optional* — a function that returns a remote URL for retrieving an SVG icon by name.


### createThemePlugin()

**Type:** Function

Creates the theme plugin based on a given theme name.
#### Signature
```
createThemePlugin(theme?: string, icons?: Record<string, string | undefined>, iconLoaderUrl?: FormKitIconLoaderUrl, iconLoader?: FormKitIconLoader): (node: FormKitNode) => any;

```
#### Parameters
- `theme` *optional* — The name or id of the theme to apply.
- `icons` *optional* — Icons you want to add to the global icon registry.
- `iconLoaderUrl` *optional* — A function that returns a remote url for retrieving an SVG icon by name.
- `iconLoader` *optional* — A function that handles loading an icon when it is not found in the registry.


### generateClasses()

**Type:** Function

A function to generate FormKit class functions from a JavaScript object.
#### Signature
```
generateClasses(classes: Record<string, Record<string, string>>): Record<string, string | FormKitClasses | Record<string, boolean>>;

```
#### Parameters
- `classes` — An object of input types with nested objects of sectionKeys and class lists.
#### Returns
An object of sectionKeys with class functions.


## TypeScript

### FormKitIconLoader

**Type:** Interface

A function that returns an icon SVG string.
```
interface FormKitIconLoader {
    (iconName: string): string | undefined | Promise<string | undefined>;
}

```


### FormKitIconLoaderUrl

**Type:** Interface

A function that returns a remote URL for retrieving an SVG icon by name.
```
interface FormKitIconLoaderUrl {
    (iconName: string): string | undefined;
}

```

