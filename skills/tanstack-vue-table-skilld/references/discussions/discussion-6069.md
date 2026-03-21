---
number: 6069
title: Column visibility - hidden by default
category: "Q&A"
created: 2025-08-05
url: "https://github.com/TanStack/table/discussions/6069"
upvotes: 1
comments: 1
answered: false
---

# Column visibility - hidden by default

```ts
    column.getIsVisible = () => {
      const childColumns = column.columns
      return (
        (childColumns.length
          ? childColumns.some(c => c.getIsVisible())
          : table.getState().columnVisibility?.[column.id]) ?? true
      )
    }
 ```
 
 This is the api that defines whether column is  visible.
 I want to make all the columns hidden by default, meaning it will be visible only there is an attribute with value 'true' in provided columnVisibility object. Is there a way to override this api? 

---

## Top Comments

**@manimovassagh**:

Yes, you can do this by initializing `columnVisibility` with all columns set to `false`, then explicitly setting only the ones you want visible to `true`.

```tsx
// Build initial visibility state with all columns hidden
const initialVisibility = Object.fromEntries(
  columns.map((col) => [col.id ?? col.accessorKey, false])
)

const [columnVisibility, setColumnVisibility] = useState<VisibilityState>({
  ...initialVisibility,
  // Only these columns are visible:
  name: true,
  email: true,
})

...