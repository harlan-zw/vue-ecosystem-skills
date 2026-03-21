---
number: 4810
title: 使用 createContentLoader 进行页面 “归档” 时希望展示创建时间和修改时间
category: "Q&A"
created: 2025-06-24
url: "https://github.com/vuejs/vitepress/discussions/4810"
upvotes: 1
comments: 1
answered: true
---

# 使用 createContentLoader 进行页面 “归档” 时希望展示创建时间和修改时间

页面数量太多的时候等待数据获取的耗时非常久，有没有好的方法或者建议

```ts
const child = spawn(
    'git',
    [ 'log', '-1', '--pretty="%ci"', '--diff-filter=A', '--follow', basename(file) ],
    { cwd: dirname(file) },
  )
```

---

## Accepted Answer

**@brc-dd** [maintainer]:

You can try doing that in parallel. https://www.npmjs.com/package/p-map could work with some concurrency like 16 maybe.