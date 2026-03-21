---
number: 4801
title: "pnpm run docs:build failing on Ubuntu 24.04 LTS"
category: "Q&A"
created: 2025-06-21
url: "https://github.com/vuejs/vitepress/discussions/4801"
upvotes: 1
comments: 2
answered: true
---

# pnpm run docs:build failing on Ubuntu 24.04 LTS

I am trying to get my local dev environment for vitepress.

I followed the contributing guide

This all works

```
$ pnpm install
$ pnpm run docs
```


but if I try to build the docs, it fails.

Any idea what I should change... I am using Node 18 from Ubuntu... so maybe I should use a newer NodeJS version.

```
$ pnpm run docs:build
```

I get this error 

...

---

## Accepted Answer

**@brc-dd** [maintainer]:

Hmm, which pnpm version are you using? Run `corepack enable` it should pick it up. Not sure why fs-extra wasn't installed.

The second error is because minimatch only supports Node 20+. Node 18 is EOL. 