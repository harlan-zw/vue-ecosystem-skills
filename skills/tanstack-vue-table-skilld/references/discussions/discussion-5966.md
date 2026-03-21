---
number: 5966
title: "Global filter that also looks in the \"original\" object of the row"
category: "Q&A"
created: 2025-03-13
url: "https://github.com/TanStack/table/discussions/5966"
upvotes: 1
comments: 0
answered: false
---

# Global filter that also looks in the "original" object of the row

Hi!

I have a list of objects with a lot of keys. Many of them are not relevant to show as columns, but I  still want to use them when applying the global filter to filter the table.

I have created my own function for filtering but this function is called once per column. Is it possible to register a filter function that gets called once per row instead, or is there another way to go about it that I'm not seeing in the documentation?

My solution for now is that I set `enableGlobalFilter: false` on all columns _except one_, so that my filter function only gets called once per row. This is really hacky so I'm hoping there's a proper way to achieve this.