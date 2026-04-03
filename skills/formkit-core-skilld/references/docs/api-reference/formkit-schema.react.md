# formkit/schema

# @formkit/schema

## Functions

### compile()

**Type:** Function

Compiles a logical string like "a != z || b == c" into a single function. The return value is an object with a "provide" method that iterates over all requirement tokens to use as replacements.
```
let name = {
  value: 'jon'
}
const condition = compile("$name == 'bob'").provide((token) => {
 return () => name.value // must return a function!
})

condition() // false

```
#### Signature
```
compile(expr: string): FormKitConditionCompiler;

```
#### Parameters
- `expr` — A string to compile


### isComponent()

**Type:** Function

Type narrow that a node is a DOM node.
#### Signature
```
isComponent(node: string | Record<PropertyKey, any>): node is FormKitSchemaComponent;

```
#### Parameters
- `node` — A schema node to check


### isConditional()

**Type:** Function

Determines if a node is conditionally rendered or not.
#### Signature
```
isConditional(node: FormKitSchemaNode): node is FormKitSchemaCondition;
isConditional(node: FormKitSchemaAttributesCondition | FormKitSchemaAttributes): node is FormKitSchemaAttributesCondition;

```
#### Parameters
- `node` — A schema node to check


### isDOM()

**Type:** Function

Type narrow that a node is a DOM node.
#### Signature
```
isDOM(node: string | Record<PropertyKey, any>): node is FormKitSchemaDOMNode;

```
#### Parameters
- `node` — A schema node to check


### isNode()

**Type:** Function

Determines if t a node is a $formkit schema node.
#### Signature
```
isNode(node: string | Record<PropertyKey, any>): node is FormKitSchemaFormKitNode;

```
#### Parameters
- `node` — A schema node to check


## TypeScript

### FormKitExtendableSchemaRoot

**Type:** Interface

Defines a function that allows selectively overriding a given schema.
```
interface FormKitExtendableSchemaRoot {
    (extensions: Record<string, Partial<FormKitSchemaNode> | FormKitSchemaCondition>): FormKitSchemaNode[];
}

```


### FormKitSchemaAttributesCondition

**Type:** Interface

Conditions nested inside attribute declarations
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
    (extendWith?: Partial<FormKitSchemaNode>, children?: string | FormKitSchemaNode[] | FormKitSchemaCondition): FormKitSchemaNode;
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


### FormKitAttributeValue

**Type:** Type

The possible value types of attributes (in the schema)
```
type FormKitAttributeValue = string | number | boolean | undefined | FormKitSchemaAttributes | FormKitSchemaAttributesCondition;

```


### FormKitListStatement

**Type:** Type

A full loop statement in tuple syntax. Can be read like "foreach value, key? in list"
```
type FormKitListStatement = [value: any, key: number | string, list: FormKitListValue] | [value: any, list: FormKitListValue];

```


### FormKitListValue

**Type:** Type

The value being listed out. Can be an array, an object, or a number.
```
type FormKitListValue = string | Record<string, any> | Array<string | number | Record<string, any>> | number;

```


### FormKitSchemaAttributes

**Type:** Type

DOM attributes are simple string dictionaries.
```
type FormKitSchemaAttributes = {
    [index: string]: FormKitAttributeValue;
} | null | FormKitSchemaAttributesCondition;

```


### FormKitSchemaComponent

**Type:** Type

Properties available when defining a generic non-formkit component.
```
type FormKitSchemaComponent = {
    $cmp: string;
    props?: {
        [index: string]: any;
    };
} & FormKitSchemaProps;

```


### FormKitSchemaCondition

**Type:** Type

A schema node that determines *which* content to render.
```
type FormKitSchemaCondition = {
    if: string;
    then: FormKitSchemaNode | FormKitSchemaNode[];
    else?: FormKitSchemaNode | FormKitSchemaNode[];
};

```


### FormKitSchemaDOMNode

**Type:** Type

Properties available when using a DOM node.
```
type FormKitSchemaDOMNode = {
    $el: string | null;
    attrs?: FormKitSchemaAttributes;
} & FormKitSchemaProps;

```


### FormKitSchemaFormKitNode

**Type:** Type

Properties available when using a formkit input.
```
type FormKitSchemaFormKitNode = {
    $node: string;
    name?: string;
    props: Partial<FormKitProps>;
    type: 'input' | 'list' | 'group';
    value?: any;
} & FormKitSchemaProps;

```


### FormKitSchemaNode

**Type:** Type

Properties available then defining a schema node.
```
type FormKitSchemaNode = FormKitSchemaFormKitNode | FormKitSchemaDOMNode | FormKitSchemaComponent | FormKitSchemaTextNode | FormKitSchemaCondition;

```


### FormKitSchemaTextNode

**Type:** Type

A simple text node.
```
type FormKitSchemaTextNode = string;

```

