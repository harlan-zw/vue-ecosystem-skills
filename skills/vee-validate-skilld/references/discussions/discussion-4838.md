---
number: 4838
title: how to handle v-if field in vee-validate 4
category: "Q&A"
created: 2024-08-14
url: "https://github.com/logaretm/vee-validate/discussions/4838"
upvotes: 4
comments: 2
answered: false
---

# how to handle v-if field in vee-validate 4

I have a form that changes dynamically with v-if according to user choice, how can I validate only the shown form?

---

## Top Comments

**@w20k**:

Hey @fahmi-nugroho, 

If you use schema validators like zod, yup or valibot - it should be easy :) And without them should be not that hard, but haven't used that. So, not sure I'm right person to help you with that, but if you could provide code, maybe we could figure it out.

I think, it should be fairly simple if you're doing it with `:help` or something.

**@jsodeman**:

As far as I can tell you have to put the schema in a computed and then alter the schema to not require the hidden fields. I'm hoping to find out that there's an alternative and came here looking for one.