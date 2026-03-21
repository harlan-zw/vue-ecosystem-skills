---
number: 1913
title: "Question: How to use a real Transition component?"
category: "Q&A"
created: 2022-12-14
url: "https://github.com/vuejs/test-utils/discussions/1913"
upvotes: 1
comments: 6
answered: true
---

# Question: How to use a real Transition component?

**Describe the bug**
I create a dialog which need to watch props to make the transition happen. Unfortunately the transition not triggering because the data which need to be updated by watch not updated.

**To Reproduce**
https://stackblitz.com/edit/vitest-dev-vitest-h26bhi?initialPath=__vitest__

**Expected behavior**
VTU render the component inside transition

**Related information:**

```
System:
OS: Windows 10 10.0.22000
CPU: (4) x64 Intel(R) Core(TM) i3-8145U CPU @ 2.10GHz
Memory: 2.25 GB / 7.86 GB
npmPackages:
@vue/test-utils: ^2.2.0 => 2.2.0
vitest: ^0.24.3 => 0.24.3
vue: ^3.2.45 => 3.2.45
```


---

## Accepted Answer

**@cexbrayat** [maintainer]:

Ha OK. It's not a problem with the watcher then. It's because your test uses a transition mock (this is the case by default in VTU), and that mock won't emit events like `afterEnter`. You can try to use:
```
global: {  
  stubs: {
    transition: false
  }
}
```
to use the real transition component, but then you'll have to trigger the next frame for the animation to finish. If I remember correctly, you can mock `requestAnimationFrame` to do so with something like:

```
vi.spyOn(window, 'requestAnimationFrame').mockImplementation(cb => cb())
```

So something like this works:

```ts
  it('should set width based on props', async () => {
    vi.spyOn(window, 'requestAnimationFrame').mockImplementation(cb => cb());
    const wrapper = mount(Dialog, {
      props: {
        width: '400px',
      },
      global: {
        stubs: {
          transition: false
        }
      }
    });

    await wrapper.setProps({ modelValue: true });

    console.log(wrapper.html());

    expect(wrapper.get('.dialog').attributes('style')).toBe('width: 400px;');
  });
```...