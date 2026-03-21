---
number: 5038
title: "useForm, defineFields and resetForm create many meta updates"
category: "Q&A"
created: 2025-05-08
url: "https://github.com/logaretm/vee-validate/discussions/5038"
upvotes: 1
comments: 1
answered: true
---

# useForm, defineFields and resetForm create many meta updates

I have a regular useForm with schema validation and a lot of fields with defineFields.
I resetForm when I have the form data response from the api. everything looks ok, except for a single field.
I get something like
```
initialValue: Reactive
➤  currentValue: Reactive
```
so that the initalValue is not the same as the currentValue.
I can't figure out why that is. I put a watcher on the inital values for useform and that looked like

```
undefined
undefined
➤ Proxy
➤ Proxy
➤ Proxy
```

I have no idea why it is setting the initial value 6 times when I only have useForm initialization and one resetForm.
Is there any way to debug into the setting of inital values or something? 

---

## Accepted Answer

Ok found the error after checking the validation schema. I had a placeholder for that value like `z.object({})` that did show up as empty in the inital values which is probably true if parsed but later the object works as is and it shows as valid but also as dirty.
after fixing the schema it shows up correctly as valid and not diry