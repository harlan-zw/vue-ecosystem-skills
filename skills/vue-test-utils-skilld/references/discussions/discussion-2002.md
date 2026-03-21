---
number: 2002
title: Mount .tsx component
category: "Q&A"
created: 2023-03-10
url: "https://github.com/vuejs/test-utils/discussions/2002"
upvotes: 2
comments: 2
answered: true
---

# Mount .tsx component

Hi all

How can I mount a **.tsx component** using @vue/test-utils?

Used:
vitest latest
vue latest
@vue/test-utils latest

**It was found:**
If **defineComponent** is not used in the .tsx component, then the test does not fail.

File:


Error:



---

## Accepted Answer

**@cexbrayat** [maintainer]:

It should work out of the box. Try to generate a project with create-vue and pick the TypeScript/JSX support to see how it is configured. If you think you found an issue, please add a reproduction so we can take a look (you can build one in a few minutes online with Stackblitz https://stackblitz.com/fork/github/vitest-dev/vitest/tree/main/examples/vue?initialPath=__vitest__ )