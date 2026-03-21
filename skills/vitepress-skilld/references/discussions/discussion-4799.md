---
number: 4799
title: "[data loader] load not being triggered by file watcher"
category: "Q&A"
created: 2025-06-21
url: "https://github.com/vuejs/vitepress/discussions/4799"
upvotes: 1
comments: 1
answered: true
---

# [data loader] load not being triggered by file watcher

Hi, it's me again.

I have the following glob that should watch my python files for changes: `../src/**/*.py`
My project is structured as follows:

```
docs/
├── .vitepress/
│   ├── cache/
│   ├── theme/
│   └── config.mts
├── components/
│   └── APIDoc.vue
├── api-examples.md
├── index.md
├── markdown-examples.md
├── python.data.ts <-- the data loader
└── python-api.md
src/
└── auto_docs/
    └── module1/
        ├── __init__.py
        ├── functions1.py
        ├── __init__.py
        └── py.typed
 ```

When I updated a vitepress file the watch does get triggered and it does show that the python files are being watched. However when I update a python file and save it the watch is not being triggered. What is causing this?

---

## Accepted Answer

**@brc-dd** [maintainer]:

vite doesn't watch files outside project root by default (`docs` directory in this case). You'll need to do something like this:

```ts
// docs/.vitepress/config.mts

import { fileURLToPath } from 'node:url'
import { defineConfig } from 'vitepress'

export default defineConfig({
  vite: {
    plugins: [
      {
        name: 'custom:watch-outside',
        configureServer(server) {
          server.watcher.add(fileURLToPath(new URL('../../src', import.meta.url)))
          // or maybe just server.watcher.add(process.cwd())
        }
      }
    ]
  }
})
```