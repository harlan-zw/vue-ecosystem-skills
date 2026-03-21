---
number: 5992
title: "Purpose of `manualSorting: true` if `getSortedRowModel` is unset"
category: "Q&A"
created: 2025-04-18
url: "https://github.com/TanStack/table/discussions/5992"
upvotes: 1
comments: 1
answered: true
---

# Purpose of `manualSorting: true` if `getSortedRowModel` is unset

Is there any significance to setting `manualSorting: true` if I'm already not passing `getSortedRowModel`?

---

## Accepted Answer

I ended up digging through the codebase and it seems like this is the only use of manualSorting. Thus, `manualSorting: true` and an unset `getSortedRowModel` does the same thing 

https://github.com/TanStack/table/blob/66fbe3a74b129e700e4667d1d5e1b29dd0a7b723/packages/table-core/src/features/RowSorting.ts#L535-L537