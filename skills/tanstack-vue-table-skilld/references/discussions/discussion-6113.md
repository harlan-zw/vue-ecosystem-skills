---
number: 6113
title: TanStack table causes weird re-render on window focus and resets cell input values to their old values
category: "Q&A"
created: 2025-10-17
url: "https://github.com/TanStack/table/discussions/6113"
upvotes: 1
comments: 1
answered: false
---

# TanStack table causes weird re-render on window focus and resets cell input values to their old values

I created my own data-table.tsx component that uses shadcn's and tanstack's table components. The table works fine, up until I discovered a very strange and infuriating bug, which is, when I write a value inside of a cell component and i refocus the window, the whole component re-renders for no known reason. I have tried to replace the custom input with a simple input, without any other events besides onChange, but no luck.
I have no idea what is causing this re-render but any help is greatly appreciated.

Below are the components at fault:

-- data-table.tsx
...

---

## Top Comments

**@BATCOH**:

Creating components inside components (nested components) will cause React to throw away the state of those nested components on each re-render of their parent.

You are creating the `GetRow` component **inside** the `DataTable` component.
Therefore, it is recreated and remounted (not just rerendered) every time `DataTable` is rendered.

You can use some memoisation (`const GetRow = useCallback(..., [])`) here, but it would be more correct to move it outside.

For such cases, there is a [react/no-unstable-nested-components rule for ESLint](https://github.com/jsx-eslint/eslint-plugin-rea...