---
outline: deep
---

# استفاده از یک تم سفارشی {#using-a-custom-theme}

## Resolve کردن تم {#theme-resolving}

میتوانید با ایجاد یک فایل `.vitepress/theme/index.js` یا `.vitepress/theme/index.ts` (فایل ورودی تم) تم سفارشی را فعال کنید:

```
.
├─ docs                # ریشه پروژه
│  ├─ .vitepress
│  │  ├─ theme
│  │  │  └─ index.js   # ورودی تم
│  │  └─ config.js     # فایل پیکربندی
│  └─ index.md
└─ package.json
```

وقتی ویتپرس حضور یک فایل ورودی تم را شناسایی کند، همواره از تم سفارشی به جای تم پیشفرض استفاده میکند. با این حال، شما میتوانید [تم پیشفرض را گسترش دهید](./extending-default-theme) تا سفارشیسازیهای پیشرفتهتری را روی آن اعمال کنید.

## رابط تم {#theme-interface}

یک تم سفارشی ویتپرس به عنوان یک شی تعریف میشود که شامل رابط زیر است:

```ts
interface Theme {
  /**
   * کامپوننت لایهی ریشه برای هر صفحه
   * @required
   */
  Layout: Component
  /**
   * تقویت نمونه Vue اپلیکیشن
   * @optional
   */
  enhanceApp?: (ctx: EnhanceAppContext) => Awaitable<void>
  /**
   * گسترش یک تم دیگر، با فراخوانی `enhanceApp` آن پیش از ما
   * @optional
   */
  extends?: Theme
}

interface EnhanceAppContext {
  app: App // نمونه Vue اپلیکیشن
  router: Router // نمونه روتر ویتپرس
  siteData: Ref<SiteData> // متادیتاهای سطح سایت
}
```

فایل ورودی تم باید تم را به عنوان export پیشفرض خود export کند:

```js [.vitepress/theme/index.js]

// شما میتوانید فایلهای Vue را مستقیماً در ورودی تم وارد کنید
// ویتپرس با @vitejs/plugin-vue پیشتنظیم شده است.
import Layout from './Layout.vue'

export default {
  Layout,
  enhanceApp({ app, router, siteData }) {
    // ...
  }
}
```

export پیشفرض تنها قراردادی برای یک تم سفارشی است و تنها ویژگی `Layout` لازم است. بنابراین، به شیء تم ویتپرس میتوان به عنوان یک کامپوننت Vue ساده ترتیب داد.

درون کامپوننت لایهی خود، دقیقاً مانند یک برنامه Vite + Vue 3 عادی عمل میکند. با این وجود، توجه داشته باشید که تم همچنین باید [سازگار با SSR](./ssr-compat) باشد.

## ساخت یک لایه {#building-a-layout}

بیشترین لایهی پایهای نیازمند دارای یک کامپوننت `<Content />` است:

```vue [.vitepress/theme/Layout.vue]
<template>
  <h1>طرح سفارشی!</h1>

  <!-- اینجا محتوای markdown نمایش داده میشود -->
  <Content />
</template>
```

لایهی بالا به سادگی تمام محتوای markdown هر صفحه را به عنوان HTML نمایش میدهد. اولین بهبودی که میتوانیم اعمال کنیم، مدیریت خطاهای 404 است:

```vue{1-4,9-12}
<script setup>
import { useData } from 'vitepress'
const { page } = useData()
</script>

<template>
  <h1>طرح سفارشی!</h1>

  <div v-if="page.isNotFound">
    صفحه 404 سفارشی!
  </div>
  <Content v-else />
</template>
```

کمککننده [`useData()`](../reference/runtime-api#usedata) اطلاعات اجرایی مورد نیاز ما را برای رندر شرایطی صفحات مختلف فراهم میکند. یکی از دیگر اطلاعاتی که ما میتوانیم به آن دسترسی داشته باشیم، اطلاعات اولیه صفحه فعلی است. ما میتوانیم از این اطلاعات برای اجازه دادن به کاربر برای کنترل لایه در هر صفحه استفاده کنیم. به عنوان مثال، کاربر میتواند مشخص کند که صفحه باید از یک طرح صفحه خانه خاص استفاده کند با:

```md
---
layout: home
---
```

و ما میتوانیم تم خود را تنظیم کنیم تا با این موضوع برخورد کند:

```vue{3,12-14}
<script setup>
import { useData } from 'vitepress'
const { page, frontmatter } = useData()
</script>

<template>
  <h1>طرح سفارشی!</h1>

  <div v-if="page.isNotFound">
    صفحه 404 سفارشی!
  </div>
  <div v-if="frontmatter.layout === 'home'">
    صفحه خانه سفارشی!
  </div>
  <Content v-else />
</template>
```

طبیعتا، شما میتوانید لایهی خود را به کامپوننتهای بیشتری تقسیم کنید:

```vue{3-5,12-15}
<script setup>
import { useData } from 'vitepress'
import NotFound from './NotFound.vue'
import Home from './Home.vue'
import Page from './Page.vue'

const { page, frontmatter } = useData()
</script>

<template>
  <h1>طرح سفارشی!</h1>

  <NotFound v-if="page.isNotFound" />
  <Home v-if="frontmatter.layout === 'home'" />
  <Page v-else /> <!-- <Page /> با `<Content />` را نمایش میدهد -->
</template>
```

برای همه چیزی که در کامپوننتهای تم موجود است، به [مستندات API اجرایی](../reference/runtime-api) مراجعه کنید. به علاوه، شما میتوانید از [بارگذاری داده در زمان ساخت](./data-loading) استفاده کنید تا لایههای مبتنی بر داده را تولید کنید - به عنوان مثال، یک صفحه که تمام پستهای وبلاگ در پروژه فعلی را لیست میکند.

## توزیع یک تم سفارشی {#distributing-a-custom-theme}

آسانترین روش برای توزیع یک تم سفارشی ارائه آن به عنوان قالب مخزن در GitHub است.

اگر میخواهید تم را به عنوان یک بسته npm توزیع کنید، مراحل زیر را دنبال کنید:

1. شیء تم را به عنوان export پیشفرض در ورودی بستهتان export کنید.

2. اگر امکان دارد، تعریف نوع پیکربندی تم خود را به عنوان `ThemeConfig` export کنید.

3. اگر تم شما نیاز به تنظیم پیکربندی ویتپرس دارد، پیکربندی را تحت یک زیرمسیر بسته (مانند `my-theme/config`) export کنید تا کاربر بتواند آن را گسترش دهد.

4. گزینههای پیکربندی تم را مستند کنید (هم از طریق فایل پیکربندی و هم از طریق frontmatter).

5. دستورالعملهای روشنی برای مصرف تم خود ارائه دهید (مانند زیر).

## مصرف یک تم سفارشی {#consuming-a-custom-theme}

برای مصرف یک تم خارجی، آن را از ورودی تم سفارشی وارد و دوباره export کنید:

```js [.vitepress/theme/index.js]
import Theme from 'awesome-vitepress-theme'

export default Theme
```

اگر تم نیاز به گسترش دارد:

```js [.vitepress/theme/index.js]
import Theme from 'awesome-vitepress-theme'

export default {
  extends: Theme,
  enhanceApp(ctx) {
    // ...
  }
}
```

اگر تم نیاز به پیکربندی خاص ویتپرس دارد، شما همچنین باید آن را در پیکربندی خود گسترش دهید:

```ts [.vitepress/config.ts]
import baseConfig from 'awesome-vitepress-theme/config'

export default {
  // گسترش پیکربندی پایهی تم (اگر لازم باشد)
  extends: baseConfig
}
```

سرانجام، اگر تم انواع خود را برای پیکربندی تماش ارائه میدهد:

```ts [.vitepress/config.ts]
import baseConfig from 'awesome-vitepress-theme/config'
import { defineConfigWithTheme } from 'vitepress'
import type { ThemeConfig } from 'awesome-vitepress-theme'

export default defineConfigWithTheme<ThemeConfig>({
  extends: baseConfig,
  themeConfig: {
    // نوع `ThemeConfig` است
  }
})
```
