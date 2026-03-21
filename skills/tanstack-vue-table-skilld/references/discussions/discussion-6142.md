---
number: 6142
title: "Does the \"auto\" sorting strategy work as intended? What is the spec?"
category: "Q&A"
created: 2026-01-07
url: "https://github.com/TanStack/table/discussions/6142"
upvotes: 1
comments: 1
answered: false
---

# Does the "auto" sorting strategy work as intended? What is the spec?

While checking the behavior of the `auto` strategy, I found that the current behavior is

1. If total number of rows is less than 11 -> `basic`
2. More than 10 and 11th and onwards rows have numeric char -> `alphanumeric`
3. More than 10 and 11th and onwards rows don't have any numeric char -> `text`

I kind of felt it's a little weird, and after checking the code base I noticed that `.slice(10)` is used even the variable is named `firstRows`.

https://github.com/TanStack/table/blob/e172109fca4cc403a07236ed8fa103450ceba5e9/packages/table-core/src/features/RowSorting.ts#L308

I wonder if it's intended to get first 10 rows (`.slice(0, 10)`)

---

## Top Comments

**@sunnypatell**:

@mtsmfm yes, this is a confirmed bug. `.slice(10)` skips the first 10 rows and samples everything after, which is the opposite of the intent. the variable is even named `firstRows`.

**git history**: it was originally introduced as `.slice(100)` in commit `2367a67` (march 2022), then changed to `.slice(10)` in `3a49e91` (may 2022). it was always wrong since the beginning, the fix to `10` just made the sample size larger (everything after row 10) instead of sm...