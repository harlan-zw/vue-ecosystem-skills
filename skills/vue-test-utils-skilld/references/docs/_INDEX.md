---
total: 79
---

# Docs Index

- [index](./index.md): layout: home

## api (1)

- [API Reference](./api/index.md): Creates a Wrapper that contains the mounted and rendered Vue component to test.
Note that when mocking dates/timers with Vitest, this must be calle...

## fr/api (1)

- [API](./fr/api/index.md): Crée un Wrapper qui contient le composant Vue monté et rendu pour le test.

## fr/guide/advanced (12)

- [Comportement asynchrone](./fr/guide/advanced/async-suspense.md): Vous avez sûrement remarqué que certaines parties de ce guide utilisent await lors de l'appel de certaines méthodes de wrapper, telles que trigger ...
- [Instance de Composant](./fr/guide/advanced/component-instance.md): mount renvoie un VueWrapper avec de nombreuses méthodes pratiques pour tester les composants Vue. Parfois, vous souhaiterez accéder à l'instance Vu...
- [Faire des requêtes HTTP](./fr/guide/advanced/http-requests.md): Les frameworks de tests modernes proposent déjà de nombreuses fonctionnalités pour les tests de requêtes HTTP. Par conséquent, Vue Test Utils ne di...
- [Réutilisabilité et Composition](./fr/guide/advanced/reusability-composition.md): Lorsque vous travaillez avec l'API de composition et que vous créez des composables, vous voulez parfois ne tester que le composable seul. Commenço...
- [Slots](./fr/guide/advanced/slots.md): Vue Test Utils offre des fonctionnalités utiles pour tester les composants qui utilisent des slots.
- [Tester le Rendu côté Serveur (SSR)](./fr/guide/advanced/ssr.md): Vue Test Utils fournit renderToString pour tester des applications Vue qui utilisent le rendu côté serveur (SSR).
- [Composants de Substitution (Stubs) et Montage Partiel](./fr/guide/advanced/stubs-shallow-mount.md): Vue Test Utils offre certaines fonctionnalités avancées pour substituer (stubbing) les composants et les directives. La substitution consiste à rem...
- [Tester Teleport](./fr/guide/advanced/teleport.md): Vue 3 offre un nouveau composant intégré : <Teleport>, qui permet aux composants de "téléporter" leur contenu très loin de leur propre <template>. ...
- [Transitions](./fr/guide/advanced/transitions.md): En général, vous voudriez tester le DOM affiché après une transition, c'est pourquoi Vue Test Utils simule par défaut <transition> et <transition-g...
- [Tester v-model](./fr/guide/advanced/v-model.md): Lors de l'écriture de composants qui dépendent de l'interaction v-model (évènement update:modelValue), vous devez gérer l'event et les props.
- [Tester Vue Router](./fr/guide/advanced/vue-router.md): Cet article présentera deux façons de tester une application en utilisant Vue Router :
- [Tester Vuex](./fr/guide/advanced/vuex.md): Vuex n'est qu'un détail d'implémentation ; aucun traitement spécial n'est nécessaire pour tester les composants en utilisant Vuex. Cependant, il ex...

## fr/guide/essentials (6)

- [Cours rapide](./fr/guide/essentials/a-crash-course.md): Rentrons dans le vif du sujet ! Apprenons à utiliser Vue Test Utils (VTU) en construisant une simple application de tâches à réaliser (une Todo lis...
- [Rendu conditionnel](./fr/guide/essentials/conditional-rendering.md): Vue Test Utils offre un bouquet de fonctionnalités pour monter et faire des vérifications sur l'état d'un composant, dans le but de vérifier qu'il ...
- [Écrire des composants faciles à tester](./fr/guide/essentials/easy-to-test.md): Vue Test Utils vous aide à écrire des tests pour des composants Vue. Néanmoins, VTU ne peut pas tout faire.
- [Tester les évènements émis](./fr/guide/essentials/event-handling.md): Les composants Vue interagissent les uns avec les autres à travers des props et en émettant des événements en appelant $emit. Dans ce guide, nous e...
- [Tester les formulaires](./fr/guide/essentials/forms.md): Les formulaires dans Vue peuvent être aussi simples que des formulaires HTML classiques ou à l'inverse des arborescences complexes d'éléments de fo...
- [Passer des données aux Composants](./fr/guide/essentials/passing-data.md): Vue Test Utils fournit plusieurs moyens de passer des données et des propriétés à un composant pour vous permettre de tester complètement son compo...

## fr/guide/extending-vtu (2)

- [Communauté et Apprentissage](./fr/guide/extending-vtu/community-learning.md)
- [Plugins](./fr/guide/extending-vtu/plugins.md): Les plugins ajoutent des fonctionnalités au niveau global à l'API de Vue Test Utils. C'est la méthode officielle pour étendre l'API de Vue Test Uti...

## fr/guide/faq (1)

- [FAQ](./fr/guide/faq/index.md): [[toc]]

## fr/guide (1)

- [Commencer](./fr/guide/index.md): Bienvenue sur Vue Test Utils, la librairie de tests officielle pour Vue.js !

## fr (2)

- [index](./fr/index.md): layout: home
- [Vue Test Utils](./fr/README.md): Utilitaire de Test de Composants pour Vue 3.

## fr/installation (1)

- [Installation](./fr/installation/index.md): ::: code-group

## fr/migration (1)

- [Migrer depuis Vue Test Utils v1](./fr/migration/index.md): Voici une liste des modifications de VTU v1 à VTU v2 et quelques extraits de code pour montrer les modifications nécessaires à la migration. Si vou...

## guide/advanced (12)

- [Asynchronous Behavior](./guide/advanced/async-suspense.md): You may have noticed some other parts of the guide using await when calling some methods on wrapper, such as trigger and setValue. What's that all ...
- [Component Instance](./guide/advanced/component-instance.md): mount returns a VueWrapper with lots of convenient methods for testing Vue components. Sometimes you might want access to the underlying Vue instan...
- [Making HTTP requests](./guide/advanced/http-requests.md): Modern test runners already provide lots of great features when it comes to test HTTP requests. Thus, Vue Test Utils doesn't feature any unique too...
- [Reusability & Composition](./guide/advanced/reusability-composition.md): Mostly:
- [Slots](./guide/advanced/slots.md): Vue Test Utils provides some useful features for testing components using slots.
- [Testing Server-side Rendering](./guide/advanced/ssr.md): Vue Test Utils provides renderToString to test Vue applications that use server-side rendering (SSR).
This guide will walk you through the process ...
- [Stubs and Shallow Mount](./guide/advanced/stubs-shallow-mount.md): Vue Test Utils provides some advanced features for stubbing components and directives. A stub is where you replace an existing implementation of a ...
- [Testing Teleport](./guide/advanced/teleport.md): Vue 3 comes with a new built-in component: <Teleport>, which allows components to "teleport" their content far outside of their own <template>. Mos...
- [Transitions](./guide/advanced/transitions.md): In general, you may want to test the resulting DOM after a transition, and this is why Vue Test Utils mocks <transition> and <transition-group> by ...
- [Testing v-model](./guide/advanced/v-model.md): When writing components that rely on v-model interaction (update:modelValue event), you need to handle the event and props.
- [Testing Vue Router](./guide/advanced/vue-router.md): This article will present two ways to test an application using Vue Router:
- [Testing Vuex](./guide/advanced/vuex.md): Vuex is just an implementation detail; no special treatment is required for testing components using Vuex. That said, there are some techniques tha...

## guide/essentials (6)

- [A Crash Course](./guide/essentials/a-crash-course.md): Let's jump right into it! Let's learn Vue Test Utils (VTU) by building a simple Todo app and writing tests as we go. This
guide will cover how to:
- [Conditional Rendering](./guide/essentials/conditional-rendering.md): Vue Test Utils has a range of features for rendering and making assertions about the state of a component, with the goal of verifying it is behavin...
- [Write components that are easy to test](./guide/essentials/easy-to-test.md): Vue Test Utils helps you write tests for Vue components. However, there's only so much VTU can do.
- [Event Handling](./guide/essentials/event-handling.md): Vue components interact with each other via props and by emitting events by calling $emit. In this guide, we look at how to verify events are corre...
- [Form Handling](./guide/essentials/forms.md): Forms in Vue can be as simple as plain HTML forms to complicated nested trees of custom Vue component form elements.
We will gradually go through t...
- [Passing Data to Components](./guide/essentials/passing-data.md): Vue Test Utils provides several ways to set data and props on a component, to allow you to fully test the component's behavior in different scenarios.

## guide/extending-vtu (2)

- [Community and Learning](./guide/extending-vtu/community-learning.md)
- [Plugins](./guide/extending-vtu/plugins.md): Plugins add global-level functionality to Vue Test Utils' API. This is the
official way to extend Vue Test Utils' API with custom logic, methods, o...

## guide/faq (1)

- [FAQ](./guide/faq/index.md): [[toc]]

## guide (1)

- [Getting Started](./guide/index.md): Welcome to Vue Test Utils, the official testing utility library for Vue.js!

## installation (1)

- [Installation](./installation/index.md): ::: code-group

## migration (1)

- [Migrating from Vue Test Utils v1](./migration/index.md): A review of changes VTU v1 -> VTU v2, and some code snippets to showcase required modifications. If you encounter a bug or difference in behavior n...

## zh/api (1)

- [API 参考](./zh/api/index.md): 创建一个包含已挂载和渲染的 Vue 组件的 Wrapper 以进行测试。
请注意，当使用 Vitest 模拟日期/计时器时，必须在 vi.setSystemTime 之后调用此方法。

## zh/guide/advanced (12)

- [异步行为](./zh/guide/advanced/async-suspense.md): 你可能注意到在指南的某些部分，在调用 wrapper 的一些方法时使用了 await，例如 trigger 和 setValue。这是怎么回事呢？
- [组件实例](./zh/guide/advanced/component-instance.md): mount 会返回一个 VueWrapper，它提供了许多方便的测试 Vue 组件的方法。有时你可能希望访问底层的 Vue 实例，通过 vm 属性访问它即可。
- [发起 HTTP 请求](./zh/guide/advanced/http-requests.md): 现代测试运行器在测试 HTTP 请求方面已经提供了许多优秀的功能。因此，Vue Test Utils 并没有提供任何独特的工具来处理这一点。
- [复用与组合](./zh/guide/advanced/reusability-composition.md): 主要内容：
- [插槽](./zh/guide/advanced/slots.md): Vue Test Utils 提供了一些有用的功能，用于测试使用 slots 的组件。
- [测试服务端渲染](./zh/guide/advanced/ssr.md): Vue Test Utils 提供了 renderToString 方法，用于测试服务器端渲染 (SSR) 的 Vue 应用程序。本指南将带你了解如何测试 SSR 的 Vue 应用程序。
- [测试替身 (stub) 与浅挂载](./zh/guide/advanced/stubs-shallow-mount.md): Vue Test Utils 提供了一些高级功能用于为组件和指令创建测试替身 (stubbing)。测试替身 (stub) 是指将自定义组件或指令的现有实现替换为一个不执行任何操作的虚拟实现，这可以简化本来复杂的测试。让我们来看一个例子。
- [测试 Teleport](./zh/guide/advanced/teleport.md): Vue 3 新引入了一个内置组件：<Teleport>，它允许组件将其内容“传送”到其 <template> 之外的某处。大多数使用 Vue Test Utils 编写的测试都是针对传递给 mount 的组件，当被测试的组件被传送到最初渲染的组件之外时，就引入了一些复杂性。
- [过渡效果](./zh/guide/advanced/transitions.md): 通常情况下，你可能希望测试过渡后的 DOM 结构，这就是为什么 Vue Test Utils 默认会模拟 <transition> 和 <transition-group> 的原因。
- [测试 v-model](./zh/guide/advanced/v-model.md): 在编写基于 v-model 交互 (即 update:modelValue 事件) 的组件时，你需要处理 event 和 props。
- [测试 Vue Router](./zh/guide/advanced/vue-router.md): 本文将介绍两种测试带有 Vue Router 的应用的方法：
- [测试 Vuex](./zh/guide/advanced/vuex.md): Vuex 只是一个实现细节；在测试使用 Vuex 的组件时不需要特别处理。尽管如此，还是有一些技巧可以使你的测试更易读和易写。我们将在这里讨论它们。

## zh/guide/essentials (6)

- [快速上手](./zh/guide/essentials/a-crash-course.md): 让我们直接开始吧！通过构建一个简单的待办事项应用程序并逐步编写测试，来学习 Vue Test Utils (VTU)。本指南将涵盖以下内容：
- [条件渲染](./zh/guide/essentials/conditional-rendering.md): Vue Test Utils 提供了一系列功能，用于渲染组件并对其状态进行断言，以验证其是否正常工作。本文将探讨如何渲染组件，以及如何验证组件是否正确渲染内容。
- [编写易于测试的组件](./zh/guide/essentials/easy-to-test.md): Vue Test Utils 帮助你为 Vue 组件编写测试。然而，VTU 的功能是有限的。
- [事件处理](./zh/guide/essentials/event-handling.md): Vue 组件通过 props 和调用 $emit 触发事件来进行交互。在本指南中，我们将介绍如何使用 emitted() 函数来验证事件是否正确触发。
- [表单处理](./zh/guide/essentials/forms.md): 在 Vue 中，表单可以是简单的 HTML 表单，也可以是复杂的嵌套自定义 Vue 组件表单元素。我们将逐步了解如何与表单元素交互、赋值和触发事件。
- [传递数据到组件](./zh/guide/essentials/passing-data.md): Vue Test Utils 提供了几种方法来设置组件的数据和属性，以便你可以在不同场景下充分测试组件的行为。

## zh/guide/extending-vtu (2)

- [社区与学习资源](./zh/guide/extending-vtu/community-learning.md)
- [插件](./zh/guide/extending-vtu/plugins.md): 插件为 Vue Test Utils 的 API 添加全局功能。这是为 Vue Test Utils 的 API 扩展自定义逻辑、方法或功能的官方方式。

## zh/guide/faq (1)

- [常见问题](./zh/guide/faq/index.md): [[toc]]

## zh/guide (1)

- [开始](./zh/guide/index.md): 欢迎使用 Vue Test Utils，这是 Vue.js 的官方测试工具库！

## zh (1)

- [index](./zh/index.md): layout: home

## zh/installation (1)

- [安装](./zh/installation/index.md): ::: code-group

## zh/migration (1)

- [从 Vue Test Utils v1 迁移](./zh/migration/index.md): 这是一篇对 VTU v1 到 VTU v2 变更的回顾，并提供一些代码片段以展示所需的修改。如果你遇到了未在此处记录的错误或行为差异，请创建 issue。
