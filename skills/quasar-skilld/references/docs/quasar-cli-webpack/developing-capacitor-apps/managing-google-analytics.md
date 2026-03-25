---
title: Managing Google Analytics
desc: (@quasar/app-webpack) How to use analytics in a Quasar hybrid mobile app with Capacitor.
---

Getting to know your users and measuring user behavior is an important step in App Development. Unfortunately, it takes a bit of non-standard work to get Google Analytics to work after wrapping your mobile app with Capacitor. Setting up Google Analytics in a pure web application is quite easy, but Capacitor somehow prevents pageviews and events from being sent to Google Analytics.

Follow this guide to implement Google Analytics into your Capacitor powered Quasar App.

::: warning
You'll need to include a `<script>` tag provided by Google in `/index.html`, which will make your App depend on an Internet connection!
:::

## Prerequisites

- Make sure all your routes have a name and path parameter specified. Otherwise, they cannot be posted to the `ga.logPage` function. Please refer to [Routing](/quasar-cli-webpack/routing) for more info on routing.
- Have Basic knowledge of Google Analytics

## Preparation

Before we can start implementing Google Analytics into your application, you'll need an account for Google Analytics and Google Tagmanager. So let's do that first. When you have these accounts, it's time to configure Tag manager. Follow the steps in this Multiminds article to do so.

## Implementing this into application

> For this guide, we'll assume you have a fixed sessionId that you send to Google Analytics. Google Analytics uses a sessionId to distinguish different users from each other. If you want to create an anonymous sessionId, see Analytics Documentation on user id.

Place the Tag Manager snippet into head of your `index.html` file (if you've followed the Multiminds article, you already have this.) Create a new file in your codebase called `analytics.js` with the following contents:

```javascript
export default {
  logEvent(category, action, label, sessionId = null) {
    window.dataLayer.push({
      appEventCategory: category,
      appEventAction: action,
      appEventLabel: label,
      sessionId: sessionId
    })
    window.dataLayer.push({ event: 'appEvent' })
  },

  logPage(path, name, sessionId = null) {
    window.dataLayer.push({
      screenPath: path,
      screenName: name,
      sessionId: sessionId
    })
    window.dataLayer.push({ event: 'appScreenView' })
  }
}
```

To make sure all the pages in your application are automatically posted to Google Analytics, we create an app boot file:

```bash
$ quasar new boot google-analytics [--format ts]
```

Then we edit the newly created file: `/src/boot/google-analytics.js`:

```js
import { defineRouter } from '#q-app/wrappers'
import ga from 'analytics.js'

export default defineRouter(({ router }) => {
  router.afterEach((to, from) => {
    ga.logPage(to.path, to.name, sessionId)
  })
})
```

Finally we register the app boot file in the `/quasar.config` file. We can do so only for Capacitor wrapped apps if we want:

```js
boot: [ctx.mode.capacitor ? 'google-analytics' : '']
```

More information about events can be found in the Analytics documentation on events.

You'll see the events and pageviews coming in when you run your app. It usually takes around 5 to 10 seconds for a pageview to be registered in the realtime view.
