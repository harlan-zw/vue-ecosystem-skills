---
total: 119
---

# Docs Index

- [Vue.js - The Progressive JavaScript Framework](./index.md)

## about (6)

- [Code Of Conduct](./about/coc.md): In the interest of fostering an open and welcoming environment, we as contributors and maintainers pledge to making participation in our project an...
- [Community Guide](./about/community-guide.md): Vue's community is growing incredibly fast and if you're reading this, there's a good chance you're ready to join it. So... welcome!
- [Frequently Asked Questions](./about/faq.md): Vue is an independent, community-driven project. It was created by Evan You in 2014 as a personal side project. Today, Vue is actively maintained b...
- [Vue.js Privacy Policy](./about/privacy.md): This Privacy Policy describes the Vue.js organization ("Vue", "we", "us" or "our") practices for handling your information in connection with this ...
- [Releases](./about/releases.md): A full changelog of past releases is available on GitHub.
- [Meet the Team](./about/team.md)

## api (29)

- [Application API](./api/application.md): Creates an application instance.
- [Built-in Components](./api/built-in-components.md): :::info Registration and Usage
Built-in components can be used directly in templates without needing to be registered. They are also tree-shakeable...
- [Built-in Directives](./api/built-in-directives.md): Update the element's text content.
- [Built-in Special Attributes](./api/built-in-special-attributes.md): The key special attribute is primarily used as a hint for Vue's virtual DOM algorithm to identify vnodes when diffing the new list of nodes against...
- [Built-in Special Elements](./api/built-in-special-elements.md): :::info Not Components
<component>, <slot> and <template> are component-like features and part of the template syntax. They are not true components...
- [Compile-Time Flags](./api/compile-time-flags.md): :::tip
Compile-time flags only apply when using the esm-bundler build of Vue (i.e. vue/dist/vue.esm-bundler.js).
:::
- [Component Instance](./api/component-instance.md): :::info
This page documents the built-in properties and methods exposed on the component public instance, i.e. this.
- [Composition API: <br>Dependency Injection](./api/composition-api-dependency-injection.md): Provides a value that can be injected by descendant components.
- [Composition API: Helpers](./api/composition-api-helpers.md): Returns the attrs object from the Setup Context, which includes the fallthrough attributes of the current component. This is intended to be used in...
- [Composition API: Lifecycle Hooks](./api/composition-api-lifecycle.md): :::info Usage Note
All APIs listed on this page must be called synchronously during the setup() phase of a component. See Guide - Lifecycle Hooks f...
- [Composition API: setup()](./api/composition-api-setup.md): The setup() hook serves as the entry point for Composition API usage in components in the following cases:
- [Custom Elements API](./api/custom-elements.md): This method accepts the same argument as defineComponent, but instead returns a native Custom Element class constructor.
- [Custom Renderer API](./api/custom-renderer.md): Creates a custom renderer. By providing platform-specific node creation and manipulation APIs, you can leverage Vue's core runtime to target non-DO...
- [Global API: General](./api/general.md): Exposes the current version of Vue.
- [API Reference](./api/index.md)
- [Options: Composition](./api/options-composition.md): Provide values that can be injected by descendant components.
- [Options: Lifecycle](./api/options-lifecycle.md): :::info See also
For shared usage of lifecycle hooks, see Guide - Lifecycle Hooks
:::
- [Options: Misc](./api/options-misc.md): Explicitly declare a display name for the component.
- [Options: Rendering](./api/options-rendering.md): A string template for the component.
- [Options: State](./api/options-state.md): A function that returns the initial reactive state for the component instance.
- [Reactivity API: Advanced](./api/reactivity-advanced.md): Shallow version of ref().
- [Reactivity API: Core](./api/reactivity-core.md): :::info See also
To better understand the Reactivity APIs, it is recommended to read the following chapters in the guide:
- [Reactivity API: Utilities](./api/reactivity-utilities.md): Checks if a value is a ref object.
- [Render Function APIs](./api/render-function.md): Creates virtual DOM nodes (vnodes).
- [SFC CSS Features](./api/sfc-css-features.md): When a  tag has the scoped attribute, its CSS will apply to elements of the current component only. This is similar to the style encapsulati...
- [](./api/sfc-script-setup.md):  is a compile-time syntactic sugar for using Composition API inside Single-File Components (SFCs). It is the recommended syntax if yo...
- [SFC Syntax Specification](./api/sfc-spec.md): A Vue Single-File Component (SFC), conventionally using the .vue file extension, is a custom file format that uses an HTML-like syntax to describe ...
- [Server-Side Rendering API](./api/ssr.md): Renders input as a Node.js Readable stream.
- [Utility Types](./api/utility-types.md): :::info
This page only lists a few commonly used utility types that may need explanation for their usage. For a full list of exported types, consul...

## ecosystem (2)

- [Community Newsletters](./ecosystem/newsletters.md): There are many great newsletters / Vue-dedicated blogs from the community bringing you latest news and happenings in the Vue ecosystem. Here is a n...
- [themes](./ecosystem/themes.md)

## error-reference (1)

- [Production Error Code Reference](./error-reference/index.md): In production builds, the 3rd argument passed to the following error handler APIs will be a short code instead of the full information string:

## examples (1)

- [Examples](./examples/index.md)

## glossary (1)

- [Glossary](./glossary/index.md): This glossary is intended to provide some guidance about the meanings of technical terms that are in common usage when talking about Vue. It is int...

## guide/best-practices (4)

- [Accessibility](./guide/best-practices/accessibility.md): Web accessibility (also known as a11y) refers to the practice of creating websites that can be used by anyone — be that a person with a disability,...
- [Performance](./guide/best-practices/performance.md): Vue is designed to be performant for most common use cases without much need for manual optimizations. However, there are always challenging scenar...
- [Production Deployment](./guide/best-practices/production-deployment.md): During development, Vue provides a number of features to improve the development experience:
- [Security](./guide/best-practices/security.md): When a vulnerability is reported, it immediately becomes our top concern, with a full-time contributor dropping everything to work on it. To report...

## guide/built-ins (5)

- [KeepAlive](./guide/built-ins/keep-alive.md): <KeepAlive> is a built-in component that allows us to conditionally cache component instances when dynamically switching between multiple components.
- [Suspense](./guide/built-ins/suspense.md): :::warning Experimental Feature
<Suspense> is an experimental feature. It is not guaranteed to reach stable status and the API may change before it...
- [Teleport](./guide/built-ins/teleport.md): <Teleport> is a built-in component that allows us to "teleport" a part of a component's template into a DOM node that exists outside the DOM hierar...
- [TransitionGroup](./guide/built-ins/transition-group.md): <TransitionGroup> is a built-in component designed for animating the insertion, removal, and order change of elements or components that are render...
- [Transition](./guide/built-ins/transition.md): Vue offers two built-in components that can help work with transitions and animations in response to changing state:

## guide/components (8)

- [Async Components](./guide/components/async.md): In large applications, we may need to divide the app into smaller chunks and only load a component from the server when it's needed. To make that p...
- [Fallthrough Attributes](./guide/components/attrs.md): A "fallthrough attribute" is an attribute or v-on event listener that is passed to a component, but is not explicitly declared in the receiving com...
- [Component Events](./guide/components/events.md): A component can emit custom events directly in template expressions (e.g. in a v-on handler) using the built-in $emit method:
- [Props](./guide/components/props.md): Vue components require explicit props declaration so that Vue knows what external props passed to the component should be treated as fallthrough at...
- [Provide / Inject](./guide/components/provide-inject.md): Usually, when we need to pass data from the parent to a child component, we use props. However, imagine the case where we have a large component tr...
- [Component Registration](./guide/components/registration.md): A Vue component needs to be "registered" so that Vue knows where to locate its implementation when it is encountered in a template. There are two w...
- [Slots](./guide/components/slots.md): We have learned that components can accept props, which can be JavaScript values of any type. But how about template content? In some cases, we may...
- [Component v-model](./guide/components/v-model.md): v-model can be used on a component to implement a two-way binding.

## guide/essentials (13)

- [Creating a Vue Application](./guide/essentials/application.md): Every Vue application starts by creating a new application instance with the createApp function:
- [Class and Style Bindings](./guide/essentials/class-and-style.md): A common need for data binding is manipulating an element's class list and inline styles. Since class and style are both attributes, we can use v-b...
- [Components Basics](./guide/essentials/component-basics.md): Components allow us to split the UI into independent and reusable pieces, and think about each piece in isolation. It's common for an app to be org...
- [Computed Properties](./guide/essentials/computed.md): In-template expressions are very convenient, but they are meant for simple operations. Putting too much logic in your templates can make them bloat...
- [Conditional Rendering](./guide/essentials/conditional.md): The directive v-if is used to conditionally render a block. The block will only be rendered if the directive's expression returns a truthy value.
- [Event Handling](./guide/essentials/event-handling.md): We can use the v-on directive, which we typically shorten to the @ symbol, to listen to DOM events and run some JavaScript when they're triggered. ...
- [Form Input Bindings](./guide/essentials/forms.md): When dealing with forms on the frontend, we often need to sync the state of form input elements with corresponding state in JavaScript. It can be c...
- [Lifecycle Hooks](./guide/essentials/lifecycle.md): Each Vue component instance goes through a series of initialization steps when it's created - for example, it needs to set up data observation, com...
- [List Rendering](./guide/essentials/list.md): We can use the v-for directive to render a list of items based on an array. The v-for directive requires a special syntax in the form of item in it...
- [Reactivity Fundamentals](./guide/essentials/reactivity-fundamentals.md): :::tip API Preference
This page and many other chapters later in the guide contain different content for the Options API and the Composition API. Y...
- [Template Refs](./guide/essentials/template-refs.md): While Vue's declarative rendering model abstracts away most of the direct DOM operations for you, there may still be cases where we need direct acc...
- [Template Syntax](./guide/essentials/template-syntax.md): Vue uses an HTML-based template syntax that allows you to declaratively bind the rendered DOM to the underlying component instance's data. All Vue ...
- [Watchers](./guide/essentials/watchers.md): Computed properties allow us to declaratively compute derived values. However, there are cases where we need to perform "side effects" in reaction ...

## guide/extras (8)

- [Animation Techniques](./guide/extras/animation.md): Vue provides the <Transition> and <TransitionGroup> components for handling enter / leave and list transitions. However, there are many other ways ...
- [Composition API FAQ](./guide/extras/composition-api-faq.md): :::tip
This FAQ assumes prior experience with Vue - in particular, experience with Vue 2 while primarily using Options API.
:::
- [Reactivity in Depth](./guide/extras/reactivity-in-depth.md): One of Vue’s most distinctive features is the unobtrusive reactivity system. Component state consists of reactive JavaScript objects. When you modi...
- [Reactivity Transform](./guide/extras/reactivity-transform.md): :::danger Removed Experimental Feature
Reactivity Transform was an experimental feature, and has been removed in the latest 3.4 release. Please rea...
- [Render Functions & JSX](./guide/extras/render-function.md): Vue recommends using templates to build applications in the vast majority of cases. However, there are situations where we need the full programmat...
- [Rendering Mechanism](./guide/extras/rendering-mechanism.md): How does Vue take a template and turn it into actual DOM nodes? How does Vue update those DOM nodes efficiently? We will attempt to shed some light...
- [Ways of Using Vue](./guide/extras/ways-of-using-vue.md): We believe there is no "one size fits all" story for the web. This is why Vue is designed to be flexible and incrementally adoptable. Depending on ...
- [Vue and Web Components](./guide/extras/web-components.md): Web Components is an umbrella term for a set of web native APIs that allows developers to create reusable custom elements.

## guide (2)

- [Introduction](./guide/introduction.md): :::info You are reading the documentation for Vue 3!
- [Quick Start](./guide/quick-start.md): :::tip Prerequisites

## guide/reusability (3)

- [Composables](./guide/reusability/composables.md): :::tip
This section assumes basic knowledge of Composition API. If you have been learning Vue with Options API only, you can set the API Preference...
- [Custom Directives](./guide/reusability/custom-directives.md): In addition to the default set of directives shipped in core (like v-model or v-show), Vue also allows you to register your own custom directives.
- [Plugins](./guide/reusability/plugins.md): Plugins are self-contained code that usually add app-level functionality to Vue. This is how we install a plugin:

## guide/scaling-up (6)

- [Routing](./guide/scaling-up/routing.md): Routing on the server side means the server is sending a response based on the URL path that the user is visiting. When we click on a link in a tra...
- [Single-File Components](./guide/scaling-up/sfc.md): Vue Single-File Components (a.k.a. .vue files, abbreviated as SFC) is a special file format that allows us to encapsulate the template, logic, and ...
- [Server-Side Rendering (SSR)](./guide/scaling-up/ssr.md): Vue.js is a framework for building client-side applications. By default, Vue components produce and manipulate DOM in the browser as output. Howeve...
- [State Management](./guide/scaling-up/state-management.md): Technically, every Vue component instance already "manages" its own reactive state. Take a simple counter component as an example:
- [Testing](./guide/scaling-up/testing.md): Automated tests help you and your team build complex Vue applications quickly and confidently by preventing regressions and encouraging you to brea...
- [Tooling](./guide/scaling-up/tooling.md): You don't need to install anything on your machine to try out Vue SFCs - there are online playgrounds that allow you to do so right in the browser:

## guide/typescript (3)

- [TypeScript with Composition API](./guide/typescript/composition-api.md): When using , the defineProps() macro supports inferring the props types based on its argument:
- [TypeScript with Options API](./guide/typescript/options-api.md): :::tip
While Vue does support TypeScript usage with Options API, it is recommended to use Vue with TypeScript via Composition API as it offers simp...
- [Using Vue with TypeScript](./guide/typescript/overview.md): A type system like TypeScript can detect many common errors via static analysis at build time. This reduces the chance of runtime errors in product...

## partners (3)

- [[partnerId]](./partners/[partnerId].md)
- [all](./partners/all.md)
- [Vue Partners](./partners/index.md)

## sponsor (1)

- [Become a Vue.js Sponsor](./sponsor/index.md): Vue.js is an MIT licensed open source project and completely free to use.
The tremendous amount of effort needed to maintain such a large ecosystem...

## style-guide (5)

- [Style Guide](./style-guide/index.md): ::: warning Note
This Vue.js Style Guide is outdated and needs to be reviewed. If you have any questions or suggestions, please open an issue.
:::
- [Priority A Rules: Essential](./style-guide/rules-essential.md): ::: warning Note
This Vue.js Style Guide is outdated and needs to be reviewed. If you have any questions or suggestions, please open an issue.
:::
- [Priority C Rules: Recommended](./style-guide/rules-recommended.md): ::: warning Note
This Vue.js Style Guide is outdated and needs to be reviewed. If you have any questions or suggestions, please open an issue.
:::
- [Priority B Rules: Strongly Recommended](./style-guide/rules-strongly-recommended.md): ::: warning Note
This Vue.js Style Guide is outdated and needs to be reviewed. If you have any questions or suggestions, please open an issue.
:::
- [Priority D Rules: Use with Caution](./style-guide/rules-use-with-caution.md): ::: warning Note
This Vue.js Style Guide is outdated and needs to be reviewed. If you have any questions or suggestions, please open an issue.
:::

## translations (1)

- [Translations](./translations/index.md): The Vue documentation has recently undergone a major revision, so translations in other languages are still missing or work-in-progress.

## tutorial (1)

- [Tutorial](./tutorial/index.md)

## tutorial/src/step-1 (1)

- [Getting Started](./tutorial/src/step-1/description.md): Welcome to the Vue tutorial!

## tutorial/src/step-10 (1)

- [Watchers](./tutorial/src/step-10/description.md): Sometimes we may need to perform "side effects" reactively - for example, logging a number to the console when it changes. We can achieve this with...

## tutorial/src/step-11 (1)

- [Components](./tutorial/src/step-11/description.md): So far, we've only been working with a single component. Real Vue applications are typically created with nested components.

## tutorial/src/step-12 (1)

- [Props](./tutorial/src/step-12/description.md): A child component can accept input from the parent via props. First, it needs to declare the props it accepts:

## tutorial/src/step-13 (1)

- [Emits](./tutorial/src/step-13/description.md): In addition to receiving props, a child component can also emit events to the parent:

## tutorial/src/step-14 (1)

- [Slots](./tutorial/src/step-14/description.md): In addition to passing data via props, the parent component can also pass down template fragments to the child via slots:

## tutorial/src/step-15 (1)

- [You Did It!](./tutorial/src/step-15/description.md): You have finished the tutorial!

## tutorial/src/step-2 (1)

- [Declarative Rendering](./tutorial/src/step-2/description.md): What you see in the editor is a Vue Single-File Component (SFC). An SFC is a reusable self-contained block of code that encapsulates HTML, CSS and ...

## tutorial/src/step-3 (1)

- [Attribute Bindings](./tutorial/src/step-3/description.md): In Vue, mustaches are only used for text interpolation. To bind an attribute to a dynamic value, we use the v-bind directive:

## tutorial/src/step-4 (1)

- [Event Listeners](./tutorial/src/step-4/description.md): We can listen to DOM events using the v-on directive:

## tutorial/src/step-5 (1)

- [Form Bindings](./tutorial/src/step-5/description.md): Using v-bind and v-on together, we can create two-way bindings on form input elements:

## tutorial/src/step-6 (1)

- [Conditional Rendering](./tutorial/src/step-6/description.md): We can use the v-if directive to conditionally render an element:

## tutorial/src/step-7 (1)

- [List Rendering](./tutorial/src/step-7/description.md): We can use the v-for directive to render a list of elements based on a source array:

## tutorial/src/step-8 (1)

- [Computed Property](./tutorial/src/step-8/description.md): Let's keep building on top of the todo list from the last step. Here, we've already added a toggle functionality to each todo. This is done by addi...

## tutorial/src/step-9 (1)

- [Lifecycle and Template Refs](./tutorial/src/step-9/description.md): So far, Vue has been handling all the DOM updates for us, thanks to reactivity and declarative rendering. However, inevitably there will be cases w...
