---
category: Browser
---

# useTextDirection

Reactive dir of the element's text.

## Usage

```ts
import { useTextDirection } from '@vueuse/core'

const dir = useTextDirection() // Ref<'ltr' | 'rtl' | 'auto'>
```

By default, it returns `rtl` direction when dir `rtl` is applied to the `html` tag, for example:

```html
<!--ltr-->
<html>
  ...
</html>

<!--rtl-->
<html dir="rtl">
  ...
</html>
```

## Options

```ts
import { useTextDirection } from '@vueuse/core'

const mode = useTextDirection({
  selector: 'body'
}) // Ref<'ltr' | 'rtl' | 'auto'>
```
