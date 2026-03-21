---
number: 6014
title: Inconsistent filtering functionality
category: "Q&A"
created: 2025-05-20
url: "https://github.com/TanStack/table/discussions/6014"
upvotes: 1
comments: 0
answered: false
---

# Inconsistent filtering functionality

When using client side filtering I need a way to both toggle row selections and check the row selections for filtered rows but `table.getIsSomeRowsSelected()` & `table.getIsAllRowsSelected()` both consider all rows in the table ignoring filtering while `table.toggleAllRowsSelected()` toggles only rows that are filtered in. This is both inconsistent and lacks the capabilities I need.

Am I using the following, any help would be appreciated.

...