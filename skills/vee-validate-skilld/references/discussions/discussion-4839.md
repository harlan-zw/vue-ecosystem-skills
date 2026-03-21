---
number: 4839
title: Validating Simple Array of Objects (v4)
category: "Q&A"
created: 2024-08-19
url: "https://github.com/logaretm/vee-validate/discussions/4839"
upvotes: 7
comments: 0
answered: false
---

# Validating Simple Array of Objects (v4)

Hello,

I apologize ahead of time if this question has been asked repeatedly, but I'm finding it difficult to get a clear cut answer for something I would think is a pretty common scenario.

I'll try to keep this as simple as possible as to maybe be helpful for anyone who comes across this.

In a project, you want to have a form to add multiple people by their first and last name. Using `vee-validate` and `zod`, we know the following:

- First and last name are strings,
- Both first and last name will not able able to be empty
- Both first and last name should only include alphabetical characters

So our schema will look like so to start:

```javascript
const schema = toTypedSchema(
  z.object({
    firstName: z.string().regex('^[A-zÀ-ž]+$'),
    lastName: z.string().regex('^[A-zÀ-ž]+$')
  })
);
```

Simple as. However we want to be able to add or remove potential people from a list, not just be able to add one at a time. So we now have the following:

```javascript
const schema = toTypedSchema(
  z.array(
    z.object({
      firstName: z.string().regex('^[A-zÀ-ž]+$'),
      lastName: z.string().regex('^[A-zÀ-ž]+$')
    })
  ).nonempty()
);
```

We now attach this to the `useForm` composable:

```javascript
const { errors } = useForm({
  validationSchema: schema,
  validateOnMount: false, // initial values will have empty key value pairs on mount
  initialValues: {
    people: [{ firstName: null, lastName: null }]
  }
});
```

...