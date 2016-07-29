# jsonschema-v54-constant
Downgrade json-schema v5 string and number constants to v4 constructs

See [constant (v5 proposal)](https://github.com/json-schema/json-schema/wiki/constant-(v5-proposal)).

<!-- BEGIN-MARKDOWN-TOC -->
* [Usage](#usage)
* [Algorithm](#algorithm)
	* [Matching](#matching)
	* [String constant](#string-constant)
	* [Number constant](#number-constant)

<!-- END-MARKDOWN-TOC -->

## Usage

```js
var constant54 = require('jsonschema-v54-constant');
obj = { type: "object", items: { "constant": "1" } }
constant54(obj); // Modifies **in-place**!
console.log(JSON.stringify(obj));
// {"type":"object","items":{"type":"string","enum":["1"]}}
```

## Algorithm

### Matching

* Walk an object
  * If key is `constant` and
    * sibling is `type` (schemaType) or
    * parent is one of `items`, `additionalItems`, `not` or
    * grandParent is one of `properties`, `additionalProperties` then
      * schemaType defaults to `typeof value`
      * If schemaType is `object`
        * **throw Exception** Unsupported
      * [If schemaType is `string`](#string-constant)
      * [If schemaType is `number`](#number-constant)

### String constant

```js
{constant: "foo"}
==>
{type: "string", enum: ["foo"]}
```

### Number constant

```js
{constant: 42}
==>
{type: "number", min: 42, max: 42}
```
