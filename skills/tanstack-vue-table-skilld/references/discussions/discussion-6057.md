---
number: 6057
title: How can I avoid removing empty filters entirely?
category: "Q&A"
created: 2025-07-16
url: "https://github.com/TanStack/table/discussions/6057"
upvotes: 1
comments: 1
answered: false
---

# How can I avoid removing empty filters entirely?

For my company's table UX, we want to make filters configurable outside the table itself via a menu system. This is similar to filter "pills" which can be added by selecting a column name to filter on. They are initialized with a default empty value, and the user can immediately add a more meaningful filter value in the menu. Removal of filters happens in this menu as well, by explicit action from the user.

I can't figure out how to achieve this with Tanstack Table's filter system, even after I overrode all built-in `filterFn` options with versions that have `.autoRemove = () => false;`. So I dug into the source and found this. It appears that the l...

---

## Top Comments

**@grant-progress**:

FWIW, since I'm integrating this as the underlying table solution for a shared design system package, I just ended up bailing out of the built-in filtering and wrapping the tools with my own filtering state solution. Not particularly difficult to do and gives the adaptability I needed. I think that's perfectly fine (and it's nice that it's easy to bail out like this), but I do still think the filter removal behavior is a bit too opinionated as the internal behavior.