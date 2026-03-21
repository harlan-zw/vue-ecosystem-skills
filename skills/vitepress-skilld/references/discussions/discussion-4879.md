---
number: 4879
title: How to make useData() reactive with page change?
category: "Q&A"
created: 2025-08-02
url: "https://github.com/vuejs/vitepress/discussions/4879"
upvotes: 1
comments: 2
answered: true
---

# How to make useData() reactive with page change?

At the end of each page, I want to link all other pages (except the current one).

I made an `AllArticles` component that I put in my layout:

```
<template>
    <Layout>
        <template #doc-bottom>
            <AllArticles/>
        </template>
    </Layout>
</template>

<script setup>
import DefaultTheme from 'vitepress/theme'
import AllArticles from './AllArticles.vue';
const Layout = DefaultTheme.Layout;
</script>
```

```
<template>
    <ArticleGroup title="Other articles" :articles="otherArticles.filter(article => article.url !== currentPagePath)"/>
</template>


<script setup>
import { useData } from 'vitepress';

const data = useData();

const page = data.page.value;
let currentPagePath = page.relativePath.replace(".md", "");

...

---

## Accepted Answer

**@brc-dd** [maintainer]:

Use `computed` (https://vuejs.org/guide/essentials/computed.html)

Something like this might work:

```ts
const { page } = useData()
const currentPagePath = computed(() => page.value.relativePath.replace('.md', ''))
```