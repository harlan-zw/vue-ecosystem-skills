---
number: 4724
title: Multiple version site same domain
category: "Q&A"
created: 2025-04-26
url: "https://github.com/vuejs/vitepress/discussions/4724"
upvotes: 1
comments: 1
answered: true
---

# Multiple version site same domain

Hi,

I'm trying to make a site that has Stable and Beta documentation, with a branch selector/indicator in the navigation menu. I think all that's missing is for the navigation bar to be path based, similar to how the sidebar works. I've seen some plugins that's supposed to accomplish this, but I feel like there should be a simpler solution. I found something that looked promising in another discussion, but I'm not quite sure how to implement it.

https://github.com/vuejs/vitepress/discussions/2807

---

## Accepted Answer

**@brc-dd** [maintainer]:

Check out these maybe:

https://github.com/vuejs/vitepress/blob/main/__tests__/e2e/.vitepress/config.ts#L31-L45
https://github.com/vuejs/vitepress/blob/main/__tests__/e2e/.vitepress/theme/components/NavVersion.vue

We also have added an experimental feature in v2-alpha - additional configs. Check it out in action here - https://stackblitz.com/edit/vite-grah9mlj