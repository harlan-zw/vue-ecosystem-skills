---
number: 5098
title: "how to use `label` (and equation numbers) in math equations (mathjax3)"
category: "Q&A"
created: 2026-01-21
url: "https://github.com/vuejs/vitepress/discussions/5098"
upvotes: 1
comments: 2
answered: true
---

# how to use `label` (and equation numbers) in math equations (mathjax3)

is `mathjax3` supposed to work with things like ?

```md
This is a simple 

$$x=0\label{eq:a}$$

so that now I can reference this as $\eqref{eq:a}$. Right? 
```

and should render a number to the right, which is the `tag` for that equation. But some reason I don't seem to get it to work.

In my `config.mts` file I have:

```
import mathjax3 from "markdown-it-mathjax3";

export default defineConfig({
markdown: {
    math: true,
    config(md) {
      md.use(mathjax3, { tex: { tags: 'ams' } }),
    },
  },
})
```

---

## Accepted Answer

**@brc-dd** [maintainer]:

It should be something like this:

```md
This is a simple

$$
\begin{equation}
x=0 \label{eq:a}
\end{equation}
$$

so that now I can reference this as $\eqref{eq:a}$. Right?
```

https://stackblitz.com/edit/vite-lhdnrmuz?file=docs/.vitepress/config.ts,docs/.vitepress/theme/index.ts,docs/index.md

Not sure if it's possible to write without equation environment, because your syntax will need passing the leading and trailing `$$` to mathjax too, but the plugins usually only pass the content.