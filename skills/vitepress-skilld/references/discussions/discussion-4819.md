---
number: 4819
title: 路径映射问题
category: "Q&A"
created: 2025-06-30
url: "https://github.com/vuejs/vitepress/discussions/4819"
upvotes: 1
comments: 1
answered: false
---

# 路径映射问题

我正在迁移老的文档框架 docsify 到 vitepress，但是路径的路由格式有很多差异。这会导致很多现有文档链接失效。

有没有办法可以自动将

```
https://xxx.com/#/foo/bar
```

路由到

```
https://xxx.com/foo/bar
```

确保一些现有的老链接也能正常访问到对应文档。

比如可以配置一个 url 映射的 map 集合，实现自动跳转。

---

## Top Comments

**@brc-dd** [maintainer]:

Inside `.vitepress/theme/index.ts` something like this could work:

```ts
import DefaultTheme from 'vitepress/theme'
import type { Theme } from 'vitepress'

const hashToRoute = {
  '/foo/bar': '/foo/bar'
}

export default {
  extends: DefaultTheme,
  enhanceApp({ router }) {
    router.onBeforeRouteChange = (to) => {
      const u = new URL(to, 'http://a.com')
      if (u.pathname === '/') {
        const route = hashToRoute[u.hash.slice(1)]
        if (route) window.location.href = route
      }
    }
  }
} satisfies Theme
```

See #4160