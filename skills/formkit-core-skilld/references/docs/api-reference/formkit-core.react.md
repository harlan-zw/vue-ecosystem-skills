# formkit/core

# @formkit/core

## Introduction

The official FormKit core library. This package is responsible for most of FormKit's internal functionality. You can read documentation specifically on how it works at formkit.com.

You can add this package by using `npm install @formkit/core` or `yarn add @formkit/core`.

## FormKitNode

FormKit's Node object produced by createNode(). Every `<FormKit />` input has 1 FormKitNode ("core node") associated with it. All inputs, forms, and groups are instances of nodes. Read more about core nodes in the architecture
documentation.

### add()

**Type:** Function

Add a child to a node. The node must be a group or list.
#### Signature
```
add: (node: FormKitNode, index?: number) => FormKitNode

```
#### Parameters
- node — A [FormKitNode](#formkitnode).
- index *optional* — A index to where it will added to.
#### Returns
The added [FormKitNode](#formkitnode).


### address

**Type:** Property

The address of the current node from the root of the tree.
#### Signature
```
address: FormKitAddress

```
#### Returns
A [FormKitAddress](#formkitaddress).


### addProps()

**Type:** Function

Adds props to the given node by removing them from node.props.attrs and moving them to the top-level node.props object.
#### Signature
```
addProps: (props: string[]) => FormKitNode

```
#### Parameters
- `props` — An array of strings to be added as keys for props.
#### Returns
The [FormKitNode](#formkitnode).


### at()

**Type:** Function

Gets a node at another address. Addresses are dot-syntax paths (or arrays) of node names. For example: `form.users.0.first_name`. There are a few "special" traversal tokens as well:
- `$root` — Selects the root node.
- `$parent` — Selects the parent node.
- `$self` — Selects the current node.
#### Signature
```
at: (address: FormKitAddress | string) => FormKitNode | undefined

```
#### Parameters
- `address` — An valid string or [FormKitAddress](#formkitaddress).
#### Returns
The found [FormKitNode](#formkitnode) or `undefined`.


### children

**Type:** Property

An array of child nodes (groups and lists).
#### Signature
```
children: Array<FormKitNode>

```
#### Returns
An array of [FormKitNode](#formkitnode).


### clearErrors()

**Type:** Function

Clears the errors of the node, and optionally all the children.
#### Signature
```
clearErrors: (clearChildren?: boolean, sourceKey?: string) => FormKitNode

```
#### Parameters
- `clearChildren` *optional* — If it should clear the children.
- `sourceKey` *optional* — A source key to use for reset.
#### Returns
The [FormKitNode](#formkitnode).


### config

**Type:** Property

An object of [FormKitConfig](#formkitconfig) that is shared tree-wide with various configuration options that should be applied to the entire tree.
#### Signature
```
config: FormKitConfig

```
#### Returns
A [FormKitConfig](#formkitconfig).


### define()

**Type:** Function

Defines the current input's library type definition including node type, schema, and props.
#### Signature
```
define: (definition: FormKitTypeDefinition) => void

```
#### Parameters
- `definition` — A [FormKitTypeDefinition](#formkittypedefinition).


### destroy()

**Type:** Function

Removes the node from the global registry, its parent, and emits the 'destroying' event.
#### Signature
```
destroy: () => void

```


### each()

**Type:** Function

Perform given callback on each of the given node's children.
#### Signature
```
each: (callback: FormKitChildCallback) => void

```
#### Parameters
- `callback` — A [FormKitChildCallback](#formkitchildcallback) to be called for each child.


### emit()

**Type:** Function

Emit an event from the node so it can be listened by [on](#formkitnode).
#### Signature
```
emit: (event: string, payload?: any, bubble?: boolean, meta: Record<string, unknown>) => FormKitNode

```
#### Parameters
- `event` — The event name to be emitted.
- `payload` *optional* — A value to be passed together with the event.
- `bubble` *optional* — If the event should bubble to the parent.
#### Returns
The [FormKitNode](#formkitnode).


### extend()

**Type:** Function

Extend a [FormKitNode](#formkitnode) by adding arbitrary properties that are accessible via `node.{property}()`.
#### Signature
```
extend: (property: string, trap: FormKitTrap) => FormKitNode

```
#### Parameters
- `property` — The property to add the core node (`node.{property}`).
- `trap` — An object with a get and set property.
#### Returns
The [FormKitNode](#formkitnode).


### find()

**Type:** Function

Within a given tree, find a node matching a given selector. Selectors can be simple strings or a function.
#### Signature
```
find: (
 selector: string,
 searcher?: keyof FormKitNode | FormKitSearchFunction
) => FormKitNode | undefined

```
#### Parameters
- `selector` — A selector string.
- `searcher` *optional* — A keyof [FormKitNode](#formkitnode) or [FormKitSearchFunction](#formkitsearchfunction).
#### Returns
The found [FormKitNode](#formkitnode) or `undefined`.


### hook

**Type:** Property

Set of hooks.
#### Signature
```
hook: FormKitHooks

```
#### Returns
The [FormKitHooks](#formkithooks).


### index

**Type:** Property

The index of a node compared to its siblings. This is only applicable in cases where a node is a child of a list.
#### Signature
```
index: number

```
#### Returns
A `number`.


### input()

**Type:** Function

The function used to set the value of a node. All changes to a node's value should use this function as it ensures the tree's state is always fully tracked.
#### Signature
```
input: (value: unknown, async?: boolean) => Promise<unknown>

```
#### Parameters
- `value` — Any value to used for the node.
- `async` *optional* — If the input should happen asynchronously.
#### Returns
A `Promise<unknown>`.


### isCreated

**Type:** Property

Begins as false, set to true when the node is finished being created.
#### Signature
```
isCreated: boolean

```
#### Returns
A `boolean`.


### isSettled

**Type:** Property

Boolean reflecting the settlement state of the node and its subtree.
#### Signature
```
isSettled: boolean

```
#### Returns
A `boolean`.


### ledger

**Type:** Property

A counting ledger for arbitrary message counters.
#### Signature
```
ledger: FormKitLedger

```
#### Returns
A [FormKitLedger](#formkitledger).


### name

**Type:** Property

The name of the input in the node tree. When a node is a child of a list, this automatically becomes its index.
#### Signature
```
name: string

```
#### Returns
A `string`.


### off()

**Type:** Function

Removes an event listener by its token. Receipts can be shared among many event listeners by explicitly declaring the "receipt" property of the listener function.
#### Signature
```
off: (receipt: string) => FormKitNode

```
#### Parameters
- `receipt` — A receipt generated by the `on` function.
#### Returns
A receipt `string`.


### on()

**Type:** Function

Adds an event listener for a given event, and returns a "receipt" which is a random string token. This token should be used to remove the listener in the future. Alternatively you can assign a "receipt" property to the listener function and that receipt will be used instead. This allows multiple listeners to all be de-registered with a single off() call if they share the same receipt.
#### Signature
```
on: (eventName: string, listener: FormKitEventListener) => string

```
#### Parameters
- `eventName` — The event name to listen to.
- `listener` — A [FormKitEventListener](#formkiteventlistener) to run when the event happens.
#### Returns
A receipt `string`.


### parent

**Type:** Property

The parent of a node.
#### Signature
```
parent: FormKitNode | null

```
#### Returns
If found a [FormKitNode](#formkitnode) or `null`.


### props

**Type:** Property

An proxied object of props. These are typically provided by the adapter of choice.
#### Signature
```
props: Partial<FormKitProps>

```
#### Returns
An optional list of [FormKitProps](#formkitprops).


### remove()

**Type:** Function

Removes a child from the node.
#### Signature
```
remove: (node: FormKitNode) => FormKitNode

```
#### Parameters
- `node` — A [FormKitNode](#formkitnode) to be removed.
#### Returns
The [FormKitNode](#formkitnode).


### reset()

**Type:** Function

Resets the node's value back to its original value.
#### Signature
```
reset: () => FormKitNode

```
#### Returns
The [FormKitNode](#formkitnode).


### root

**Type:** Property

Retrieves the root node of a tree. This is accomplished via tree-traversal on-request, and as such should not be used in frequently called functions.
#### Signature
```
root: FormKitNode

```
#### Returns
The [FormKitNode](#formkitnode).


### setErrors()

**Type:** Function

Sets errors on the input, and optionally to child inputs.
#### Signature
```
setErrors: (localErrors: ErrorMessages, childErrors?: ErrorMessages) => void

```
#### Parameters
- `localErrors` — A [ErrorMessages](#errormessages) to be used.
- `childErrors` *optional* — A [ErrorMessages](#errormessages) to be used for children.


### settled

**Type:** Property

A promise that resolves when a node and its entire subtree is settled. In other words — all the inputs are done committing their values.
#### Signature
```
settled: Promise<unknown>

```
#### Returns
A `Promise<unknown>`.


### store

**Type:** Property

The internal node store.
#### Signature
```
store: FormKitStore

```
#### Returns
A [FormKitStore](#formkitstore).


### submit()

**Type:** Function

Triggers a submit event on the nearest form.
#### Signature
```
submit: () => void

```


### t()

**Type:** Function

A text or translation function that exposes a given string to the "text" hook. All text shown to users should be passed through this function before being displayed — especially for core and plugin authors.
#### Signature
```
t: (key: string | FormKitTextFragment) => string

```
#### Parameters
- `key` — A key or a [FormKitTextFragment](#formkittextfragment) to find the translation for.
#### Returns
The translated `string`.


### type

**Type:** Property

The type of node, should only be 'input', 'list', or 'group'.
#### Signature
```
type: FormKitNodeType

```
#### Returns
A [FormKitNodeType](#formkitnodetype).


### use()

**Type:** Function

Registers a new plugin on the node and its subtree.
#### Signature
```
use: (
 plugin: FormKitPlugin | FormKitPlugin[] | Set<FormKitPlugin>,
 run?: boolean,
 library?: boolean
) => FormKitNode

```
#### Parameters
- `plugin` — A [FormKitPlugin](#formkitplugin) or an Array or Set of [FormKitPlugin](#formkitplugin).
- `run` *optional* — Should the plugin be executed on creation.
- `library` *optional* — Should the plugin's library function be executed on creation.
#### Returns
The [FormKitNode](#formkitnode).


### value

**Type:** Property

The value of the input. This should never be directly modified. Any desired mutations should be made through [input](#formkitnode).
#### Signature
```
readonly value: unknown

```


### walk()

**Type:** Function

Performs a function on every node in its subtree (but not the node itself). This is an expensive operation so it should be done very rarely and only lifecycle events that are relatively rare like boot up and shut down.
#### Signature
```
walk: (callback: FormKitChildCallback, stopOnFalse?: boolean, recurseOnFalse?: boolean) => void

```
#### Parameters
- `callback` — A [FormKitChildCallback](#formkitchildcallback) to be executed for each child.
- `stopOnFalse` *optional* — If it should stop when the return is false.


## Functions

### bfs()

**Type:** Function

Perform a breadth-first search on a node subtree and locate the first instance of a match.
#### Signature
```
bfs(tree: FormKitNode, searchValue: string | number, searchGoal?: keyof FormKitNode | FormKitSearchFunction): FormKitNode | undefined;

```
#### Parameters
- `tree` — A [FormKitNode](#formkitnode) to start from.
- `searchValue` — A value to be searched.
- `searchGoal` *optional* — A goal value.
#### Returns
A [FormKitNode](#formkitnode) or `undefined`.


### clearErrors()

**Type:** Function

Clears errors on the node and optionally its children.
#### Signature
```
clearErrors(id: string, clearChildren?: boolean): void;

```
#### Parameters
- `id` — The id of the node you want to clear errors for.
- `clearChildren` *optional* — Determines if the children of this node should have their errors cleared.


### compile()

**Type:** Function

Compiles a logical string like `"a != z || b == c"` into a single function. The return value is an object with a "provide" method that iterates over all requirement tokens to use as replacements.
#### Signature
```
compile(expr: string): FormKitCompilerOutput;

```
#### Parameters
- `expr` — A string to compile.
#### Returns
A [FormKitCompilerOutput](#formkitcompileroutput).
#### Examples
```
let name = {
  value: 'jon'
}
const condition = compile("$name == 'bob'").provide((token) => {
 return () => name.value // must return a function!
})

condition() // false

```


### createClasses()

**Type:** Function

Function that produces a standardized object representation of CSS classes.
#### Signature
```
createClasses(propertyKey: string, node: FormKitNode, sectionClassList?: FormKitClasses | string | Record<string, boolean>): Record<string, boolean>;

```
#### Parameters
- `propertyKey` — the section key.
- `node` — A [FormKitNode](#formkitnode).
- `sectionClassList` *optional* — A `string | Record<string, boolean>` or a [FormKitClasses](#formkitclasses).
#### Returns
`Record<string, boolean>`


### createConfig()

**Type:** Function

Creates a new instance of a global configuration option. This object is essentially just a FormKitOption object, but it can be used as the root for FormKitConfig's proxy and retain event "emitting".
#### Signature
```
createConfig(options?: Partial<FormKitConfig>): FormKitRootConfig;

```
#### Parameters
- `options` *optional* — An object of optional properties of [FormKitConfig](#formkitconfig).
#### Returns
A [FormKitRootConfig](#formkitrootconfig).


### createMessage()

**Type:** Function

Creates a new FormKitMessage object.
#### Signature
```
createMessage(conf: Partial<FormKitMessage>, node?: FormKitNode): FormKitMessageProps;

```
#### Parameters
- `conf` — An object of optional properties of [FormKitMessage](#formkitmessage).
- `node` *optional* — A [FormKitNode](/api-reference/formkit-node#formkitnode).
#### Returns
A [FormKitMessageProps](#formkitmessageprops).


### createNode()

**Type:** Function

Creates a new instance of a FormKit Node. Nodes are the atomic unit of a FormKit graph.
#### Signature
```
createNode<V = unknown>(options?: FormKitOptions): FormKitNode<V>;

```
#### Parameters
- `options` *optional* — An options object of [FormKitOptions](#formkitoptions) to override the defaults.
#### Returns
A [FormKitNode](/api-reference/formkit-core#formkitnode).
#### Examples
```
import { createNode } from '@formkit/core'

const input = createNode({
  type: 'input', // defaults to 'input' if not specified
  value: 'hello node world',
})

console.log(input.value)
// 'hello node world'

```


### createValue()

**Type:** Function

Creates the initial value for a node based on the options passed in and the type of the input.
#### Signature
```
createValue(options: FormKitOptions): unknown;

```
#### Parameters
- `options` — A [FormKitOptions](#formkitoptions).
#### Returns
`unknown`


### deregister()

**Type:** Function

Deregister a node from the registry.
#### Signature
```
deregister(node: FormKitNode): void;

```
#### Parameters
- `node` — A [FormKitNode](#formkitnode).


### error()

**Type:** Function

Emits an error. Generally should result in an exception.
#### Signature
```
error(code: number, data?: any): never;

```
#### Parameters
- `code` — The integer error code.
- `data` *optional* — Usually an object of information to include.


### generateClassList()

**Type:** Function

Combines multiple class lists into a single list.
#### Signature
```
generateClassList(node: FormKitNode, property: string, ...args: Record<string, boolean>[]): string | null;

```
#### Parameters
- `node` — A [FormKitNode](#formkitnode).
- `property` — The property key to which the class list will be applied.
- `args` — And array of `Record<string, boolean>` of CSS class list(s).
#### Returns
`string | null`


### getNode()

**Type:** Function

Get a node by a particular id.
#### Signature
```
getNode(id: string): FormKitNode | undefined;

```
#### Parameters
- `id` — Get a node by a given id.
#### Returns
A [FormKitNode](#formkitnode) or `undefined`.


### isComponent()

**Type:** Function

Type narrow that a node is a DOM node.
#### Signature
```
isComponent(node: string | Record<PropertyKey, any>): node is FormKitSchemaComponent;

```
#### Parameters
- `node` — A schema node to check.
#### Returns
`boolean`


### isConditional()

**Type:** Function

Determines if a node is conditionally rendered or not.
#### Signature
```
isConditional(node: FormKitSchemaNode): node is FormKitSchemaCondition;
isConditional(node: FormKitSchemaAttributesCondition | FormKitSchemaAttributes): node is FormKitSchemaAttributesCondition;

```
#### Parameters
- `node` — A schema node to check.
#### Returns
`boolean`


### isDOM()

**Type:** Function

Type narrow that a node is a DOM node.
#### Signature
```
isDOM(node: string | Record<PropertyKey, any>): node is FormKitSchemaDOMNode;

```
#### Parameters
- `node` — A schema node to check
#### Returns
`boolean`


### isList()

**Type:** Function

A simple type guard to determine if the context being evaluated is a list type.
#### Signature
```
isList(arg: FormKitContextShape): arg is FormKitListContext;

```
#### Parameters
- `arg` — A [FormKitContextShape](#formkitcontextshape).
#### Returns
Returns a `boolean`.


### isNode()

**Type:** Function

Determine if a given object is a node.
#### Signature
```
isNode(node: any): node is FormKitNode;

```
#### Parameters
- `node` — Any value.
#### Returns
Returns a `boolean`.
#### Examples
```
import { isNode, createNode } from '@formkit/core'

const input = createNode({
  type: 'input', // defaults to 'input' if not specified
  value: 'hello node world',
})

const obj = {};

isNode(obj)
// false

isNode(input)
// true

```


### isPlaceholder()

**Type:** Function

Determines if a node is a placeholder node.
#### Signature
```
isPlaceholder(node: FormKitNode | FormKitPlaceholderNode): node is FormKitPlaceholderNode;

```
#### Parameters
- `node` — A [FormKitNode](#formkitnode)


### isSugar()

**Type:** Function

Determines if the node is syntactic sugar or not.
#### Signature
```
isSugar(node: FormKitSchemaNode): node is FormKitSchemaFormKit;

```
#### Parameters
- `node` — A schema node to check.
#### Returns
`boolean`


### names()

**Type:** Function

Create a name-based dictionary of all children in an array.
#### Signature
```
names(children: FormKitNode[]): {
    [index: string]: FormKitNode;
};

```
#### Parameters
- `children` — An array of [FormKitNode](#formkitnode).
#### Returns
A dictionary of named [FormKitNode](#formkitnode).


### register()

**Type:** Function

Registers a node to the registry *if* the node is a root node, *or* if the node has an explicit node.props.alias. If these two things are not true, then no node is registered (idempotent).
#### Signature
```
register(node: FormKitNode): void;

```
#### Parameters
- `node` — A [FormKitNode](#formkitnode).


### reset()

**Type:** Function

Resets an input to its "initial" value. If the input is a group or list it resets all the children as well.
#### Signature
```
reset(id: string | FormKitNode, resetTo?: unknown): FormKitNode | undefined;

```
#### Parameters
- `id` — The id of an input to reset.
- `resetTo` *optional* — A value to reset the node to.
#### Returns
A [FormKitNode](#formkitnode) or `undefined`.


### resetCount()

**Type:** Function

Resets the global number of node registrations, useful for deterministic node naming.
#### Signature
```
resetCount(): void;

```


### resetRegistry()

**Type:** Function

Resets the entire registry. Deregisters all nodes and removes all listeners.
#### Signature
```
resetRegistry(): void;

```


### setErrors()

**Type:** Function

Sets errors on a form, group, or input.
#### Signature
```
setErrors(id: string, localErrors: ErrorMessages, childErrors?: ErrorMessages): void;

```
#### Parameters
- `id` — The id of a form.
- `localErrors` — The errors to set on the form or the form's inputs in the format of [ErrorMessages](#errormessages).
- `childErrors` *optional* — (optional) The errors to set on the form or the form's inputs in the format of [ErrorMessages](#errormessages).


### submitForm()

**Type:** Function

Submits a FormKit form programmatically.
#### Signature
```
submitForm(id: string): void;

```
#### Parameters
- `id` — The id of the form.


### sugar()

**Type:** Function

Converts syntactic sugar nodes to standard nodes.
#### Signature
```
sugar<T extends FormKitSchemaNode>(node: T): Exclude<FormKitSchemaNode, string | FormKitSchemaFormKit>;

```
#### Parameters
- `node` — A node to covert.
#### Returns
A [FormKitSchemaNode](#formkitschemanode) without the properties of [FormKitSchemaFormKit](#formkitschemaformkit).


### warn()

**Type:** Function

Globally emits a warning.
#### Signature
```
warn(code: number, data?: any): void;

```
#### Parameters
- `code` — The integer warning code.
- `data` *optional* — Usually an object of information to include.


### watchRegistry()

**Type:** Function

A way of watching changes in the global registry.
#### Signature
```
watchRegistry(id: string, callback: FormKitEventListener): void;

```
#### Parameters
- `id` — A dot-syntax id where the node is located.
- `callback` — A callback in the format of [FormKitEventListener](#formkiteventlistener) to notify when the node is set or removed.


## TypeScript

### FormKitChildCallback

**Type:** Interface

The callback type for node.each().
```
interface FormKitChildCallback {
    (child: FormKitNode): any;
}

```


### FormKitChildValue

**Type:** Interface

A descriptor of a child value, generally passed up a node tree.
```
interface FormKitChildValue {
    from?: number | symbol;
    name: string | number | symbol;
    value: any;
}

```


### FormKitClasses

**Type:** Interface

Definition for a function that produces CSS classes.
```
interface FormKitClasses {
    (node: FormKitNode, sectionKey: string): string | Record<string, boolean>;
}

```


### FormKitCompilerOutput

**Type:** Interface

The compiler output, a function that adds the required tokens.
```
interface FormKitCompilerOutput {
    (tokens?: Record<string, any>): boolean | number | string;
    provide: FormKitCompilerProvider;
}

```


### FormKitConfig

**Type:** Interface

General "app" like configuration options, these are automatically inherited by all children — they are not reactive.
```
interface FormKitConfig {
    [index: string]: any;
    classes?: Record<string, FormKitClasses | string | Record<string, boolean>>;
    delimiter: string;
    rootClasses: ((sectionKey: string, node: FormKitNode) => Record<string, boolean>) | false;
    rootConfig?: FormKitRootConfig;
}

```


### FormKitContext

**Type:** Interface

The interface of a FormKit node's context object. A FormKit node is a proxy of this object.
```
interface FormKitContext {
    _d: number;
    _e: FormKitEventEmitter;
    _resolve: ((value: unknown) => void) | false;
    _tmo: number | false;
    _value: unknown;
    children: Array<FormKitNode | FormKitPlaceholderNode>;
    config: FormKitConfig;
    context?: FormKitFrameworkContext;
    hook: FormKitHooks;
    isCreated: boolean;
    isSettled: boolean;
    ledger: FormKitLedger;
    name: string | symbol;
    parent: FormKitNode | null;
    plugins: Set<FormKitPlugin>;
    props: Partial<FormKitProps>;
    settled: Promise<unknown>;
    store: FormKitStore;
    sync: boolean;
    traps: FormKitTraps;
    type: FormKitNodeType;
    uid: symbol;
    value: unknown;
}

```


### FormKitContextShape

**Type:** Interface

Define the most basic shape of a context object for type guards trying to reason about a context's value.
```
interface FormKitContextShape {
    _value: unknown;
    type: FormKitNodeType;
    value: unknown;
}

```


### FormKitCounter

**Type:** Interface

The counter object used to perform instance counting within a tree.
```
interface FormKitCounter {
    condition: FormKitCounterCondition;
    count: number;
    name: string;
    node: FormKitNode;
    promise: Promise<void>;
    resolve: () => void;
}

```


### FormKitCounterCondition

**Type:** Interface

Ledger counters require a condition function that determines if a given message applies to it or not.
```
interface FormKitCounterCondition {
    (message: FormKitMessage): boolean;
}

```


### FormKitDispatcher

**Type:** Interface

The FormKitDispatcher interface is responsible creating/running "hooks".
```
interface FormKitDispatcher<T> {
    (dispatchable: FormKitMiddleware<T>): number;
    dispatch: (payload: T) => T;
    remove: (dispatchable: FormKitMiddleware<T>) => void;
    unshift: (dispatchable: FormKitMiddleware<T>) => number;
}

```


### FormKitEvent

**Type:** Interface

The internal structure of a FormKitEvent.
```
interface FormKitEvent {
    bubble: boolean;
    meta?: Record<string, unknown>;
    name: string;
    origin: FormKitNode;
    payload: any;
}

```


### FormKitEventEmitter

**Type:** Interface

The FormKitEventEmitter definition.
```
interface FormKitEventEmitter {
    (node: FormKitNode, event: FormKitEvent): void;
    flush: () => void;
    off: (receipt: string) => void;
    on: (eventName: string, listener: FormKitEventListener) => string;
    pause: (node?: FormKitNode) => void;
    play: (node?: FormKitNode) => void;
}

```


### FormKitEventListener

**Type:** Interface

Event listener functions definition.
```
interface FormKitEventListener {
    (event: FormKitEvent): void;
    receipt?: string;
}

```


### FormKitExtendableSchemaRoot

**Type:** Interface

Defines a function that allows selectively overriding a given schema.
```
interface FormKitExtendableSchemaRoot {
    (extensions: Record<string, Partial<FormKitSchemaNode> | FormKitSchemaCondition>): FormKitSchemaDefinition;
    memoKey?: string;
}

```


### FormKitFrameworkContext

**Type:** Interface

Context object to be created by and used by each respective UI framework. No values are created or output by FormKitCore, but this interface should be followed by each respective plugin.
```
interface FormKitFrameworkContext<T = any> {
    __root?: Document | ShadowRoot;
    _value: T;
    [index: string]: unknown;
    attrs: Record<string, any>;
    classes: Record<string, string>;
    defaultMessagePlacement: boolean;
    fns: Record<string, (...args: any[]) => any>;
    handlers:{
        blur: (e?: FocusEvent) => void;
        touch: () => void;
        DOMInput: (e: Event) => void;
    }&Record<string, (...args: any[]) => void>;
    help?: string;
    id: string;
    items: symbol[];
    label?: string;
    messages: Record<string, FormKitMessage>;
    node: FormKitNode;
    options?: Array<Record<string, any>&{
        label: string;
        value: any;
    }>;
    slots: Record<string, CallableFunction>;
    state: FormKitFrameworkContextState;
    type: string;
    ui: Record<string, FormKitMessage>;
    value: T;
}

```


### FormKitFrameworkContextState

**Type:** Interface

The state inside a node's framework context. Usually used to track things like blurred and validity states.
```
interface FormKitFrameworkContextState {
    [index: string]: boolean;
    blurred: boolean;
    complete: boolean;
    dirty: boolean;
    errors: boolean;
    rules: boolean;
    settled: boolean;
    submitted: boolean;
    valid: boolean;
    validationVisible: boolean;
}

```


### FormKitGroupValue

**Type:** Interface

FormKit inputs of type 'group' must have keyed values by default.
```
interface FormKitGroupValue {
    __init?: boolean;
    [index: string]: unknown;
}

```


### FormKitHandlerPayload

**Type:** Interface

Describes the data passing through the error and warning handlers.
```
interface FormKitHandlerPayload {
    code: number;
    data: any;
    message?: string;
}

```


### FormKitHooks

**Type:** Interface

The available hooks for middleware.
```
interface FormKitHooks {
    classes: FormKitDispatcher<{
        property: string;
        classes: Record<string, boolean>;
    }>;
    commit: FormKitDispatcher<any>;
    error: FormKitDispatcher<string>;
    init: FormKitDispatcher<FormKitNode>;
    input: FormKitDispatcher<any>;
    message: FormKitDispatcher<FormKitMessage>;
    prop: FormKitDispatcher<{
        prop: string | symbol;
        value: any;
    }>;
    schema: FormKitDispatcher<FormKitSchemaNode[] | FormKitSchemaCondition>;
    setErrors: FormKitDispatcher<{
        localErrors: ErrorMessages;
        childErrors?: ErrorMessages;
    }>;
    submit: FormKitDispatcher<Record<string, any>>;
    text: FormKitDispatcher<FormKitTextFragment>;
}

```


### FormKitInputMessages

**Type:** Interface

A registry of input messages that should be applied to children of the node they are passed to — where the string key of the object is the address of the node to apply the messages on and the value is the message itself.
```
interface FormKitInputMessages {
    [address: string]: FormKitMessage[];
}

```


### FormKitLedger

**Type:** Interface

The FormKit ledger, a general-purpose message counting service provided by FormKit core for counting messages throughout a tree.
```
interface FormKitLedger {
    count: (name: string, condition?: FormKitCounterCondition, increment?: number) => Promise<void>;
    init: (node: FormKitNode) => void;
    merge: (child: FormKitNode) => void;
    settled: (name: string) => Promise<void>;
    unmerge: (child: FormKitNode) => void;
    value: (name: string) => number;
}

```


### FormKitLibrary

**Type:** Interface

A library of inputs, keyed by the name of the type.
```
interface FormKitLibrary {
    [index: string]: FormKitTypeDefinition;
}

```


### FormKitListContext

**Type:** Interface

The simplest definition for a context of type "list".
```
interface FormKitListContext {
    _value: FormKitListContextValue;
    type:'list';
    value: FormKitListContextValue;
}

```


### FormKitMessageMeta

**Type:** Interface

Messages have can have any arbitrary meta data attached to them.
```
interface FormKitMessageMeta {
    [index: string]: any;
    i18nArgs?: any[];
    messageKey?: string;
}

```


### FormKitMessageProps

**Type:** Interface

The structure of a core FormKitMessage. These messages are used to store information about the state of a node.
```
interface FormKitMessageProps {
    blocking: boolean;
    key: string;
    meta: FormKitMessageMeta;
    type: string;
    value?: string | number | boolean;
    visible: boolean;
}

```


### FormKitMessageStore

**Type:** Interface

Defines the actual store of messages.
```
interface FormKitMessageStore {
    [index: string]: FormKitMessage;
}

```


### FormKitNodeExtensions

**Type:** Interface

An empty interface for adding FormKit node extensions.
```
interface FormKitNodeExtensions {
}

```


### FormKitPlaceholderNode

**Type:** Interface

A faux node that is used as a placeholder in the children node array during various node manipulations.
```
interface FormKitPlaceholderNode<V = unknown> {
    __FKP: true;
    _value: V;
    input: (value: unknown, async?: boolean) => Promise<unknown>;
    isSettled: boolean;
    name: string;
    type: FormKitNodeType;
    uid: symbol;
    use: (...args: any[]) => void;
    value: V;
}

```


### FormKitPlugin

**Type:** Interface

The base interface definition for a FormKitPlugin. It's just a function that accepts a node argument.
```
interface FormKitPlugin {
    (node: FormKitNode): false | any | void;
    library?: (node: FormKitNode) => void;
}

```


### FormKitSchemaAttributesCondition

**Type:** Interface

Conditions nested inside attribute declarations.
```
interface FormKitSchemaAttributesCondition {
    else?: FormKitAttributeValue;
    if: string;
    then: FormKitAttributeValue;
}

```


### FormKitSchemaComposable

**Type:** Interface

Definition for a function that can extend a given schema node.
```
interface FormKitSchemaComposable {
    (extendWith?: Partial<FormKitSchemaNode>, children?: string | FormKitSchemaNode[] | FormKitSchemaCondition, ...args: any[]): FormKitSchemaNode;
}

```


### FormKitSchemaContext

**Type:** Interface

The context that is passed from one schema render to the next.
```
interface FormKitSchemaContext {
    __FK_SCP: Map<symbol, Record<string, any>>;
    [index: string]: any;
}

```


### FormKitSchemaProps

**Type:** Interface

Properties available in all schema nodes.
```
interface FormKitSchemaProps {
    bind?: string;
    children?: string | FormKitSchemaNode[] | FormKitSchemaCondition;
    for?: FormKitListStatement;
    if?: string;
    key?: string;
    meta?: FormKitSchemaMeta;
}

```


### FormKitStoreTraps

**Type:** Interface

The available traps on the FormKit store.
```
interface FormKitStoreTraps {
    apply: (messages: Array<FormKitMessage> | FormKitInputMessages, clear?: MessageClearer) => void;
    filter: (callback: (message: FormKitMessage) => boolean, type?: string) => FormKitStore;
    reduce:<T>(reducer: (accumulator: T, message: FormKitMessage) => T, accumulator: T) => T;
    release: () => void;
    remove: (key: string) => FormKitStore;
    set: (message: FormKitMessageProps) => FormKitStore;
    touch: () => void;
}

```


### FormKitTrap

**Type:** Interface

The definition of a FormKitTrap. These are somewhat like methods on each FormKitNode. They are always symmetrical (get/set) — although it's acceptable for either to throw an Exception.
```
interface FormKitTrap {
    get: TrapGetter;
    set: TrapSetter;
}

```


### KeyedValue

**Type:** Interface

Arbitrary data that has properties. Could be a POJO, could be an array.
```
interface KeyedValue {
    [index: number]: any;
    [index: string]: any;
}

```


### ChildMessageBuffer

**Type:** Type

Child messages that were not immediately applied due to the child not existing.
```
export type ChildMessageBuffer = Map<string, Array<[FormKitMessage[], MessageClearer | undefined]>>;

```


### ErrorMessages

**Type:** Type

Error messages.
```
export type ErrorMessages = string | string[] | Record<string, string | string[]>;

```


### FormKitAddress

**Type:** Type

Describes the path to a particular node from the top of the tree.
```
export type FormKitAddress = Array<string | number>;

```


### FormKitAttributeValue

**Type:** Type

The possible value types of attributes (in the schema).
```
export type FormKitAttributeValue = string | number | boolean | undefined | FormKitSchemaAttributes | FormKitSchemaAttributesCondition;

```


### FormKitCompilerProvider

**Type:** Type

A function that accepts a callback with a token as the only argument, and must return a function that provides the true value of the token.
```
export type FormKitCompilerProvider = (callback: (requirements: string[]) => Record<string, () => any>) => FormKitCompilerOutput;

```


### FormKitListContextValue

**Type:** Type

FormKit inputs of type 'list' must have array values by default.
```
export type FormKitListContextValue<T = any> = Array<T>;

```


### FormKitListStatement

**Type:** Type

A full loop statement in tuple syntax. Can be read like "foreach value, key? in list".
```
export type FormKitListStatement = [value: any, key: number | string, list: FormKitListValue] | [value: any, list: FormKitListValue];

```


### FormKitListValue

**Type:** Type

The value being listed out. Can be an array, an object, or a number.
```
export type FormKitListValue = string | Record<string, any> | Array<string | number | Record<string, any>> | number;

```


### FormKitMessage

**Type:** Type

A FormKit message is immutable, so all properties should be readonly.
```
export type FormKitMessage = Readonly<FormKitMessageProps>;

```


### FormKitMiddleware

**Type:** Type

All FormKitMiddleware conform to the pattern of accepting a payload and a `next()` function. They can either pass the payload to the next middleware explicitly (as an argument of next), or implicitly (no argument for next).
```
export type FormKitMiddleware<T = unknown> = (payload: T, next: (payload: T) => T) => T;

```


### FormKitNodeType

**Type:** Type

These are the types of nodes that can be created. These are different from the type of inputs available and rather describe their purpose in the tree.
```
export type FormKitNodeType = 'input' | 'list' | 'group';

```


### FormKitOptions

**Type:** Type

Options that can be used to instantiate a new node via `createNode()`.
```
export type FormKitOptions = Partial<Omit<FormKitContext, 'children' | 'plugins' | 'config' | 'hook'> & {
    config: Partial<FormKitConfig>;
    props: Partial<FormKitProps>;
    children: FormKitNode[] | Set<FormKitNode>;
    index?: number;
    sync: boolean;
    plugins: FormKitPlugin[];
    alias: string;
    schemaAlias: string;
}>;

```


### FormKitProps

**Type:** Type

The user-land per-instance "props", which are generally akin to the props passed into components on the front end.
```
export type FormKitProps = {
    __root?: Document | ShadowRoot;
    delay: number;
    id: string;
    validationLabelStrategy?: (node?: FormKitNode) => string;
    validationRules?: Record<string, (node: FormKitNode) => boolean | Promise<boolean>>;
    validationMessages?: Record<string, ((ctx: {
        name: string;
        args: any[];
        node: FormKitNode;
    }) => string) | string>;
    definition?: FormKitTypeDefinition;
    context?: FormKitFrameworkContext;
    [index: string]: any;
} & FormKitConfig;

```


### FormKitRootConfig

**Type:** Type

Global configuration options.
```
export type FormKitRootConfig = Partial<FormKitConfig> & {
    _add: (node: FormKitNode) => void;
    _rm: (node: FormKitNode) => void;
};

```


### FormKitSchemaAttributes

**Type:** Type

DOM attributes are simple string dictionaries.
```
export type FormKitSchemaAttributes = {
    [index: string]: FormKitAttributeValue;
} | null | FormKitSchemaAttributesCondition;

```


### FormKitSchemaComponent

**Type:** Type

Properties available when defining a generic non-FormKit component.
```
export type FormKitSchemaComponent = {
    $cmp: string;
    props?: Record<string, any>;
} & FormKitSchemaProps;

```


### FormKitSchemaCondition

**Type:** Type

A schema node that determines *which* content to render.
```
export type FormKitSchemaCondition = {
    if: string;
    then: FormKitSchemaNode | FormKitSchemaNode[];
    else?: FormKitSchemaNode | FormKitSchemaNode[];
};

```


### FormKitSchemaDefinition

**Type:** Type

An entire schema object or subtree from any entry point. Can be a single node, an array of nodes, or a conditional. This is the type that is passed to the FormKitSchema constructor.
```
export type FormKitSchemaDefinition = FormKitSchemaNode | FormKitSchemaNode[] | FormKitSchemaCondition;

```


### FormKitSchemaDOMNode

**Type:** Type

Properties available when using a DOM node.
```
export type FormKitSchemaDOMNode = {
    $el: string | null;
    attrs?: FormKitSchemaAttributes;
} & FormKitSchemaProps;

```


### FormKitSchemaFormKit

**Type:** Type

Syntactic sugar for a FormKitSchemaComponent node that uses FormKit.
```
export type FormKitSchemaFormKit = {
    $formkit: string;
} & Record<string, any> & FormKitSchemaProps;

```


### FormKitSchemaMeta

**Type:** Type

Meta attributes are not used when parsing the schema, but can be used to create tooling.
```
export type FormKitSchemaMeta = {
    [key: string]: string | number | boolean | undefined | null | CallableFunction | FormKitSchemaMeta;
};

```


### FormKitSchemaNode

**Type:** Type

Properties available then defining a schema node.
```
export type FormKitSchemaNode = FormKitSchemaDOMNode | FormKitSchemaComponent | FormKitSchemaTextNode | FormKitSchemaCondition | FormKitSchemaFormKit;

```


### FormKitSchemaTextNode

**Type:** Type

A simple text node.
```
export type FormKitSchemaTextNode = string;

```


### FormKitSearchFunction

**Type:** Type

Breadth and depth-first searches can use a callback of this notation.
```
export type FormKitSearchFunction = (node: FormKitNode, searchTerm?: string | number) => boolean;

```


### FormKitStore

**Type:** Type

The message store contains all of the messages that pertain to a given node.
```
export type FormKitStore = FormKitMessageStore & {
    _n: FormKitNode;
    _b: Array<[messages: FormKitMessage[], clear?: MessageClearer]>;
    _m: ChildMessageBuffer;
    _r?: string;
    buffer: boolean;
} & FormKitStoreTraps;

```


### FormKitTextFragment

**Type:** Type

Text fragments are small pieces of text used for things like interface validation messages, or errors that may be exposed for modification or even translation.
```
export type FormKitTextFragment = Partial<FormKitMessageProps> & {
    key: string;
    value: string;
    type: string;
};

```


### FormKitTraps

**Type:** Type

The map signature for a node's traps Map.
```
export type FormKitTraps = Map<string | symbol, FormKitTrap>;

```


### FormKitTypeDefinition

**Type:** Type

Definition of a library item — when registering a new library item, these are the required and available properties.
```
export type FormKitTypeDefinition = {
    type: FormKitNodeType;
    family?: string;
    forceTypeProp?: string;
    props?: string[];
    schema?: FormKitExtendableSchemaRoot | FormKitSchemaNode[] | FormKitSchemaCondition;
    component?: unknown;
    library?: Record<string, unknown>;
    features?: Array<(node: FormKitNode) => void>;
    schemaMemoKey?: string;
};

```


### MessageClearer

**Type:** Type

A string or function that allows clearing messages.
```
export type MessageClearer = string | ((message: FormKitMessage) => boolean);

```


### TrapGetter

**Type:** Type

Signature for any of the node's getter traps. Keep in mind that because these are traps and not class methods, their response types are declared explicitly in the FormKitNode interface.
```
export type TrapGetter = ((node: FormKitNode, context: FormKitContext, ...args: any[]) => unknown) | false;

```


### TrapSetter

**Type:** Type

The signature for a node's trap setter — these are more rare than getter traps, but can be useful for blocking access to certain context properties or modifying the behavior of an assignment (ex. see setParent).
```
export type TrapSetter = ((node: FormKitNode, context: FormKitContext, property: string | number | symbol, value: any) => boolean | never) | false;

```

