---
number: 5031
title: "How to prevent `public/` directory being imported?"
category: "Q&A"
created: 2025-11-16
url: "https://github.com/vuejs/vitepress/discussions/5031"
upvotes: 1
comments: 1
answered: true
---

# How to prevent `public/` directory being imported?

Currently, I run vitepress in the root of repository where public folder exists. I don't want to include this directory.
I choose the root because I want to includes `README.md` as well as some document in the source code.

---

## Accepted Answer

**@brc-dd** [maintainer]:

Something like this should work:

```ts
// .vitepress/config.ts
import { defineConfig } from 'vitepress'

export default defineConfig({
  vite: {
    publicDir: false
  }
})
```