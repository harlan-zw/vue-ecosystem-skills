---
number: 5995
title: "Why `useState` instead of `useRef`?"
category: "Q&A"
created: 2025-04-21
url: "https://github.com/TanStack/table/discussions/5995"
upvotes: 1
comments: 1
answered: false
---

# Why `useState` instead of `useRef`?

Are there any specific reasons that it uses `useState` for creating a `ref`-like object instead of using `useRef`?
react-table/src/index.ts

<img width="519" alt="截圖 2025-04-21 21 50 19" src="https://github.com/user-attachments/assets/37ef4a7d-c2bb-4814-aaad-b82d6af7da9b" />


---

## Top Comments

**@KevinVandy** [maintainer]:

It follows react's lint rules better. The other option is to mutate the ref during first render. This also somewhat guarantees that the table object is read only.