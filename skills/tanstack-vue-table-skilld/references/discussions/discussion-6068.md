---
number: 6068
title: Testing the tanStack table with cypress
category: "Q&A"
created: 2025-08-04
url: "https://github.com/TanStack/table/discussions/6068"
upvotes: 1
comments: 1
answered: false
---

# Testing the tanStack table with cypress

Hello, 

I'm using TanStack Table in a React project and I want to write end-to-end tests using Cypress framework. My questions are:


**Questions:**
- How can I test that the table is scrollable (e.g., when the content overflows)? I tried to simulate the scroll action using the _scrollTo_ function 

`cy.get('.sidebar').scrollTo('bottom')`
but it does not work, as the table is not a scrollable element. 

- I tried to verify that the user can actually resize the element (a column in the table) and that the size changes after interaction. I used 
```
  cy.get('[data-testid="column"]')
    .trigger('mousedown', { which: 1 })
    .trigger('mousemove', { clientX: 300 })
    .trigger('mouseup');
```
but I don't think that these events are triggered, as there is no change detect...

---

## Top Comments

**@manimovassagh**:

A few things to address here:

**Scrolling**

TanStack Table itself doesn't render a scrollable container — that's your CSS. The table is just a `<table>` (or divs), so you need to target the actual scrollable wrapper, not the table element.

If you're using a virtualized setup, you likely have a wrapping div with `overflow: auto`. Target that:

```js
// Find the scrollable container (adjust selector to match your layout)
cy.get('[data-testid="table-container"]').scrollTo('bottom')

// Or if you're using a common pattern with a div wrapper:
cy.get('.table-wrapper').scrollTo('bottom')
```

...