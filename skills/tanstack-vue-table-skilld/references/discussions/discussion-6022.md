---
number: 6022
title: My custom sorting function doesnot work
category: "Q&A"
created: 2025-05-24
url: "https://github.com/TanStack/table/discussions/6022"
upvotes: 1
comments: 1
answered: false
---

# My custom sorting function doesnot work

Hi, I'm using table with custom sorting, passing the parameter 
``` sortingFns: {
                legendComparator: (rowA, rowB, columnId) => {
                    if (
                        rowA.original.type === 'Total' ||
                        rowB.original.type === 'Total' ||
                        rowA.original.type === 'GroupHeader' ||
                        rowB.original.type === 'GroupHeader'
                    ) {
                        return 0;
                    }

                    return legendRowsComparator(rowA.original, rowB.original, columnId as any);
                },
            },
 ```
 
 And using this sort at my columns:  
 
 ```
 export const ALIAS_COLUMN: ColumnDef<LegendRow> = {
    accessorKey: 'alias',
    header: 'Alias',
    enableSorting: true,
    size: 1000,
    maxSize: 1000,
    sortingFn: 'legendComparator', // usage
    cell: ({row}) => (isLegendDataRow(row.original) ? <RowCell row={row.original} /> : null),
};
```...

---

## Top Comments

**@Estasie**:

It looks I have found the solution. I did set    sortUndefined: false for my columns. So if u have service columns it might be useful!!!!