---
number: 1831
title: How can I test action in vuex with vue-test-utils and jest when this actions uses a globalProperties?
category: "Q&A"
created: 2022-10-25
url: "https://github.com/vuejs/test-utils/discussions/1831"
upvotes: 1
comments: 1
answered: true
---

# How can I test action in vuex with vue-test-utils and jest when this actions uses a globalProperties?

I'm really new at testing with vue-test-utis/jest, but I've stumbled upon an issue that I'm not sure how to test it. Could someone help me? I have an action in my store that uses a globalProperties and when I try to use it in tests it's not working.

Basically this is my test:

   ```
 describe('test: actions', () => {
    
        it('buildReservationsTableData', () => {
            let data = actions.buildReservationsTableData(mockDataBefore);
            expect(data).toEqual(tableData);
        })
    
    })
```
And this is the action that I'm trying to write a test:

...

---

## Accepted Answer

**@freakzlike** [maintainer]:

You are testing your vuex action without a component. On this case there is no need for `@vue/test-utils` as this is just plain javascript. Where does `global.dashboards` coming from outside of your test environment?