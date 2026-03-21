---
number: 6104
title: How can I limit resizer translateX position with deltaOffset if a column has maxSize?
category: "Q&A"
created: 2025-10-03
url: "https://github.com/TanStack/table/discussions/6104"
upvotes: 1
comments: 0
answered: false
---

# How can I limit resizer translateX position with deltaOffset if a column has maxSize?

Is there a way to prevent resizer from going beyond the column's size limit if I'm using onEnd? I tried to limit deltaOffset but I couldn't find a way to understand what kind of column size I would end up with after the resize is applied. My idea was to use something like min(deltaOffset, maxSize - currentSize), but I could not find an API to access column's max size, am I missing something?

That's what I'm talking about, I'm trying to prevent resizer from being moved too far from max size

```
<div
  @dblclick="() => header.column.resetSize()"
  @mousedown="(e) => header.getResizeHandler()(e)"
  @touchstart="(e) => header.getResizeHandler()(e)"
  :style="{
  position: 'absolute',
  right: 0,
  top: 0,
  bottom: 0,
  zIndex: 10,
  width: '6px',
  height: '100%',
  backgroundColor: 'red',
  transform: header.column.getIsResizing() ? `translateX(${table.getState().columnSizingInfo.deltaOffset}px)` : '',
  }"
 ></div>
						```...