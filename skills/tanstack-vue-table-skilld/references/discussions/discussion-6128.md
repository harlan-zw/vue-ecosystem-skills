---
number: 6128
title: Filter parent sub rows and display all children
category: "Q&A"
created: 2025-11-26
url: "https://github.com/TanStack/table/discussions/6128"
upvotes: 2
comments: 1
answered: false
---

# Filter parent sub rows and display all children

I'm using TanStack table's sub-rows feature to display nested rows below the main row. If a filter displays the parent row, I would like to have the child rows also be shown.

When I use the expanding CodeSandbox example, if I type "Woodrow" in the filter input, Woodrow is shown but the children are hidden. Instead, I would like all of the children to be shown.

<img width="177" height="198" alt="image" src="https://github.com/user-attachments/assets/3012135b-0f1c-4920-843d-f19c4b383f31" />

Is there a way to accomplish this?

---

## Top Comments

**@manimovassagh**:

Yes, you can achieve this with a custom `filterFn` that, when a parent matches the filter, automatically includes all its children.

The key is to write a filter function that checks whether the current row OR any of its ancestors match:

...