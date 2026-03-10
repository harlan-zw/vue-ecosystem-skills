---
total: 96
---

# Docs Index

- [Vue Router](./index.md)
- [Installation](./installation.md): <VueMasteryLogoLink></VueMasteryLogoLink>
- [Introduction](./introduction.md): <VueSchoolLink
href="<https://vueschool.io/courses/vue-router-4-for-everyone>"
title="Learn how to build powerful Single Page Applications with the...

## data-loaders/basic (1)

- [defineBasicLoader()](./data-loaders/basic/index.md): Basic data loader that always reruns on navigation.

## data-loaders/colada (1)

- [defineColadaLoader()](./data-loaders/colada/index.md): Loaders that use @pinia/colada under the hood. These loaders provide the most efficient solution to asynchronous state with cache, ssr support and ...

## data-loaders (11)

- [Defining Data Loaders](./data-loaders/defining-loaders.md): In order to use data loaders, you need to define them first. Data loaders themselves are the composables returned by the different defineLoader fun...
- [Error handling](./data-loaders/error-handling.md): By default, all errors thrown in a loader are considered unexpected errors: they will abort the navigation, just like in a navigation guard. Becaus...
- [Data Loaders](./data-loaders/index.md): Data loaders streamline any asynchronous state management with Vue Router, like Data Fetching. Adopting Data loaders ensures a consistent and effic...
- [Cancelling a data loader](./data-loaders/load-cancellation.md): Data loaders receive an AbortSignal that can be passed to fetch and other Web APIs to cancel ongoing requests when the navigation is cancelled. If ...
- [Navigation aware](./data-loaders/navigation-aware.md): Since the data fetching happens within a navigation guard, it's possible to control the navigation like in regular navigation guards:
- [Nested loaders](./data-loaders/nested-loaders.md): Sometimes, requests depend on other fetched data (e.g. fetching additional user information). For these scenarios, we can simply import the other l...
- [Nuxt](./data-loaders/nuxt.md): To use Data Loaders in Nuxt, create a new plugin file in the plugins directory of your Nuxt project and setup the Data Loaders plugin like usual:
- [Loaders Organization](./data-loaders/organization.md): While most examples show loaders defined in the same file as the page component, it's possible to define them in separate files and import them in ...
- [Reloading data](./data-loaders/reloading-data.md): Very often, it is required to reload the data (e.g. fetch the latest data) without navigating. Since Vue Router considers that a duplicated navigat...
- [Data Loaders](./data-loaders/rfc.md): List of things that haven't been added to the document yet:
- [Server side rendering](./data-loaders/ssr.md): Use Colada Loader to take advantage of its SSR caching capabilities. If you don't need SSR, you can use any loader implementation.

## guide/advanced (12)

- [Vue Router and the Composition API](./guide/advanced/composition-api.md): <VueSchoolLink
href="https://vueschool.io/lessons/router-and-the-composition-api"
title="Learn how to use Vue Router with the Composition API"
/>
- [Data Fetching](./guide/advanced/data-fetching.md): Sometimes you need to fetch data from the server when a route is activated. For example, before rendering a user profile, you need to fetch the use...
- [Dynamic Routing](./guide/advanced/dynamic-routing.md): <VueSchoolLink
href="https://vueschool.io/lessons/vue-router-4-dynamic-routing"
title="Learn how to add routes at runtime"
/>
- [Extending RouterLink](./guide/advanced/extending-router-link.md): <VueSchoolLink
href="https://vueschool.io/lessons/extending-router-link-for-external-urls"
title="Learn how to extend router-link"
/>
- [Lazy Loading Routes](./guide/advanced/lazy-loading.md): <VueSchoolLink
href="https://vueschool.io/lessons/lazy-loading-routes-vue-cli-only"
title="Learn about lazy loading routes"
/>
- [Route Meta Fields](./guide/advanced/meta.md): <VueSchoolLink
href="https://vueschool.io/lessons/route-meta-fields"
title="Learn how to use route meta fields"
/>
- [Waiting for the result of a Navigation](./guide/advanced/navigation-failures.md): <VueSchoolLink
href="https://vueschool.io/lessons/vue-router-4-detecting-navigation-failures"
title="Learn how to detect navigation failures"
/>
- [Navigation Guards](./guide/advanced/navigation-guards.md): <VueSchoolLink
href="https://vueschool.io/lessons/route-guards"
title="Learn how to add navigation guards"
/>
- [RouterView slot](./guide/advanced/router-view-slot.md): The RouterView component exposes a slot that can be used to render the route component:
- [Scroll Behavior](./guide/advanced/scroll-behavior.md): <VueSchoolLink
href="https://vueschool.io/lessons/scroll-behavior"
title="Learn how to customize scroll behavior"
/>
- [Transitions](./guide/advanced/transitions.md): <VueSchoolLink
href="https://vueschool.io/lessons/route-transitions"
title="Learn about route transitions"
/>
- [Typed Routes <Badge type="tip" text="v4.4.0+" />](./guide/advanced/typed-routes.md): RouterLink to autocomplete

## guide/essentials (10)

- [Active links](./guide/essentials/active-links.md): It's common for applications to have a navigation component that renders a list of RouterLink components. Within that list, we might want to style ...
- [Dynamic Route Matching with Params](./guide/essentials/dynamic-matching.md): <VueSchoolLink
href="https://vueschool.io/lessons/dynamic-routes"
title="Learn about dynamic route matching with params"
/>
- [Different History modes](./guide/essentials/history-mode.md): <VueSchoolLink
href="https://vueschool.io/lessons/history-mode"
title="Learn about the differences between Hash Mode and HTML5 Mode"
/>
- [Named Routes](./guide/essentials/named-routes.md): <VueSchoolLink
href="https://vueschool.io/lessons/named-routes"
title="Learn about the named routes"
/>
- [Named Views](./guide/essentials/named-views.md): <VueSchoolLink
href="https://vueschool.io/lessons/vue-router-4-named-views"
title="Learn how to use named views"
/>
- [Programmatic Navigation](./guide/essentials/navigation.md): <VueSchoolLink
href="https://vueschool.io/lessons/vue-router-4-programmatic-navigation"
title="Learn how to navigate programmatically"
/>
- [Nested Routes](./guide/essentials/nested-routes.md): <VueSchoolLink
href="https://vueschool.io/lessons/nested-routes"
title="Learn about nested routes"
/>
- [Passing Props to Route Components](./guide/essentials/passing-props.md): <VueSchoolLink
href="https://vueschool.io/lessons/route-props"
title="Learn how to pass props to route components"
/>
- [Redirect and Alias](./guide/essentials/redirect-and-alias.md): <VueSchoolLink
href="https://vueschool.io/lessons/vue-router-4-redirect-and-alias"
title="Learn how to use redirect and alias"
/>
- [Routes' Matching Syntax](./guide/essentials/route-matching-syntax.md): <VueSchoolLink
href="https://vueschool.io/lessons/vue-router-4-advanced-routes-matching-syntax"
title="Learn how to use advanced route routes' matc...

## guide (1)

- [Getting Started](./guide/index.md): <VueSchoolLink
href="https://vueschool.io/courses/vue-router-4-for-everyone"
title="Learn how to build powerful Single Page Applications with the V...

## guide/migration (2)

- [Migrating from Vue 2](./guide/migration/index.md): Most of Vue Router API has remained unchanged during its rewrite from v3 (for Vue 2) to v4 (for Vue 3) but there are still a few breaking changes t...
- [Migrating to Vue Router 5](./guide/migration/v4-to-v5.md): No breaking changes. Update your dependency and you're done:

## zh (4)

- [关于中文翻译](./zh/about-translation.md): 这里是 Vue Router 文档的中文翻译，该翻译由 Vue 社区贡献完成，如对翻译有任何疑问，可在我们的 GitHub 仓库创建 issue 或 pull request。谢谢。
- [Vue Router](./zh/index.md)
- [安装](./zh/installation.md): <VueMasteryLogoLink></VueMasteryLogoLink>
- [介绍](./zh/introduction.md): <VueSchoolLink
href="https://vueschool.io/courses/vue-router-4-for-everyone"
title="Learn how to build powerful Single Page Applications with the V...

## zh/api/enums (1)

- [枚举：NavigationFailureType %{#enumeration-navigationfailuretype}%](./zh/api/enums/NavigationFailureType.md): API 参考 / NavigationFailureType

## zh/api (1)

- [API 文档](./zh/api/index.md): API 文档

## zh/api/interfaces (25)

- [接口：HistoryState %{#interface-historystate}%](./zh/api/interfaces/HistoryState.md): API 参考 / HistoryState
- [接口：NavigationFailure %{#interface-navigationfailure}%](./zh/api/interfaces/NavigationFailure.md): API 参考 / NavigationFailure
- [接口：NavigationGuard %{#interface-navigationguard}%](./zh/api/interfaces/NavigationGuard.md): API 参考 / NavigationGuard
- [接口：NavigationGuardNext %{#interface-navigationguardnext}%](./zh/api/interfaces/NavigationGuardNext.md): API 参考 / NavigationGuardNext
- [接口：NavigationGuardWithThis<T> %{#interface-navigationguardwiththis-t}%](./zh/api/interfaces/NavigationGuardWithThis.md): API 参考 / NavigationGuardWithThis
- [接口：NavigationHookAfter %{#interface-navigationhookafter}%](./zh/api/interfaces/NavigationHookAfter.md): API 参考 / NavigationHookAfter
- [接口：RouteLocation %{#interface-routelocation}%](./zh/api/interfaces/RouteLocation.md): API 参考 / RouteLocation
- [接口：RouteLocationMatched](./zh/api/interfaces/RouteLocationMatched.md): API 参考 / RouteLocationMatched
- [接口：RouteLocationNormalized](./zh/api/interfaces/RouteLocationNormalized.md): API 参考 / RouteLocationNormalized
- [接口：RouteLocationNormalizedLoaded](./zh/api/interfaces/RouteLocationNormalizedLoaded.md): API 参考 / RouteLocationNormalizedLoaded
- [接口：RouteLocationOptions](./zh/api/interfaces/RouteLocationOptions.md): API 参考 / RouteLocationOptions
- [接口：RouteMeta](./zh/api/interfaces/RouteMeta.md): API 参考 / RouteMeta
- [接口：Router](./zh/api/interfaces/Router.md): API 参考 / Router
- [Interface: _RouteRecordBase](./zh/api/interfaces/RouteRecordBase.md): API Documentation / RouteRecordBase
- [Interface: RouteRecordMultipleViews](./zh/api/interfaces/RouteRecordMultipleViews.md): API Documentation / RouteRecordMultipleViews
- [Interface: RouteRecordMultipleViewsWithChildren](./zh/api/interfaces/RouteRecordMultipleViewsWithChildren.md): API Documentation / RouteRecordMultipleViewsWithChildren
- [接口：RouteRecordNormalized](./zh/api/interfaces/RouteRecordNormalized.md): API 参考 / RouteRecordNormalized
- [Interface: RouteRecordRedirect](./zh/api/interfaces/RouteRecordRedirect.md): API Documentation / RouteRecordRedirect
- [Interface: RouteRecordSingleView](./zh/api/interfaces/RouteRecordSingleView.md): API Documentation / RouteRecordSingleView
- [Interface: RouteRecordSingleViewWithChildren](./zh/api/interfaces/RouteRecordSingleViewWithChildren.md): API Documentation / RouteRecordSingleViewWithChildren
- [接口：RouterHistory](./zh/api/interfaces/RouterHistory.md): API 参考 / RouterHistory
- [接口：RouterLinkProps](./zh/api/interfaces/RouterLinkProps.md): API 参考 / RouterLinkProps
- [接口：RouterOptions %{#interface-routeroptions}%](./zh/api/interfaces/RouterOptions.md): API 参考 / RouterOptions
- [接口：RouterScrollBehavior](./zh/api/interfaces/RouterScrollBehavior.md): API 参考 / RouterScrollBehavior
- [接口：RouterViewProps](./zh/api/interfaces/RouterViewProps.md): API 参考 / RouterViewProps

## zh/guide/advanced (12)

- [Vue Router 和 组合式 API](./zh/guide/advanced/composition-api.md): <VueSchoolLink
href="https://vueschool.io/lessons/router-and-the-composition-api"
title="Learn how to use Vue Router with the composition API"
/>
- [数据获取](./zh/guide/advanced/data-fetching.md): 有时候，进入某个路由后，需要从服务器获取数据。例如，在渲染用户信息时，你需要从服务器获取用户的数据。我们可以通过两种方式来实现：
- [动态路由](./zh/guide/advanced/dynamic-routing.md): <VueSchoolLink
href="https://vueschool.io/lessons/vue-router-4-dynamic-routing"
title="Learn how to add routes at runtime"
/>
- [扩展 RouterLink](./zh/guide/advanced/extending-router-link.md): <VueSchoolLink
href="https://vueschool.io/lessons/extending-router-link-for-external-urls"
title="Learn how to extend router-link"
/>
- [路由懒加载](./zh/guide/advanced/lazy-loading.md): <VueSchoolLink
href="https://vueschool.io/lessons/lazy-loading-routes-vue-cli-only"
title="Learn about lazy loading routes"
/>
- [路由元信息](./zh/guide/advanced/meta.md): <VueSchoolLink
href="https://vueschool.io/lessons/route-meta-fields"
title="Learn how to use route meta fields"
/>
- [等待导航结果](./zh/guide/advanced/navigation-failures.md): <VueSchoolLink
href="https://vueschool.io/lessons/vue-router-4-detecting-navigation-failures"
title="Learn how to detect navigation failures"
/>
- [导航守卫](./zh/guide/advanced/navigation-guards.md): <VueSchoolLink
href="https://vueschool.io/lessons/route-guards"
title="Learn how to add navigation guards"
/>
- [RouterView 插槽](./zh/guide/advanced/router-view-slot.md): RouterView 组件暴露了一个插槽，可以用来渲染路由组件：
- [滚动行为](./zh/guide/advanced/scroll-behavior.md): <VueSchoolLink
href="https://vueschool.io/lessons/scroll-behavior"
title="Learn how to customize scroll behavior"
/>
- [过渡动效](./zh/guide/advanced/transitions.md): <VueSchoolLink
href="https://vueschool.io/lessons/route-transitions"
title="Learn about route transitions"
/>
- [类型化路由 <Badge type="tip" text="v4.4.0+" />](./zh/guide/advanced/typed-routes.md): RouterLink to autocomplete

## zh/guide/essentials (10)

- [匹配当前路由的链接](./zh/guide/essentials/active-links.md): 应用程序通常都会有一个渲染 RouterLink 列表的导航组件。我们也许想对这个列表中匹配当前路由的链接进行视觉区分。
- [带参数的动态路由匹配](./zh/guide/essentials/dynamic-matching.md): <VueSchoolLink
href="https://vueschool.io/lessons/dynamic-routes"
title="Learn about dynamic route matching with params"
/>
- [不同的历史模式](./zh/guide/essentials/history-mode.md): <VueSchoolLink
href="https://vueschool.io/lessons/history-mode"
title="Learn about the differences between Hash Mode and HTML5 Mode"
/>
- [命名路由](./zh/guide/essentials/named-routes.md): <VueSchoolLink
href="https://vueschool.io/lessons/named-routes"
title="Learn about the named routes"
/>
- [命名视图](./zh/guide/essentials/named-views.md): <VueSchoolLink
href="https://vueschool.io/lessons/vue-router-4-named-views"
title="Learn how to use named views"
/>
- [编程式导航](./zh/guide/essentials/navigation.md): <VueSchoolLink
href="https://vueschool.io/lessons/vue-router-4-programmatic-navigation"
title="Learn how to navigate programmatically"
/>
- [嵌套路由](./zh/guide/essentials/nested-routes.md): <VueSchoolLink
href="https://vueschool.io/lessons/nested-routes"
title="Learn about nested routes"
/>
- [将 props 传递给路由组件](./zh/guide/essentials/passing-props.md): <VueSchoolLink
href="https://vueschool.io/lessons/route-props"
title="Learn how to pass props to route components"
/>
- [重定向和别名](./zh/guide/essentials/redirect-and-alias.md): <VueSchoolLink
href="https://vueschool.io/lessons/vue-router-4-redirect-and-alias"
title="Learn how to use redirect and alias"
/>
- [路由的匹配语法](./zh/guide/essentials/route-matching-syntax.md): <VueSchoolLink
href="https://vueschool.io/lessons/vue-router-4-advanced-routes-matching-syntax"
title="Learn how to use advanced route routes' matc...

## zh/guide (1)

- [入门](./zh/guide/index.md): <VueSchoolLink
href="https://vueschool.io/courses/vue-router-4-for-everyone"
title="在 Vue School 上学习如何使用 Vue Router 构建强大的单页应用">观看免费的 Vue Router 视频课...

## zh/guide/migration (1)

- [从 Vue2 迁移](./zh/guide/migration/index.md): 在 Vue Router API 从 v3（Vue2）到 v4（Vue3）的重写过程中，大部分的 Vue Router API 都没有变化，但是在迁移你的程序时，你可能会遇到一些破坏性的变化。本指南将帮助你了解为什么会发生这些变化，以及如何调整你的程序，使其与 Vue Router4 兼容。
