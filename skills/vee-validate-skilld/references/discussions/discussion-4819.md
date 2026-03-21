---
number: 4819
title: "Error: No such validator 'VVTypedSchema' exists."
category: "Q&A"
created: 2024-07-18
url: "https://github.com/logaretm/vee-validate/discussions/4819"
upvotes: 1
comments: 2
answered: false
---

# Error: No such validator 'VVTypedSchema' exists.

Trying to use zod as a validator but it errors when using the "toTypedSchema" output as the form validate. Even using this demo code errors for me
https://vee-validate.logaretm.com/v4/integrations/zod-schema-validation#form-level-validation

Any ideas what I may be missing? Thanks in advance for any assistant

...

---

## Top Comments

**@scycer** (+1):

No sorry, we switched over to using yup as it turns out our internal UI component library was already using that under the hood so it was easier to continue with that

**@luisfgfurtado**:

Hey @scycer , I have the same problem. Did you manage to solve it?