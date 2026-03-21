---
number: 4907
title: Set configuration validate on useForm();
category: "Q&A"
created: 2024-10-23
url: "https://github.com/logaretm/vee-validate/discussions/4907"
upvotes: 2
comments: 0
answered: false
---

# Set configuration validate on useForm();

Hi all, is there any way to set validation configurations, e.g. validateOnValueUpdate, via useForm() composable?
Something like this:

```javascript
const { handleSubmit } = useForm<FormPayload>({
  validationSchema: // your schema validation,
  validateOnValueUpdate: false, // set this prop globally
});
```