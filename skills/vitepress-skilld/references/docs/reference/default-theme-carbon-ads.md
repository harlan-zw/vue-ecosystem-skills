---
url: /reference/default-theme-carbon-ads.md
---
# Carbon Ads

VitePress has built in native support for Carbon Ads. By defining the Carbon Ads credentials in config, VitePress will display ads on the page.

```js
export default {
  themeConfig: {
    carbonAds: {
      code: 'your-carbon-code',
      placement: 'your-carbon-placement'
    }
  }
}
```

These values are used to call carbon CDN script as shown below.

```js
`//cdn.carbonads.com/carbon.js?serve=${code}&placement=${placement}`
```

To learn more about Carbon Ads configuration, please visit Carbon Ads website.
