Constant4to5 = require './index'
Test = require 'tape'

Test 'not a json-schema constant', (t) ->
	obj =
		constant: 'foo'
	t.ok 'constant' of obj
	Constant4to5 obj
	t.ok 'constant' of obj
	t.notOk 'enum' of obj
	t.end()

Test 'detect constant by type', (t) ->
	obj =
		name:
			type: 'string'
			constant: 'foo'
	t.ok 'constant' of obj.name
	Constant4to5 obj
	t.notOk 'constant' of obj.name
	t.equals obj.name.type, 'string'
	t.equals obj.name.enum[0], 'foo'
	t.end()

Test 'detect by grandParent', (t) ->
	obj =
		properties:
			name:
				constant: 'foo'
	t.ok 'constant' of obj.properties.name
	Constant4to5 obj
	t.ok 'constant' not of obj.properties.name, 'deleted constant'
	t.ok 'enum' of obj.properties.name
	t.equals obj.properties.name.enum[0], 'foo'
	t.end()
