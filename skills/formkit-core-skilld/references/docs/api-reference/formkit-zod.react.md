# formkit/zod

# @formkit/zod

## Introduction

The first-party zod package/plugin for FormKit. Read the [documentation](/plugins/zod) for usage instructions.

## Functions

### createZodPlugin()

**Type:** Function

Creates a new Zod schema plugin for form validation.
#### Signature
```
createZodPlugin<Z extends z.ZodTypeAny>(zodSchema: Z, submitCallback: (payload: z.infer<typeof zodSchema>, node: FormKitNode | undefined) => void | Promise<void>): [FormKitPlugin, (payload: any, node: FormKitNode | undefined) => void];

```
#### Parameters
- `zodSchema` — A Zod schema to validate the form against.
- `submitCallback` — A callback to run when the form is submitted and it passes validation.
#### Returns
A tuple of a [FormKitPlugin](/api-reference/formkit-core#formkitplugin) and a submit handler.

