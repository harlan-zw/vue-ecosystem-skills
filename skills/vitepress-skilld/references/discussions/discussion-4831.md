---
number: 4831
title: Best way to retrieve frontmatter from the next page
category: "Q&A"
created: 2025-07-07
url: "https://github.com/vuejs/vitepress/discussions/4831"
upvotes: 1
comments: 1
answered: true
---

# Best way to retrieve frontmatter from the next page

I'm looking to assess the frontmatter of an incoming page using the `useRouter` and `useData` composables, but I'm unable to access it before the route change actually occurs. If anyone has suggestions on how to achieve this, please feel free to share.

Additionally, if you know a method to load the HTML content of the next page, that would be very helpful! Thank you very much in advance

---

## Accepted Answer

**@brc-dd** [maintainer]:

Hmm page is loaded after route change. So, hard to get it that way. Maybe you can extract the relevant data to a separate file (maybe createContentLoader) and do something like this:

```ts
// .vitepress/theme/index.ts

import type { Theme } from 'vitepress'
import DefaultTheme from 'vitepress/theme'
import { data } from '../../frontmatter.data.js'

export default {
  extends: DefaultTheme,
  enhanceApp({ router }) {
    router.onBeforeRouteChange = (to) => {
     const frontmatter = data[to]
    }
  }
} satisfies Theme
```