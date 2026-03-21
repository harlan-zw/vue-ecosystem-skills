---
number: 4797
title: How to render imported text as markdown?
category: "Q&A"
created: 2025-06-21
url: "https://github.com/vuejs/vitepress/discussions/4797"
upvotes: 1
comments: 1
answered: true
---

# How to render imported text as markdown?

Hi, 

I am working on a data loader that extract markdown documentation from a Python module. My data loader simply executes some python and returns a string that is markdown.

How would I go about actually rendering this as markdown and not as raw text?



Things like `###` aren't resolved to markdown/ html like I would them to be.

---

## Accepted Answer

**@brc-dd** [maintainer]:

https://github.com/vuejs/vitepress/discussions/2921#discussioncomment-7023589

You can use dynamic routes too - https://vitepress.dev/guide/routing#dynamic-routes

https://stackblitz.com/edit/vite-mltkoqpq?file=docs/%5Bslug%5D.md,docs/%5Bslug%5D.paths.ts (uses vitepress v2-alpha. dynamic routes and loaders are fully stable there. v1 had some bugs)