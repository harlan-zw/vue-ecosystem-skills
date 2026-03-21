---
number: 6082
title: Sharing column definitions
category: "Q&A"
created: 2025-08-29
url: "https://github.com/TanStack/table/discussions/6082"
upvotes: 1
comments: 1
answered: false
---

# Sharing column definitions

My app has a bunch of tables that have similar columns, and I'm trying to ensure those columns look / behave identically across all tables. These definitions are bit involved, with custom headers and value displays, and it's very easy for me to make a change to that column definition in one table but forget to update other tables to match. So I want to extract that column definition to be reusable by multiple tables.

I'm stuck on making that definition type-safe. For instance, if I have a column called `resourceId` that's typed as `string | undefined`, then I could have something like:

```tsx
const columnResourceId: ColumnDef<{ resourceId: string | undefined }> = {
  accessorKey: 'resourceId',
  cell: info => <div>{info.row.original.resourceId}</div>,
  header: 'RESOURCE ID'
};
```...

---

## Top Comments

**@BATCOH**:

You can use creator function with type parameter:
```tsx
import { type ColumnDef } from "@tanstack/react-table";

interface MyTableData {
  name: string;
  resourceId: string | undefined;
}

function createResourceIdColumn<
  TData extends { resourceId: string | undefined },
>(): ColumnDef<TData> {
  const columnResourceId: ColumnDef<TData> = {
    accessorKey: "resourceId",
    cell: (info) => <div>{info.row.original.resourceId}</div>,
    header: "RESOURCE ID",
  };
  return columnResourceId;
}

const columns: Array<ColumnDef<MyTableData>> = [
  {
    accessorKey: "name",
    cell: (info) => <div>{info.row.original.name}</div>,
  },
  // No error here:
  createResourceIdColumn(),
];

```...