---
number: 5979
title: Table Custom Feature with useReactTable Initial State
category: "Q&A"
created: 2025-03-26
url: "https://github.com/TanStack/table/discussions/5979"
upvotes: 1
comments: 1
answered: false
---

# Table Custom Feature with useReactTable Initial State

I was following the Guidelines for creating Custom Features, but it seems like when creating a custom feature, the new features does not propagate to `table.initialState` configurations. This means that the only way to leverage the Density State in this example, would be through `table.state` and it's associated `onChangeFn`. 

If you take a look at the sandbox: https://tanstack.com/table/v8/docs/framework/react/examples/custom-features?panel=sandbox, and you attempt to apply `initialState: { density: "md" }` you will get a type-error.

I thought it might have been that I need to extend `CompleteInitialTableState` with `DensityTableState` but that did not resolve my issue.

Any guidance? Thank you!

---

## Top Comments

**@thewebartisan7** (+1):

I have the same issue, and I solve it using:


declare module '@tanstack/react-table' {
    // eslint-disable-next-line @typescript-eslint/no-empty-object-type
    interface InitialTableState extends DensityTableState {}
}

