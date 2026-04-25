# Plugins

Les plugins ajoutent des fonctionnalités au niveau global à l'API de Vue Test Utils. C'est la méthode officielle pour étendre l'API de Vue Test Utils avec une logique, des méthodes ou des fonctionnalités personnalisées.

Des cas d'utilisation pour les plugins&nbsp;:

1. Remplacer des méthodes publiques existantes.
2. Attacher des correspondances à l'instance `Wrapper`.
3. Ajouter une fonctionnalité au `Wrapper`.

## Plugin du `Wrapper`

### Utilisation d'un Plugin

Vous pouvez installer des plugins en appelant la méthode `config.plugins.VueWrapper.install()`. Cela doit être fait avant d'appeler `mount`.

La méthode `install()` recevra une instance de `WrapperAPI` contenant à la fois les propriétés publiques et privées de l'instance.

```js
// fichier setup.js
import { config } from '@vue/test-utils'

// plugin écrit en local, voir la section "Écrire un Plugin"
import MonPlugin from './myPlugin'

// installer le plugin dans le VueWrapper
config.plugins.VueWrapper.install(MyPlugin)
```

Vous pouvez aussi passer quelques options&nbsp;:

```js
config.plugins.VueWrapper.install(MonPlugin, {
  optionUne: true,
  optionDeux: 'abc'
})
```

Votre plugin doit être installé qu'une seule fois. Si vous utilisez Jest, cela devrait être dans `setupFiles` ou `setupFilesAfterEnv` de votre configuration Jest.

Certains plugins appellent automatiquement `config.plugins.VueWrapper.install()` lorsqu'ils sont importés. C'est une pratique courante s'ils étendent plusieurs interfaces en même temps. Suivez les instructions du plugin que vous installez dans tous les cas.

Consultez le guide de la communauté Vue ou awesome-vue pour une collection de plugins et de bibliothèques développés par la communauté.

### Écrire un Plugin

Un plugin Vue Test Utils est tout simplement une fonction qui reçoit l'instance montée de `VueWrapper` ou de `DOMWrapper` et peut la modifier.

#### Plugin de base

Ci-dessous se trouve un plugin simple pour ajouter un `alias` pratique pour mapper `wrapper.element` à `wrapper.$el`&nbsp;:

```js
// setup.js
import { config } from '@vue/test-utils'

const monPluginAlias = wrapper => {
  return {
    $el: wrapper.element // simple alias
  }
}

// Appellez `install` sur le type que vous voulez étendre avec votre plugin.
// Vous pouvez écrire un plugin de n'importe quel type dans `config.plugins`.
config.plugins.VueWrapper.install(monPluginAlias)
```

Et dans vos tests, vous pourrez utiliser votre plugin après `mount`.

```js
// component.spec.js
const wrapper = mount({ template: `<h1>🔌 Plugin</h1>` })
console.log(wrapper.$el.innerHTML) // 🔌 Plugin
```

#### Data Test ID Plugin

Le plugin ci-dessous ajoute une méthode `findByTestId` à l'instance `VueWrapper`. Cela encourage à utiliser une stratégie de sélection basée sur des attributs uniquement créés pour les tests sur vos composants Vue.

Utilisation&nbsp;:

`MonComposant.vue`:

```vue
<template>
  <MyForm class="form-container" data-testid="form">
    <MyInput data-testid="name-input" v-model="name" />
  </MyForm>
</template>
```

`MonComposant.spec.js`:

```js
const wrapper = mount(MonComposant)
wrapper.findByTestId('name-input') // retourne un VueWrapper ou DOMWrapper
```

Implémentation du plugin&nbsp;:

```js
import { config } from '@vue/test-utils'

const DataTestIdPlugin = wrapper => {
  function findByTestId(selector) {
    const dataSelector = `[data-testid='${selector}']`
    const element = wrapper.element.querySelector(dataSelector)
    if (element) {
      return new DOMWrapper(element)
    }

    return createWrapperError('DOMWrapper')
  }

  return {
    findByTestId
  }
}

config.plugins.VueWrapper.install(DataTestIdPlugin)
```

## Plugin de composants de substitution (Stub)

L'option `config.plugins.createStubs` permet de remplacer la création par défaut des composants (que nous appellerons `stubs`) fournie par VTU.

Plusieurs cas d'utilisation&nbsp;:

- Vous voulez ajouter plus de logique dans les `stubs` (par exemple des slots nommés).
- Vous voulez utiliser des `stubs` différents pour plusieurs composants (par exemple des composants `stub` d'une bibliothèque).

### Utilisation

```javascript
config.plugins.createStubs = ({ name, component }) => {
  return defineComponent({
    render: () => h(`custom-${name}-stub`)
  })
}
```

Cette fonction sera appelée chaque fois que VTU générera un `stub` soit à partir de …

```javascript
const wrapper = mount(Component, {
  global: {
    stubs: {
      ChildComponent: true
    }
  }
})
```

… ou de …

```javascript
const wrapper = shallowMount(Component)
```

Mais ne sera pas appelé si vous spécifiez explicitement un `stub`&nbsp;:

```javascript
const wrapper = mount(Component, {
  global: {
    stubs: {
      ChildComponent: { template: '<child-stub/>' }
    }
  }
})
```

## Utilisation d'un Plugin avec TypeScript

Pour utiliser votre plugin de wrapper personnalisé avec TypeScript, vous devez déclarer votre fonction de wrapper personnalisée. Par conséquent, ajoutez un fichier nommé `vue-test-utils.d.ts` avec le contenu suivant&nbsp;:

```typescript
import { DOMWrapper } from '@vue/test-utils'

declare module '@vue/test-utils' {
  export class VueWrapper {
    findByTestId(testId: string): DOMWrapper[]
  }
}
```

## Promouvoir votre Plugin

Si vous trouvez qu'une fonctionnalité est manquante, vous pouvez écrire un plugin pour étendre Vue Test Utils et le soumettre au Guide de la communauté Vue ou awesome-vue.
