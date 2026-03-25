---
title: Testing & Auditing
desc: (@quasar/app-vite) How to unit and end to end test a Quasar app.
---

Your Quasar projects have the ability to add unit and e2e testing harnesses. This introduction will not go into details about how to write and use tests, for that please consult the specially prepared and maintained documentation at the testing repo at GitHub. If you are a beginner, consider reading one of the books in the "Further Reading" section.

## High level overview

You can install multiple pre-rigged testing harnesses to your existing Quasar application by running a simple command. This command will pull and install a node module (with dependencies) into your project's `package.json`, place necessary configuration files as appropriate and add script commands that expose some of the functionality of the respective harness. You can add multiple harnesses and even use them for your continuous integration pipelines - as appropriate.

Testing is not in and of itself hard. The most complicated part is setting up the testing harness. The trick lies in knowing what to test. If you are new to testing, it is absolutely imperative that you familiarize yourself with some of the concepts and patterns. There are some links for further reading at the end of this document page.

## Testing documentation

You can find the documentation of testing AEs at https://testing.quasar.dev or into `dev` branch of quasar-testing repo.

<q-btn label="Testing AEs documentation" icon-right="launch" href="https://testing.quasar.dev" target="_blank" />

## Installing

```bash
$ cd your-quasar-project

$ quasar ext add @quasar/testing-e2e-cypress
# or
$ quasar ext add @quasar/testing-unit-jest
# or
$ quasar ext add @quasar/testing-unit-vitest
```

These extension will install the respective harnesses, which you can configure as you like.
It is how multiple testing harnesses are ideally managed within a Quasar project.
If you ever need to review your installation choices you can take a look at `quasar.extensions.json`.

> Note that we previously suggested to use `@quasar/testing` AE to manage all testing harnesses in a project. This is no longer the case, as it is now deprecated. Please use the above commands instead.

## Further Reading

### Books

- Testing Vue.js Applications by Edd Yerburgh, the author of the `@vue/test-utils` repo
- Free Vue Testing Handbook

### Tutorials

- Unit Testing Vue Router with Jest

### Documentation

- @vue/test-utils
- jest 24
- cypress
- lighthouse
- snyk
- nlf
- chai
- istanbul
