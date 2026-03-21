---
number: 5107
title: is there a reason why initialErrors in useForm requires all fields?
category: "Q&A"
created: 2026-01-10
url: "https://github.com/logaretm/vee-validate/discussions/5107"
upvotes: 1
comments: 1
answered: false
---

# is there a reason why initialErrors in useForm requires all fields?

i don't understand why useForm's initialErrors property in a typescript context insists on all fields being required.  For the life of me i can't convice the useForm composable to treat initialErrors as PARTIAL

```ts
  // form-login.vue
  
  const { defineField, errors, handleSubmit, setErrors } = useForm({
    initialErrors: {}, // TS Error:  Type '{}' is missing the following properties.....
    initialValues: { email: "", password: "" },
    name: "form-login",
    validationSchema: FormLoginSchema,
  });
  
  // form-login.schema.ts
  
  import z from "zod";

  export const FormLoginSchema = z.object({
    email: z.email({ error: "A valid email address is required." }),
    password: NonEmptyString({ error: "A password is required." }),
  });
```


---

## Top Comments

**@ismaildasci**:

this is because the type definition expects full object. you can fix it by casting:

```ts
const { defineField, errors, handleSubmit, setErrors } = useForm({
  initialErrors: {} as Partial<Record<keyof z.infer<typeof FormLoginSchema>, string>>,
  initialValues: { email: "", password: "" },
  name: "form-login",
  validationSchema: FormLoginSchema,
});
```

or just dont pass initialErrors if its empty:

```ts
const { defineField, errors, handleSubmit, setErrors } = useForm({
  initialValues: { email: "", password: "" },
  name: "form-login",
  validationSchema: FormLoginSchema,
});
```

...