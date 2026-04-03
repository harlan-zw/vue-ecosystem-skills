# What is FormKit?

FormKit is a form authoring framework for Vue developers that makes building high quality production-ready forms 10x faster.

## Introduction

FormKit is far more than a UI library. It is a comprehensive *form building framework* for Vue developers that makes authoring high-quality production-ready forms faster and more accessible, with better DX, UX, and less code. It is easy to learn, and ships with production-ready features like inputs, validation rules, and submission/error handling.

### What is a "form framework"?

Why do I need a full-fledged framework for forms? Aren't forms easy? Don't UI libraries and frameworks like Vue already solve all the problems? No — because forms are their own distinct problem set, they represent their own distinct data trees, and they deserve their own framework.

The best overview of FormKit is Justin Schroeder's (the primary author of FormKit) 2023 VueConf US talk called "Conquering Forms in Vue". The video below starts at ~12 minutes into the talk — but if you have the time it's worth watching from the beginning.

Short on time? Read the introduction post that explains the goals of FormKit written when the framework first launched.

## Why FormKit?

Forms seem simple. After all, a `<form>` and an `<input>` tag are all that's required. Yet, experienced engineers know that implementing production-ready forms is tedious and complicated. FormKit's key features were designed to solve these problems, while making form authoring efficient and enjoyable for developers:

#### Key Features

- [Automatic Architecture](#automatic-architecture): FormKit self-assembles your form's data tree in the background — No more prop-drilling.
- [Single component](#single-component): FormKit was designed with a single component for all inputs.
- [Accessibility](#accessibility): We output an opinionated accessible markup by default.
- [Validation](#validation): Numerous built-in validation rules with instant feedback.
- [Schema](#schema): Powerful schema format to store and generate forms.
- [Styles](#styles): Beautifully crafted theme.
- [Extensibility](#extensibility): Easy to extend any feature.
- [Community](#community): Friendly community that will help you solve your questions.

### Automatic Architecture

FormKit's automatic architecture is a game-changer for DX. It self-assembles your form's data tree in the background — at infinite depth — so that you don't have to worry about prop-drilling or event emitting to wrangle your data. This makes it easy to build complex forms with nested data structures, and it's a huge time-saver when you're working with large forms.

### Single Component

Developers love to learn — but no one enjoys pouring over third-party APIs and configuration options. That's why FormKit uses a single component for all of its [inputs](/essentials/inputs). `<FormKit>` is the only component you need to know to get started — and it works just like you would expect an `<input>` tag to work.

### Accessibility

Creating accessible forms is a serious challenge. Especially when accessibility standards are not always clear and most developers are under time pressure. Ideally, all developers would be well versed in accessibility best practices, but unfortunately that is not the case. To address this, FormKit outputs an opinionated accessible DOM structure. This is different than many popular “renderless” form libraries that provide no markup at all and rely on developers to supply the inputs themselves.

### Validation

Front-end [validation](/essentials/validation) that gives instant feedback is an important part of providing a good experience to your users. Unfortunately, it can be incredibly tedious to implement, even if you're using a great validation library. FormKit takes the pain out of front-end validation by baking the [rules](/essentials/validation#available-rules) directly into the inputs.

### Schema

FormKit's [schema](/essentials/schema) is a JSON-serializable data format for storing DOM structures and component implementations, including FormKit forms. Schemas support advanced features like [form generation](/essentials/schema#form-generation-example), conditional logic, boolean operators, loops, slots, and data scoping — all guaranteed to serialize to a string.

### Styles

With the ability to modify FormKit's classes and even HTML, FormKit provides many ways to style your forms. You can roll your own CSS, use a utility class framework like Tailwind CSS, or use one of our ready-built MIT-licensed themes available at https://themes.formkit.com!

### Extensibility

FormKit comes with great production-ready defaults, and for many users, the defaults are all they'll need. But FormKit is more than just inputs. It is a form building *framework*, complete with [hooks](/essentials/architecture#hooks), [events](/essentials/architecture#events), [plugins](/essentials/architecture#plugins), libraries, and [schemas](/essentials/schema). Advanced developers can craft their own form systems using FormKit's low-level tooling.

### Community

FormKit has an active Discord community where help is just a few keystrokes away. Community members and core team members alike spend time there helping users solve their issues.

## Why not...?

While FormKit does a lot of things, it is not a UI framework or a *layout* tool. Want inputs next to each other? Cool! Wrap some inputs in a `<div>` and sprinkle on some `flexbox`. While FormKit ships with a [default theme](/essentials/styling#optional-genesis-theme), this package assumes you'll still be responsible for most of your form's style and layout. FormKit plays nicely with any UI framework or your own custom styles.

If you need a full UI framework, you can check these other great tools:

#### Vuetify

Vuetify is a full UI framework while FormKit is a focused tool for building forms. Some people prefer not to use large UI frameworks, don’t have them on a pre-existing project, don’t want to learn a new framework, or just prefer writing their own narrowly scoped styles. Also, we think composing forms in FormKit is second-to-none.

#### Buefy

Similar to Vuetify, Buefy is a full UI framework. If you’re already using Bulma or you're looking for a comprehensive UI solution, it’s a solid choice. FormKit can live alongside any UI framework and still offers the benefits of slick form composition, validation, and error handling to name a few. Even still, there are plenty of people who don’t want or need a full UI framework that would benefit from FormKit’s focused approach.

#### VeeValidate

VeeValidate is a great option for Vue form validation, and that’s its primary mission — validation. FormKit makes building high quality forms easier by including validation as a sub-feature of the field composition itself. Building forms with FormKit is super easy and blazing fast — of course if you need the extra validation power, you still have it. You can write any [custom validation logic](/essentials/validation#custom-rules) you want.

#### Vuelidate

Yet another great option for form validation, but focused solely on validation. FormKit provides additional scaffolding and features such as accessibility, i18n, and input composition, enabling developers to create complex forms with minimal friction with validation and error handling included.

#### vue-form-generator

Generating forms from JSON is great — that's why schema is a sub-feature of FormKit. Pass your form schema to the `FormKitSchema` component and voilà! Check out the documentation [here](/essentials/schema#form-generation-example). Now you can use the same tool for form composition and generation!

## Video course

Prefer to learn by watching? Vue School has an excellent course to help you get started using FormKit to build robust forms for Vue.js. Learn the basics as well as more advanced topics, then head back here to the docs when you need to fill in the gaps for specific use cases.

## FormKit Discord server

If you need generalized help or want to make connections within the community, consider joining the official FormKit Discord. Over 1900 developers along with the core team members have active discussion there. If you are not already a member (it's free), you'll need to use the following invite link to join the server:
