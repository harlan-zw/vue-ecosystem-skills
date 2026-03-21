---
number: 4863
title: How to format lastUpdated
category: "Q&A"
created: 2025-07-29
url: "https://github.com/vuejs/vitepress/discussions/4863"
upvotes: 1
comments: 1
answered: false
---

# How to format lastUpdated

I want a `YYYY-MM-DD` format on date, I can't find an option for this purpose.
<img width="350" height="57" alt="image" src="https://github.com/user-attachments/assets/69aaff32-fc9c-42bc-b0bf-755a2b028bc0" />

```js
    lastUpdated: {
      text: 'Last updated',
      formatOptions: {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
        hourCycle: 'h23',
        forceLocale: true,
      },
    },
```

---

## Top Comments

**@brc-dd** [maintainer]:

What `lang` have you set in config? I think only a few locales have `-` as a separator (like en-CA). It's not possible to customize it much. Better to just leave it and it will show in whatever format the user has on their system.