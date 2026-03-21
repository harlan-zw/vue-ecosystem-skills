---
number: 6111
title: Change globalFilterFn at runtime?
category: "Q&A"
created: 2025-10-16
url: "https://github.com/TanStack/table/discussions/6111"
upvotes: 3
comments: 1
answered: false
---

# Change globalFilterFn at runtime?

I made a global filter input to my table with the option for the filter to be case sensitive or not:

<img width="518" height="120" alt="image" src="https://github.com/user-attachments/assets/a7a70888-6246-4fd5-993c-db36d894a117" />

Internally, this toggles a state from `includeString` to `includeStringSensitive` that is then passed to `useReactTable`.

...

---

## Top Comments

**@manimovassagh**:

The issue is that changing `globalFilterFn` doesn't trigger a re-filter because TanStack Table only recomputes the filtered row model when the `globalFilter` *value* or the `data` changes — not when the filter function reference changes.

The cleanest fix is to not swap function names at all. Instead, write a single custom filter function that reads the current mode from a ref or state:

```tsx
const [caseSensitive, setCaseSensitive] = useState(false)

const globalFilterFn: FilterFn<any> = useCallback((row, columnId, filterValue) => {
  const cellValue = String(row.getValue(columnId) ?? '')
  const search = String(filterValue)

  if (caseSensitive) {
    return cellValue.includes(search)
  }
  return cellValue.toLowerCase().includes(search.toLowerCase())
}, [caseSensitive])

...