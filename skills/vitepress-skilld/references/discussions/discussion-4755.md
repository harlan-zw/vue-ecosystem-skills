---
number: 4755
title: Adding a custom language with Shiki crashes
category: "Q&A"
created: 2025-05-21
url: "https://github.com/vuejs/vitepress/discussions/4755"
upvotes: 1
comments: 1
answered: true
---

# Adding a custom language with Shiki crashes

Adding a custom language to shiki, i'm getting this error: 
```
Language `Nymph` is not included in this bundle. You may want to load it from external source.
ShikiError: Language `Nymph` is not included in this bundle. You may want to load it from external source.
    at resolveLang (file:///home/theonlytails/IdeaProjects/nymph_lang/node_modules/.pnpm/@shikijs+core@2.5.0/node_modules/@shikijs/core/dist/index.mjs:1915:17)
    at file:///home/theonlytails/IdeaProjects/nymph_lang/node_modules/.pnpm/@shikijs+core@2.5.0/node_modules/@shikijs/core/dist/index.mjs:1932:52
    at Array.map (<anonymous>)
    at createHighlighter (file:///home/theonlytails/IdeaProjects/nymph_lang/node_modules/.pnpm/@shikijs+core@2.5.0/node_modules/@shikijs/core/dist/index.mjs:1932:41)
```
This is the gramma...

---

## Accepted Answer

**@brc-dd** [maintainer]:

Override the language name to lowercase - https://stackblitz.com/edit/vite-3me9w4sq?file=docs/index.md,docs/.vitepress/config.ts

Case used in fence block is ignored, so both ` ```Nymph ` and ` ```nymph ` will work fine as long as language.name is in lowercase.