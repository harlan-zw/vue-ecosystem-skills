---
outline: deep
---

# مسیریابی {#routing}

## مسیریابی مبتنی بر فایل {#file-based-routing}

ویتپرس از مسیریابی مبتنی بر فایل استفاده میکند که به این معنی است که صفحات HTML تولید شده از ساختار دایرکتوری فایلهای Markdown منبع نقشهبندی میشوند. به عنوان مثال، با توجه به ساختار دایرکتوری زیر:

```
.
├─ guide
│  ├─ getting-started.md
│  └─ index.md
├─ index.md
└─ prologue.md
```

صفحات HTML تولید شده به شرح زیر خواهد بود:

```
index.md                  -->  /index.html (قابل دسترس به عنوان /)
prologue.md               -->  /prologue.html
guide/index.md            -->  /guide/index.html (قابل دسترس به عنوان /guide/)
guide/getting-started.md  -->  /guide/getting-started.html
```

این صفحات HTML نهایی میتوانند بر روی هر سرور وبی که قادر به ارائه فایلهای ایستا است، میزبانی شوند.

## ریشه و دایرکتوری منبع {#root-and-source-directory}

در ساختار فایل پروژه ویتپرس، دو مفهوم مهم وجود دارد: **ریشه پروژه** و **دایرکتوری منبع**.

### ریشه پروژه {#project-root}

ریشه پروژه جایی است که ویتپرس سعی میکند برای دایرکتوری ویژه `.vitepress` را بررسی کند. دایرکتوری `.vitepress` مکانی رزرو شده برای فایل پیکربندی، حافظه نهان سرور توسعه، خروجی ساخت، و کد سفارشیسازی موضوع اختیاری ویتپرس است.

زمانی که شما دستور `vitepress dev` یا `vitepress build` را از خط فرمان اجرا میکنید، ویتپرس از دایرکتوری کاری فعلی به عنوان ریشه پروژه استفاده میکند. برای مشخص کردن یک زیردایرکتوری به عنوان ریشه، باید مسیر نسبی را به دستور ارسال کنید. به عنوان مثال، اگر پروژه ویتپرس شما در `./docs` قرار دارد، باید دستور `vitepress dev docs` را اجرا کنید:

```
.
├─ docs                    # ریشه پروژه
│  ├─ .vitepress           # دایرکتوری پیکربندی
│  ├─ getting-started.md
│  └─ index.md
└─ ...
```

```sh
vitepress dev docs
```

این عمل به نتیجه زیر منجر میشود:

```
docs/index.md            -->  /index.html (قابل دسترس به عنوان /)
docs/getting-started.md  -->  /getting-started.html
```

### دایرکتوری منبع {#source-directory}

دایرکتوری منبع جایی است که فایلهای منبع Markdown شما قرار میگیرند. به طور پیشفرض، این همانند ریشه پروژه است. با این حال، شما میتوانید آن را از طریق گزینه [`srcDir`](../reference/site-config#srcdir) پیکربندی کنید.

گزینه `srcDir` نسبت به ریشه پروژه حل میشود. به عنوان مثال، با `srcDir: 'src'`، ساختار فایل شما به این صورت خواهد بود:

```
.                          # ریشه پروژه
├─ .vitepress              # دایرکتوری پیکربندی
└─ src                     # دایرکتوری منبع
   ├─ getting-started.md
   └─ index.md
```

نتیجه نقشهبندی منبع به HTML:

```
src/index.md            -->  /index.html (قابل دسترس به عنوان /)
src/getting-started.md  -->  /getting-started.html
```

## لینکدهی بین صفحات {#linking-between-pages}

میتوانید هنگام لینکدهی بین صفحات از مسیرهای نسبی و مطلق استفاده کنید. توجه داشته باشید که با اینکه هر دو پسوند `.md` و `.html` کار میکنند، بهتر است که پسوندها را حذف کنید تا ویتپرس بتواند URLهای نهایی را بر اساس پیکربندی شما تولید کند.

```md
<!-- درست -->
[شروع کار](./getting-started)
[شروع کار](../guide/getting-started)

<!-- نادرست -->
[شروع کار](./getting-started.md)
[شروع کار](./getting-started.html)
```

جهت آشنایی بیشتر با لینکدهی به منابع مانند تصاویر به [مدیریت منابع](./asset-handling) مراجعه کنید.

### لینکدهی به صفحات غیر ویتپرس {#linking-to-non-vitepress-pages}

اگر میخواهید به یک صفحه در وبسایت خود لینک دهید که توسط ویتپرس تولید نشده است، باید یا از URL کامل (باز میشود در یک تب جدید) استفاده کنید، یا هدف را به طور صریح مشخص کنید:

**ورودی**

```md
[لینک به pure.html](/pure.html){target="_self"}
```

**خروجی**

[لینک به pure.html](/pure.html){target="_self"}

::: tip توجه

در لینکهای Markdown، `base` به طور خودکار به URL پیشوند داده میشود. این بدان معنی است که اگر میخواهید به صفحهای خارج از پایه خود لینک دهید، باید چیزی شبیه `../../pure.html` را در لینک استفاده کنید (توسط مرورگر نسبت به صفحه فعلی حل میشود).

در غیر این صورت، میتوانید به طور مستقیم از anchor tag syntax استفاده کنید:

```md
<a href="/pure.html" target="_self">لینک به pure.html</a>
```

:::

## تولید URLهای تمیز {#generating-clean-url}

::: warning نیازمندی پشتیبانی سرور

برای ارائه URLهای تمیز با ویتپرس، نیاز به پشتیبانی سمت سرور وجود دارد.

:::

به طور پیشفرض، ویتپرس لینکهای ورودی را به URLهایی با پسوند `.html` حل میکند. با این حال، برخی از کاربران ممکن است از URLهای "تمیز" بدون پسوند `.html` استفاده کنند - به عنوان مثال، `example.com/path` به جای `example.com/path.html`.

برخی از سرورها یا پلتفرمهای میزبانی (مانند Netlify، Vercel، GitHub Pages) امکان این را فراهم میکنند که یک URL مانند `/foo` به `/foo.html` نگاشت شود اگر موجود باشد، بدون انتقال:

- Netlify و GitHub Pages این را به طور پیشفرض پشتیبانی میکنند.
- Vercel نیاز به فعالسازی `cleanUrls` در `vercel.json` دارد.

اگر این ویژگی برای شما در دسترس است، میتوانید از گزینه پیکربندی خود ویتپرس به نام [`cleanUrls`](../reference/site-config#cleanurls) استفاده کنید تا:

- لینکهای ورودی بین صفحات بدون پسوند `.html` تولید شوند.
- اگر مسیر کنونی با `.html` ختم شود، مسیریاب به صورت تغییر مسیر کلاینت به مسیر بدون پسوند انجام میدهد.

اگر امکان پیکربندی سرور شما برای این پشتیبانی وجود نداشته باشد، شما باید به صورت دستی به ساختار دایرکتوری زیر رجوع کنید:

```
.
├─ getting-started
│  └─ index.md
├─ installation
│  └─ index.md
└─ index.md
```

## بازنویسی مسیر {#route-rewrites}

میتوانید نقشهبندی بین ساختار دایرکتوری منبع و صفحات تولید شده را سفارشیسازی کنید. این ویژگی وقتی مفید است که یک ساختار پروژه پیچیده داشته باشید. به عنوان مثال، فرض کنید یک مونورپو با چند بسته دارید و میخواهید مستندات را همراه با فایلهای منبع قرار دهید مانند این:

```
.
├─ packages
│  ├─ pkg-a
│  │  └─ src
│  │      ├─ pkg-a-code.ts
│  │      └─ pkg-a-docs.md
│  └─ pkg-b
│     └─ src
│         ├─ pkg-b-code.ts
│         └─ pkg-b-docs.md
```

و میخواهید صفحات ویتپرس به این صورت تولید شوند:

```
packages/pkg-a/src/pkg-a-docs.md  -->  /pkg-a/index.html
packages/pkg-b/src/pkg-b-docs.md  -->  /pkg-b/index.html
```

میتوانید این کار را با پیکربندی گزینه [`rewrites`](../reference/site-config#rewrites) مانند زیر انجام دهید:

```ts [.vitepress/config.js]
export default {
  rewrites: {
    'packages/pkg-a/src/pkg-a-docs.md': 'pkg-a/index.md',
    'packages/pkg-b/src/pkg-b-docs.md': 'pkg-b/index.md'
  }
}
```

گزینه `rewrites` همچنین پارامترهای مسیر پویایی را پشتیبانی میکند. در مثال بالا، اگر تعداد بسیاری از بستهها داشته باشید، لیست کردن همه مسیرها به شکل زیر ممکن است طولانی باشد. با توجه به اینکه همه دارای ساختار فایل یکسان هستند، میتوانید پیکربندی را به این صورت سادهتر کنید:

```ts
export default {
  rewrites: {
    'packages/:pkg/src/(.*)': ':pkg/index.md'
  }
}
```

مسیرهای بازنویسی با استفاده از بسته `path-to-regexp` ترجمه میشوند - برای جزئیات بیشتر به مستندات آن مراجعه کنید.

::: warning لینکهای نسبی با بازنویسی

زمانی که بازنویسیها فعال باشند، **لینکهای نسبی باید بر اساس مسیرهای بازنویسی باشند**. به عنوان مثال، برای ایجاد یک لینک نسبی از `packages/pkg-a/src/pkg-a-code.md` به `packages/pkg-b/src/pkg-b-code.md`، باید از مورد زیر استفاده کنید:

```md
[لینک به PKG B](../pkg-b/pkg-b-code)
```
:::

## مسیرهای پویا {#dynamic-routes}

میتوانید صفحات زیادی را با استفاده از یک فایل Markdown و دادههای پویا تولید کنید. به عنوان مثال، میتوانید یک فایل `packages/[pkg].md` ایجاد کنید که برای هر بسته در یک پروژه، یک صفحه متناظر تولید میکند. در اینجا، بخش `[pkg]` یک پارامتر مسیر است که هر صفحه را از دیگران تمایز میدهد.

### فایل بارگیری مسیرها {#paths-loader-file}

از آنجایی که ویتپرس یک موتور سایت ایستا است، مسیرهای ممکن باید در زمان ساخت تعیین شوند. بنابراین، یک صفحه مسیر پویا باید همراه با یک **فایل بارگیری مسیرها** همراه باشد. برای `packages/[pkg].md`، به `packages/[pkg].paths.js` (همچنین `.ts` پشتیبانی میشود) نیاز داریم:

```
.
└─ packages
   ├─ [pkg].md         # قالب مسیر
   └─ [pkg].paths.js   # فایل بارگیری

 مسیرها
```

فایل بارگیری باید یک شیء با یک متد `paths` به عنوان export پیشفرض ارائه دهد. متد `paths` باید آرایهای از اشیاء با خصوصیت `params` را برگرداند. هر یک از این اشیاء یک صفحه متناظر را ایجاد میکنند.

با توجه به آرایه `paths` زیر:

```js
// packages/[pkg].paths.js
export default {
  paths() {
    return [
      { params: { pkg: 'foo' }},
      { params: { pkg: 'bar' }}
    ]
  }
}
```

صفحات HTML تولید شده به شرح زیر خواهد بود:

```
.
└─ packages
   ├─ foo.html
   └─ bar.html
```

### چندین پارامتر {#multiple-params}

یک مسیر پویا میتواند شامل چندین پارامتر باشد:

**ساختار فایل**

```
.
└─ packages
   ├─ [pkg]-[version].md
   └─ [pkg]-[version].paths.js
```

**بارگیری مسیرها**

```js
export default {
  paths: () => [
    { params: { pkg: 'foo', version: '1.0.0' }},
    { params: { pkg: 'foo', version: '2.0.0' }},
    { params: { pkg: 'bar', version: '1.0.0' }},
    { params: { pkg: 'bar', version: '2.0.0' }}
  ]
}
```

**خروجی**

```
.
└─ packages
   ├─ foo-1.0.0.html
   ├─ foo-2.0.0.html
   ├─ bar-1.0.0.html
   └─ bar-2.0.0.html
```

### تولید پویای مسیرها {#dynamically-generating-paths}

ماژول بارگیری مسیر در Node.js اجرا میشود و تنها در زمان ساخت اجرا میشود. شما میتوانید آرایهی مسیرها را با استفاده از هر دادهای، سطحی یا از راه دور، به صورت پویا تولید کنید.

تولید مسیرها از فایلهای محلی:

```js
import fs from 'fs'

export default {
  paths() {
    return fs
      .readdirSync('packages')
      .map((pkg) => {
        return { params: { pkg }}
      })
  }
}
```

تولید مسیرها از دادههای از راه دور:

```js
export default {
  async paths() {
    const pkgs = await (await fetch('https://my-api.com/packages')).json()

    return pkgs.map((pkg) => {
      return {
        params: {
          pkg: pkg.name,
          version: pkg.version
        }
      }
    })
  }
}
```

### دسترسی به پارامترها در صفحه {#accessing-params-in-page}

شما میتوانید از پارامترها برای انتقال دادههای اضافی به هر صفحه استفاده کنید. فایل مسیر Markdown میتواند از پارامترهای صفحه کنونی در عبارات Vue با استفاده از خاصیت `$params` global استفاده کند:

```md
- نام بسته: {{ $params.pkg }}
- نسخه: {{ $params.version }}
```

همچنین میتوانید به پارامترهای کنونی صفحه از طریق [`useData`](../reference/runtime-api#usedata) runtime API دسترسی داشته باشید. این در هر دو فایل Markdown و کامپوننتهای Vue در دسترس است:

```vue
<script setup>
import { useData } from 'vitepress'

// params یک Vue ref است
const { params } = useData()

console.log(params.value)
</script>
```

### نمایش محتوای خام {#rendering-raw-content}

پارامترهای ارسال شده به صفحه در بارگذاری JavaScript کلاینت سریال میشوند، بنابراین باید از ارسال دادههای سنگین در پارامترها خودداری کنید، برای مثال محتوای خام Markdown یا HTML از یک CMS از راه دور.

به جای اینکه میتوانید محتوای چنین محتوایی را در هر صفحه با استفاده از خاصیت `content` روی هر شیء مسیر ارسال کنید:

```js
export default {
  async paths() {
    const posts = await (await fetch('https://my-cms.com/blog-posts')).json()

    return posts.map((post) => {
      return {
        params: { id: post.id },
        content: post.content // Markdown یا HTML خام
      }
    })
  }
}
```

سپس، از دستورات ویژهی زیر برای نمایش محتوا به عنوان بخشی از فایل Markdown استفاده کنید:

```md
<!-- @content -->
```
