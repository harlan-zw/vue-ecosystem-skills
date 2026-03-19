# Validation

Provide instant feedback to users on the validity of their form data.

FormKit makes front end validation simple by letting you declare your validation rules directly on your inputs. It's easy to write custom rules too, but you'll rarely need to with 30+ production-ready rules.

## Declaring rules

Declaring which validation rules apply to a given input is as simple as providing a `validation` prop. Rules can be declared using two syntaxes:

- [String syntax](#string-syntax)
- [Array syntax](#array-syntax)

### String syntax

Validation rules can be declared by specifying each desired rule name separated by pipes `|`. Some rules may also accept arguments, which can be supplied after a colon `:`. You can use multiple arguments by comma separating them:

### Example: Validation strings

#### validation-strings.vue

```vue
<FormKit
    type="text"
    label="Number"
    validation="required|number|between:20,50"
    validation-visibility="live"
    help="Enter a number between 20 and 50."
  />
```

### Array syntax

Validation rules can also be declared by providing an array. Each element of the array must be itself an array where the first element is the string name of the validation rule, and the remaining `n` elements are arguments for that rule.

This is especially helpful if the arguments being provided need to be actual JavaScript types — for example, a regular expression (regex):

### Example: Validation arrays

#### validation-arrays.vue

```vue
<FormKit
    type="text"
    label="Phone"
    placeholder="xxx-xxx-xxxx"
    :validation="[['required'], ['matches', /^\d{3}-\d{3}-\d{4}$/]]"
    validation-visibility="live"
    :validation-messages="{
      matches: 'Phone number must be formatted: xxx-xxx-xxxx',
    }"
  />
```

## Showing errors

Validation rules are always computed in realtime — meaning a given field will always be either valid or invalid (it is considered invalid while pending async validation rules run). However — the *visibility* of the validation errors is determined by the `validation-visibility` prop.

| Visibility | Description |
| --- | --- |
| blur | (Default) Errors are shown after a user removes focus from an input. |
| live | Errors are always visible. |
| dirty | Errors are shown after a user modifies the value of an input. |
| submit | Errors are shown only after a user attempts to submit a form. |

> **Info:** If an input is inside a form, then any remaining validation messages will be displayed to the end user when a user attempts to submit the form.

### Setting validation visibility for an entire group

Due to FormKit's config inheritance, you can set `validation-visibility` at a `form`, `group`, or `list` level by using the `config` prop, which you can still override on an input-by-input basis:

### Example: Validation Visibility

#### validation-visibility.vue

```vue
<!-- config is passed down to descendant inputs: -->
  <FormKit
    type="form"
    @submit="() => false"
    :config="{ validationVisibility: 'submit' }"
  >
    <FormKit
      type="text"
      label="Name"
      validation="required|length:3"
      help="Enter your full name."
    />
    <FormKit
      type="date"
      label="Birthday"
      validation="required|date_between:1990-01-01 00:00:00,1999-12-31 23:59:59"
      :validation-messages="{ date_between: 'Only for those born in the 90s.' }"
      help="Enter your date of birth"
    />
    <!-- We override validation-visibility for the input below: -->
    <FormKit
      type="tel"
      label="Phone Number"
      placeholder="xxx-xxx-xxxx"
      validation="required|matches:/^[0-9]{3}-[0-9]{3}-[0-9]{4}$/"
      validation-visibility="live"
      help="What are your digits?"
    />
  </FormKit>
```

## Rule hints

Validation rules operate according to a few default features, which you can change on a case-by-case basis with "rule hints":

- **Run in sequence** - rules are run in the order they are declared. When a rule fails, any remaining rules are not run. For example, if you declare the validation rules as `required|length:5` then the `length` rule will not run until the `required` rule is passing.
- **Skipped when empty** - Validation rules are not run when the input is empty (within the [available rules](#available-rules), the `required` rule is the only exception).
- **Synchronous** - all [available rules](#available-rules) are synchronous and not debounced.
- **Blocking** - all validation rules produce [blocking messages](/essentials/architecture#message-store) which prevent form submission.

The above features can be modified when declaring your rules by using "hinting". Rule hints are small modifier characters you append to the beginning of a rule declaration to change its default behavior:

| Hint | Name | Description |
| --- | --- | --- |
| (200) | Debounce | Debounces the validation rule by the given number of milliseconds. |
| + | Empty | Runs the validation rule even if the input is empty (but not force the rule). |
| * | Force | Runs the validation rule even if a previous rule was failing. |
| ? | Optional | Makes a validation rule optional (it is non-blocking meaning the form can still submit). |

### Debounce (milli)

At times it makes sense to debounce your validation rules. To do this use the debounce hint — a parenthesis containing a duration in milliseconds — before your rule:

### Example: Debounce hint

#### debounce-hint.vue

```vue
<script setup>
// Let's pretend this is an expensive API call.
const username_exists = function ({ value }) {
  return new Promise((resolve) => {
    setTimeout(() => resolve(value === 'formkit-4-life'), 200)
  })
}
</script>

<template>
  <FormKit
    label="Username"
    validation="(500)username_exists"
    validation-visibility="live"
    :validation-rules="{ username_exists }"
    :validation-messages="{
      username_exists: 'Sorry, that username is taken. Try “formkit-4-life”.',
    }"
  />
</template>
```

### Empty +

Sometimes you want a validation rule to run even when an input is empty. You can use the empty `+` hint to do so:

### Example: Empty hint

#### empty-hint.vue

```vue
<template>
  <FormKit
    type="checkbox"
    label="Relocation Preferences"
    :options="[
      'Argentina',
      'Belarus',
      'Hungary',
      'Iceland',
      'Morocco',
      'Peru',
      'Spain',
      'Yemen',
    ]"
    help="If you had to relocate for work — select your preferred locations."
    validation="+min:3"
    validation-visibility="live"
  />
</template>
```

### Force *

The force hint ensures a validation rule will run even if a rule that is defined before it is failing (note: this does not mean it will run when an input is empty). Notice how this example will display *both* the `length` and `email` messages:

### Example: Force hint

#### force-hint.vue

```vue
<FormKit
    type="email"
    label="Email address"
    validation="length:5|*email"
    validation-visibility="live"
    help="Enter less than 5 characters to see both rules appear."
  />
  <!-- By default, the "email" validation rule would
        not run if the "length" rule was failing. -->
```

### Optional ?

The optional hint allows a failing validation rule to not prevent form submission. In this example, notice how the form will not submit if the `required` or `confirm` rules are failing, but it will submit if the optional-hinted `length` rule is failing:

### Example: Optional hint

#### optional-hint.vue

```vue
<FormKit type="form" @submit="submit">
    <h2>Change password</h2>
    <FormKit
      type="password"
      name="password"
      label="Password"
      validation="required|?length:10"
      :validation-messages="{
        length: 'Try to make your password longer!',
      }"
    />
    <FormKit
      type="password"
      label="Confirm password"
      name="password_confirm"
      validation="required|confirm"
    />
  </FormKit>
```

> **Tip:** You can use rule hints together. To do so, just place multiple hints before the rule declaration: required|*+(200)min:10.

## Available rules

FormKit ships with over 30 production-ready validation rules, covering most validation needs. If you don’t find one that meets your exact requirement, you can add a [custom rule](#custom-rules) to suit your needs.

- [accepted](#accepted)
- [alpha](#alpha)
- [alphanumeric](#alphanumeric)
- [alpha_spaces](#alpha-spaces)
- [between](#between)
- [confirm](#confirm)
- [contains_alpha](#contains-alpha)
- [contains_alphanumeric](#contains-alphanumeric)
- [contains_alpha_spaces](#contains-alpha-spaces)
- [contains_lowercase](#contains-lowercase)
- [contains_numeric](#contains-numeric)
- [contains_symbol](#contains-symbol)
- [contains_uppercase](#contains-uppercase)
- [date_after](#date-after)
- [date_before](#date-before)
- [date_between](#date-between)
- [date_format](#date-format)
- [email](#email)
- [ends_with](#ends-with)
- [is](#is)
- [length](#length)
- [lowercase](#lowercase)
- [matches](#matches)
- [max](#max)
- [min](#min)
- [not](#not)
- [number](#number)
- [required](#required)
- [require_one](#require-one)
- [starts_with](#starts-with)
- [symbol](#symbol)
- [uppercase](#uppercase)
- [url](#url)

### Accepted

The value must be `yes`, `on`, `1` or `true`. Useful for checkbox inputs — often where you need to validate if someone has accepted terms.

### Example: Accepted

#### rule-accepted.vue

```vue
<FormKit
    type="checkbox"
    label="Terms of service"
    validation="accepted"
    validation-visibility="live"
  />
```

### Alpha

Checks if a value is only alphabetical characters. There are two character sets: latin and default. Latin characters are strictly `[a-zA-Z]`, while the default set includes most accented characters, such as `ä`, `ù`, or `ś`.

### Example: Alpha

#### rule-alpha.vue

```vue
<FormKit
    type="text"
    label="Social handle"
    value="foo123"
    validation="alpha:latin"
    validation-visibility="live"
  />
```

### Alphanumeric

Checks if a value is only made of alphabetical characters or numeric digits. For the alphabetical portion you can pass `default` or `latin` - see [alpha](#alpha)) above.

### Example: Alphanumeric

#### rule-alphanumeric.vue

```vue
<FormKit
    type="text"
    label="Enter your desired username"
    value="Robby Gingerhead"
    validation="alphanumeric"
    validation-label="username"
    validation-visibility="live"
  />
```

### Alpha-spaces

Checks if a value is only made of alphabetical characters or spaces. For the alphabetical portion you can pass `default` or `latin` - see [alpha](#alpha)) above.

### Example: Alphanumeric

#### rule-alpha-spaces.vue

```vue
<FormKit
    type="text"
    label="Full Name"
    value="Elly Punsayer123"
    validation="alpha_spaces:latin"
    validation-visibility="live"
  />
```

### Between

Checks if a number is (inclusively) between two other numbers. The input value must be a number, or the validation rule will fail.

### Example: Between

#### rule-between.vue

```vue
<FormKit
    type="number"
    label="Age"
    value="16"
    validation="between:18,25"
    validation-visibility="live"
  />
```

### Confirm

Checks if the value of one input matches the value of another input — often used for password confirmations. There are two ways to specify which input to match:

- Append `_confirm` to the `name` attribute of the second input.
- Pass the `name` of the first input as an argument to the confirm rule in the second input `confirm:name_of_input_1` (more specific).

Note: the two inputs must be in the same `group` or `form`.

### Example: Confirm

#### rule-confirm.vue

```vue
<FormKit type="group">
    <FormKit
      type="password"
      name="password"
      label="Password"
      validation="required"
      validation-visibility="live"
    />
    <FormKit
      type="password"
      name="password_confirm"
      label="Confirm password"
      validation="required|confirm"
      validation-visibility="live"
      validation-label="Confirmation"
    />
  </FormKit>
```

### Contains Alpha

Checks if a value contains alphabetical characters. There are two character sets: latin and default. Latin characters are strictly `[a-zA-Z]`, while the default set includes most accented characters, such as `ä`, `ù`, or `ś`.

### Example: Contains Alpha

#### rule-contains-alpha.vue

```vue
<FormKit
    type="text"
    label="Xbox gamertag"
    value="007"
    validation="contains_alpha"
    validation-visibility="live"
  />
```

### Contains Alphanumeric

Checks if a value contains either alphabetical characters or numeric digits. For the alphabetical portion you can pass `default` or `latin` - see [contains alpha](#contains-alpha)) above.

### Example: Contains Alphanumeric

#### rule-contains-alphanumeric.vue

```vue
<FormKit
    type="text"
    label="Enter your desired username"
    value="$!@#"
    validation="contains_alphanumeric"
    validation-label="username"
    validation-visibility="live"
  />
```

### Contains Alpha-spaces

Checks if a value contains alphabetical characters or spaces. For the alphabetical portion you can pass `default` or `latin` - see [contains alpha](#contains-alpha)) above.

### Example: Alphanumeric

#### rule-contains-alpha-spaces.vue

```vue
<FormKit
    type="text"
    label="Full name"
    value="010101!"
    validation="contains_alpha_spaces"
    validation-visibility="live"
  />
```

### Contains Lowercase

Checks if a value contains a lowercase character. There are two character sets: latin and default. Latin characters are strictly `[a-zA-Z]`, while the default set includes most accented characters, such as `ä`, `ù`, or `ś`.

### Example: Lowercase

#### rule-contains-lowercase.vue

```vue
<FormKit
    type="text"
    label="Echo statement"
    value="HELLO WORLD!"
    validation="contains_lowercase"
    validation-visibility="live"
  />
```

### Contains Numeric

Checks if a value contains a number.

### Example: Contains Numeric

#### rule-contains-numeric.vue

```vue
<FormKit
    type="text"
    label="Enter your desired gamertag"
    value="Smackdown"
    validation="contains_numeric"
    validation-visibility="live"
    validation-label="gamertag"
  />
```

### Contains Symbol

Checks if a value contains a symbol.

### Example: Contains Numeric

#### rule-contains-symbol.vue

```vue
<FormKit
    type="text"
    label="Enter your desired username"
    value="Loves 2 Game"
    validation="contains_symbol"
    validation-visibility="live"
    validation-label="username"
  />
```

### Contains Uppercase

Checks if a value contains a uppercase character. There are two character sets: latin and default. Latin characters are strictly `[a-zA-Z]`, while the default set includes most accented characters, such as `ä`, `ù`, or `ś`.

### Example: Contains Uppercase

#### rule-contains-uppercase.vue

```vue
<FormKit
    type="text"
    label="Enter your desired gamertag"
    value="bistro3000"
    validation="contains_uppercase"
    validation-visibility="live"
    validation-label="gamertag"
  />
```

### Date after

Determines if a date is after the current date or a date supplied as the rule's argument. Dates used can either be JavaScript `Date` objects or strings that can be parsed by Date.parse().

### Example: Date after

#### rule-date-after.vue

```vue
<FormKit
    type="date"
    label="Birthday"
    help="Enter your birthday (must be born after 1999)"
    validation="date_after:1999-12-31"
    validation-visibility="live"
    :validation-messages="{
      date_after: 'Sorry — no olds allowed.',
    }"
    value="1988-05-14"
  />
```

### Date before

Determines if a date is before the current date or a date supplied as the rule's argument. Dates used can either be JavaScript `Date` objects or strings that can be parsed by Date.parse().

### Example: Date before

#### rule-date-before.vue

```vue
<FormKit
    type="date"
    label="Birthday"
    help="Enter your birthday (must be born before 2011)"
    validation="date_before:2011-01-01"
    validation-visibility="live"
    value="2020-01-01"
  />
```

### Date between

Determines if a date is between (and including) the two dates supplied as the rule's arguments. Dates used can either be JavaScript `Date` objects or strings that can be parsed by Date.parse().

### Example: Date between

#### rule-date-between.vue

```vue
<FormKit
    type="date"
    label="Departure date"
    help="Select a date next summer"
    :validation="[['date_between', summerStart, summerEnd]]"
    validation-visibility="live"
    :value="invalidDate"
  />
```

### Date format

Ensures the format of an input’s date matches a specific date format. The format should be specified using the following formatting tokens:

| Token | Valid values |
| --- | --- |
| MM | Two-digit month representation (01-12) |
| M | Single-digit month representation (1-12) leading zero allowed |
| DD | Two-digit day of the month (01-31) |
| D | Single-digit day of the month (1-31), leading zero allowed |
| YY | Two-digit year |
| YYYY | Four-digit year |

> **Warning:** Native date inputs always output the same format YYYY-MM-DD ... even though they display dates according to the browser’s locale. Using this rule to specify a different format would result in an input that can never be valid.

### Example: Date format

#### rule-date-format.vue

```vue
<FormKit
    type="text"
    label="Birthday"
    help="Enter your birthday in the format: MM/DD/YYYY"
    validation="date_format:MM/DD/YYYY"
    validation-visibility="live"
    value="1988-05-14"
  />
```

### Email

Checks if the input contains a valid email address.

### Example: Email

#### rule-email.vue

```vue
<FormKit
    type="email"
    label="Email address"
    validation="email"
    validation-visibility="live"
    value="andrew@formkit"
  />
```

### Ends with

Checks if the input's value ends with a given substring.

### Example: Ends with

#### rule-ends-with.vue

```vue
<FormKit
    type="email"
    label="Student email"
    validation="email|ends_with:.edu"
    validation-visibility="live"
    value="andrew@formkit.com"
  />
```

### Is

Checks that the input's value matches at least one of the provided arguments.

### Example: Is

#### rule-is.vue

```vue
<FormKit
    type="text"
    label="What's a food you might find in a breakfast buffet?"
    validation="is:eggs,bacon,sausage,coffee"
    validation-visibility="live"
    validation-label="year"
    :validation-messages="{ is: 'Not this buffet — try another.' }"
    value="cake"
  />
```

### Length

Checks that the input’s value is over a given length, or between two length values. It works to validate arrays (like [lists](/inputs/list)), objects (like [groups](/inputs/group)), or string lengths. Can be used to simulate the native `maxlength` and `minlength` as well.

### Example: Is

#### rule-length.vue

```vue
<!-- Between 2 lengths -->
  <FormKit
    type="password"
    label="Password"
    validation="length:5,16"
    help="Please enter a password between 5 and 16 characters long."
    validation-visibility="live"
    value="123"
  />
  <!-- Greater than a minimum -->
  <FormKit
    type="text"
    label="Name"
    validation="length:2"
    help="Name must be at least 2 characters long."
    validation-visibility="live"
    value="1"
  />
  <!-- Less than a maximum -->
  <FormKit
    type="text"
    label="Username"
    validation="length:0,10"
    help="Username cannot be more than 10 characters long."
    validation-visibility="live"
    value="MonopolyMan"
  />
```

### Lowercase

Checks if a value consists of only lowercase characters. There are two character sets: latin and default. Latin characters are strictly `[a-zA-Z]`, while the default set includes most accented characters, such as `ä`, `ù`, or `ś`.

### Example: Lowercase

#### rule-lowercase.vue

```vue
<FormKit
    type="text"
    label="Enter your desired username"
    value="Dinosaur Rider"
    validation="lowercase"
    validation-visibility="live"
    validation-label="username"
  />
```

### Matches

Checks if the input matches a particular value or pattern. If you pass multiple arguments, it checks each until a match is found.

### Example: Is

#### rule-matches.vue

```vue
<FormKit
    type="text"
    label="Language"
    validation="matches:node,php,java,python"
    validation-visibility="live"
    help="Which is your favorite server-side language?"
    value="vue"
  />
```

Instead of passing in strings within the validation prop for simple matching, you can template your argument with slashes `/` to pass in your own regular expression.

### Example: Matches

#### rule-matches-inline-regex.vue

```vue
<FormKit
    type="password"
    label="Password"
    help="Please enter your password."
    validation="matches:/[0-9]/"
    validation-visibility="live"
    :validation-messages="{ matches: 'Passwords must include a number.' }"
    value="password"
  />
```

When using the string [String Syntax](#string-syntax) you cannot escape characters used to define the validation rules themselves `(|,:)`. To use these characters in your regular expressions you must use the alternative [Array Syntax](#array-syntax).

### Example: Matches

#### rule-matches-array-syntax.vue

```vue
<FormKit
    type="text"
    placeholder="#00ff00"
    label="Hexidecimal Color"
    :validation="[['matches', /^#[a-fA-F0-9]{6}$/]]"
    validation-visibility="live"
    value="#00ff0"
  />
```

### Max

Checks that a `Number` is less than or equal to a maximum value. The maximum value defaults to `10`.

### Example: Max

#### rule-max.vue

```vue
<FormKit
    type="number"
    name="Quantity"
    label="Quantity"
    validation="max:5"
    validation-visibility="live"
    value="6"
  />
```

You can also use this rule to validate that the length of an `Array` is less than or equal to a maximum value.

### Example: Max

#### rule-max-array.vue

```vue
<FormKit
    type="checkbox"
    :options="['Pepperoni', 'Sausage', 'Olives', 'Feta', 'Mushrooms']"
    label="Pizza toppings"
    help="Select up to three of your favorite toppings."
    validation="max:3"
    validation-visibility="live"
    :value="['Pepperoni', 'Sausage', 'Olives', 'Feta']"
  />
```

### Min

Checks that a `Number` is greater than or equal to a minimum value. The minimum value defaults to `1`.

### Example: Max

#### rule-min.vue

```vue
<FormKit
    type="number"
    label="Kitchen renovation budget"
    help="Enter the most you'd like to spend on your kitchen renovation."
    validation="min:5000"
    :validation-messages="{
      min: 'Sorry — we only build high-end kitchens. Try Budget Builders.',
    }"
    validation-visibility="live"
    value="1000"
  />
```

You can also use this rule to validate that the length of an `Array` is more than or equal to a minimum value.

### Example: Max

#### rule-min-array.vue

```vue
<FormKit
    type="checkbox"
    :options="{
      form_1: 'Forms',
      form_2: 'Forms',
      form_3: 'Forms',
      form_4: 'Forms',
    }"
    label="Select at least 2 of your interests."
    validation="min:2"
    validation-label="Interests"
    validation-visibility="live"
    :value="['form_1']"
  />
```

### Not

Checks to ensure the input data does not match a set of predefined values.

### Example: Not

#### rule-not.vue

```vue
<FormKit
    type="text"
    label="Place you'd like to visit"
    validation="not:Hometown"
    validation-visibility="live"
    value="Hometown"
  />
```

### Number

Checks if the input is a valid number as evaluated by `isNaN()`.

### Example: Number

#### rule-number.vue

```vue
<FormKit
    type="text"
    label="Age"
    validation="number"
    value="27365 days old"
    validation-visibility="live"
  />
```

### Required

Checks if the input is empty.

### Example: Required

#### rule-required.vue

```vue
<FormKit
    type="checkbox"
    :options="['Indubitably']"
    label="Please agree to the terms and conditions of how awesome FormKit is"
    validation="required"
    :validation-messages="{
      required: 'This field is required.',
    }"
    validation-visibility="live"
  />
```

If you don't want whitespace to cause the `required` rule to pass, you can pass `trim` as an argument to the rule:

### Example: Required

#### rule-required-trim.vue

```vue
<FormKit
    type="text"
    label="Favorite food"
    validation="required:trim"
    validation-visibility="live"
    help="Enter spaces. Whitespace won't make this rule pass."
  />
```

### Require One

Checks multiple inputs and passes if any of them have a value.

Note: the two inputs must be in the same `group` or `form`.

### Example: Required One

#### rule-require-one.vue

```vue
<FormKit type="group">
    <FormKit
      label="Meat"
      type="text"
      name="meats"
      validation="require_one:veggies"
      validation-visibility="live"
    />
    <FormKit
      label="Veggies"
      type="checkbox"
      name="veggies"
      validation="require_one:meats"
      validation-visibility="live"
      :options="[
        { label: 'Mushroom', value: 3 },
        { label: 'Onion', value: 4 },
      ]"
    />
  </FormKit>
```

### Starts With

Checks if the input starts with one of the provided options.

### Example: starts_with

#### rule-starts-with.vue

```vue
<FormKit
    type="text"
    label="Twitter Handle"
    placeholder="@username"
    validation="starts_with:@"
    validation-visibility="live"
    value="FormKit"
  />
```

### Symbol

Checks if a value consists of only symbols.

### Example: Symbol

#### rule-symbol.vue

```vue
<FormKit
    type="text"
    label="Input"
    value="Test value"
    validation="symbol"
    validation-visibility="live"
  />
```

### Uppercase

Checks if a value consists of only uppercase characters. There are two character sets: latin and default. Latin characters are strictly `[a-zA-Z]`, while the default set includes most accented characters, such as `ä`, `ù`, or `ś`.

### Example: Uppercase

#### rule-uppercase.vue

```vue
<FormKit
    type="text"
    label="Enter your desired username"
    value="dinosaurrider"
    validation="uppercase"
    validation-visibility="live"
    validation-label="username"
  />
```

### URL

Checks if the input value appears to be a properly formatted URL including the protocol. This does not check if the URL actually resolves.

### Example: url

#### rule-url.vue

```vue
<FormKit
    type="url"
    label="What is your website url?"
    validation="url"
    validation-visibility="live"
    value="formkit.com"
  />
```

## Custom rules

Validation rules are functions that accept a [core node](/essentials/architecture#node) and return a boolean value — `true` for passing and `false` for failing. Additionally, any arguments passed to the validation rule are available as arguments `1-n`. Writing your own is straight forward — for example:

```
/**
 * File: my-custom-rules/monday.js
 *
 * A contrived validation rule that ensures the input’s value is monday or mon.
 */
const monday = function (node) {
  return node.value === 'monday' || node.value === 'mon'
}

export default monday

```

### Defining custom rule behaviors

As mentioned in the [validation rule hints](#rule-hints) section, validation rules — including your custom rules — operate according to default behaviors: they run in sequence, are skipped when the input's value is empty, are synchronous, and are blocking. If you want your rule's defaults to operate differently, you can override these on your custom validation rule:

```
/**
 * A contrived validation rule that ensures the input’s value is monday or mon.
 */
const monday = function (node) {
  return node.value === 'monday' || node.value === 'mon'
}

// override default rule behaviors for your custom rule
monday.blocking = false
monday.skipEmpty = false
monday.debounce = 20 // milliseconds
monday.force = true

export default monday

```

You can also override these behaviors on a case-by-case basis with [rule hints](#rule-hints).

Once you have a validation function written — you need to register the validation rule with FormKit — either globally or specifically on an input.

### Multi-input validation rules

Validation rules can depend on values from other inputs in your [form’s tree](/essentials/architecture). To do so, use node traversal to locate another node and access its value:

### Example: Custom validation dependency

#### custom-validation-dependency.vue

```vue
<script setup>
function distinct(node) {
  // 👀 use node traversal to get the parent node
  const parent = node.at('$parent')
  if (parent.value) {
    // Ensure all the siblings are different values
    for (const childName in parent.value) {
      if (childName === node.name) continue
      if (parent.value[childName] === node.value) {
        return false
      }
    }
  }
  return true
}
</script>

<template>
  <FormKit
    type="form"
    @submit="() => false"
    :config="{
      validationVisibility: 'live',
    }"
    :value="{
      first: 'Same',
      second: 'Same',
      third: 'Different',
    }"
  >
    <FormKit
      label="First item"
      name="first"
      :validation-rules="{ distinct }"
      validation="distinct"
    />
    <FormKit
      label="Second item"
      name="second"
      :validation-rules="{ distinct }"
      validation="distinct"
    />
    <FormKit
      label="Third item"
      name="third"
      :validation-rules="{ distinct }"
      validation="distinct"
    />
  </FormKit>
</template>
```

> **Warning:** Validation rules should always be pure functions. Use only the arguments passed in and do not perform any side effects.

### Adding a rule globally

To use a validation rule anywhere in your project, you can specify it wherever your FormKit plugin is registered with Vue.

```
import { createApp } from 'vue'
import App from './App.vue'
import { plugin, defaultConfig } from '@formkit/vue'
import monday from './my-custom-rules/monday'

// prettier-ignore
createApp(App).use(plugin, defaultConfig({
  rules: { monday },
})).mount('#app')

```

Once installed you can use your validation rule in anywhere in your project.

```
<FormKit validation="required|monday" />

```

To customize the error message which shows up when your custom validation fails, follow the instructions [here](#global-validation-message).

### Adding a rule via prop

To add a validation to a specific input use the `validation-rules` prop.

### Example: Custom validation rules

#### validation-custom.vue

```vue
<script setup>
function day(node, group = 'weekdays') {
  const dayNames = [
    'monday',
    'mon',
    'tuesday',
    'tue',
    'wednesday',
    'wed',
    'thursday',
    'thu',
    'friday',
    'fri',
    'saturday',
    'sat',
    'sunday',
    'sun',
  ]
  const value = node.value.toLowerCase()
  switch (group) {
    case 'weekdays':
      return dayNames.slice(0, 10).includes(value)
    case 'weekend':
      return dayNames.slice(10).includes(value)
    default:
      return dayNames.includes(value).includes(value)
  }
}
</script>

<template>
  <FormKit
    type="text"
    label="Weekend day"
    validation="day:weekend"
    :validation-rules="{ day }"
    validation-visibility="live"
    help="Enter a weekend day."
  />
</template>
```

> **Tip:** Your custom rules probably need a custom message — the next section of the docs will cover that.

## Custom messages

There are several ways to customize your validation message. The most basic of which is to use the `validation-label` prop — allowing you to change the name of the field as used in the pre-defined validation messages.

### Example: Custom validation rules

#### validation-label.vue

```vue
<FormKit
    type="text"
    label="What is your favorite color?"
    validation="required"
    validation-label="Color"
    validation-visibility="live"
  />
```

If you need to be more specific you have two options:

- Override a rule’s message using a prop.
- Override a validation rule’s message globally.

### Validation message prop

You can easily override validation messages directly on your `FormKit` input by providing an object of strings or functions.

#### Using strings

To override a validation message on a single FormKit input, add the `validation-messages` prop with an object of rule names and a corresponding message.

### Example: Custom validation rules

#### validation-custom-messages.vue

```vue
<FormKit
    label="NBA G.O.A.T?"
    placeholder="Jordan, LeBron, Curry etc..."
    validation="is:Jordan,jordan"
    validation-visibility="live"
    :validation-messages="{
      is: 'The correct answer is: Jordan.',
    }"
  />
```

#### Using functions

If you need more power for your validation rules, you can use a function instead of a string. The function is passed a context object.

##### Validation message context object:

| Behavior | Description |
| --- | --- |
| args | An array of arguments passed to the rule. For example 'Vue', 'React', 'Angular' from the rule is:Vue,React,Angular. |
| name | The name of the field (first available from: validation-label, label, then name). |
| node | The FormKit core node. |

Let’s re-write the above example using a function instead of a string for even more control of the `validation-messages` prop:

### Example: Custom validation rules

#### validation-custom-messages-function.vue

```vue
<script setup>
const customMessage = ({ name, args, node }) => {
  return `${node.value} is not a ${name}. Select ${args[0]}, ${args[1]}, or ${args[2]}`
}
</script>

<template>
  <FormKit
    type="select"
    label="Favorite JS framework?"
    placeholder="Select a framework"
    :options="['Vue', 'React', 'Angular', 'Laravel', 'Django']"
    validation="required|is:Vue,React,Angular"
    validation-label="JS framework"
    validation-visibility="live"
    :validation-messages="{
      required: 'Pick your favorite framework',
      is: customMessage,
    }"
  />
</template>
```

### Global validation message

If there are validation rule messages you'd like to override (or add) across your entire project, you can define those message rules when registering FormKit under the language key you'd like to override:

```
import { createApp } from 'vue'
import App from './App.vue'
import { plugin, defaultConfig } from '@formkit/vue'
import monday from './my-custom-rules/monday'

// prettier-ignore
createApp(App).use(plugin, defaultConfig({
  messages: {
    en: {
      validation: {
        required({ name }) {
          return `Please fill out the ${name} field.`
        }
      }
    }
  }
})).mount('#app')

```

## Moving validation messages

If you would like to render an input’s validation messages outside of the `<FormKit />` component, you can leverage the `<FormKitMessages />` component by passing the input’s node as a prop. Using this component disables the default display of messages (located beneath the input) and moves them to wherever the `<FormKitMessages />` component is located:

### Example: Submit invalid

#### normal-input.vue

```vue
<!-- :html -->
<script setup>
import { ref } from 'vue'
import { FormKitMessages } from '@formkit/vue'
const input = ref()
</script>

<template>
  <div class="flex">
    <FormKit
      type="text"
      ref="input"
      validation="required|length:4"
      validation-visibility="live"
      label="Dinosaur name"
      placeholder="Stegosaurus"
    />
    <!-- 👀 messages will be rendered here instead -->
    <FormKitMessages :node="input?.node" />
  </div>
</template>
<!-- :html -->

<style scoped>
.flex {
  display: flex;
  gap: 1rem;
}
</style>
```

## Extracting messages

> **Tip:** FormKit 1.0.0 introduced the FormKitSummary component which provides an "out of the box" solution to for displaying all the validation messages in a given form or subtree.

To get all the validation messages from an [input’s core node](/essentials/architecture), you can use the `getValidationMessages` function exported from `@formkit/validation`. This function will recursively check the given node and all children for validation messages and return a Map of core nodes to validation messages, making it ideal for use with forms:

### Example: Submit invalid

#### submit-invalid.vue

```vue
<script setup>
import { getValidationMessages } from '@formkit/validation'
import { ref } from 'vue'

const messages = ref([])

function showErrors(node) {
  const validations = getValidationMessages(node)
  messages.value = []
  validations.forEach((inputMessages) => {
    messages.value = messages.value.concat(
      inputMessages.map((message) => message.value)
    )
  })
}
</script>

<template>
  <h2 class="text-xl font-bold mb-4">Support ticket</h2>
  <FormKit type="form" @submit-invalid="showErrors">
    <ul class="validation-errors" v-if="messages.length">
      <li v-for="message in messages">{{ message }}</li>
    </ul>
    <FormKit
      name="title"
      label="Ticket title"
      help="A short sentence that describes your problem."
      validation="required"
    />
    <FormKit
      name="issue"
      type="textarea"
      label="Issue"
      help="Please describe your issue in detail."
      validation="required|length:50,500"
    />
  </FormKit>
</template>
```

## Triggering validation

Trying to manually trigger validation is an anti-pattern in FormKit and should be avoided. Validation is continually computed via fine-grained reactivity. If a value or prop that is used in a validation rule changes, the validation will be automatically be re-run. This ensures validity state, settlement state, submission state and any other validation-related properties can always be trusted.
