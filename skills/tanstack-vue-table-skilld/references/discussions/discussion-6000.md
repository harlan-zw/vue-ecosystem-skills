---
number: 6000
title: How to select all sorted rows between currently selected and a given row?
category: "Q&A"
created: 2025-04-27
url: "https://github.com/TanStack/table/discussions/6000"
upvotes: 1
comments: 0
answered: false
---

# How to select all sorted rows between currently selected and a given row?

I have a sortable and filterable table with many rows. Selecting individual rows with `row.toggleSelected()` works fine. I want to implement a standard shift-select functionality, where clicking on a row, then shift clicking another row, selects all rows inbetween.

So how would I write the implementation of this function?
```typescript
const selectFromCurrentToRow = <TData>(table: Table<TData>, selectUpTo: Row<TData>) => {
  /* implementation */
}`
```

Note: I don't want to just select rows by ID between the currently selected row's ID and the newly selected one's, as they are _sorted and filtered_, so the rows displayed in the table go in some arbitrary sequence of IDs like `[ 12, 4, 15, 0, 5 ... ]`).