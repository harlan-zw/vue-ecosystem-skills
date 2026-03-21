---
number: 5086
title: How is the support for Zod 4?
category: "Q&A"
created: 2025-09-27
url: "https://github.com/logaretm/vee-validate/discussions/5086"
upvotes: 2
comments: 2
answered: false
---

# How is the support for Zod 4?

I was just using Vee-validate and although it worked the day before, I received this error

```js
# npm resolution error report

While resolving: @vee-validate/zod@4.15.1
Found: zod@4.1.11
node_modules/zod
  zod@"^4.1.11" from the root project

Could not resolve dependency:
peer zod@"^3.24.0" from @vee-validate/zod@4.15.1
node_modules/@vee-validate/zod
  @vee-validate/zod@"^4.15.1" from the root project

Conflicting peer dependency: zod@3.25.76
node_modules/zod
  peer zod@"^3.24.0" from @vee-validate/zod@4.15.1
  node_modules/@vee-validate/zod
    @vee-validate/zod@"^4.15.1" from the root project

Fix the upstream dependency conflict, or retry
this command with --force or --legacy-peer-deps
to accept an incorrect (and potentially broken) dependency resolution.
```
...

---

## Top Comments

**@awacode21**:

I am having the same problem. I saw this issue: https://github.com/logaretm/vee-validate/issues/5027 but it is closed. But don't know why it got closed, it is still not working, isn't it?

**@awacode21**:

It looks like it should be supported with this version: https://github.com/logaretm/vee-validate/releases/tag/v5.0.0-beta.0