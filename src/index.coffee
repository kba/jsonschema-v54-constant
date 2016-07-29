Traverse = require 'traverse'
module.DEBUG = false

greatParentProps = {}
parentProps = {}
constantTypes = {}
greatParentProps[k] = true for k,v in ['properties', 'additionalProperties']
parentProps[k] = true for k,v in ['items', 'additionalItems', 'not']
constantTypes[k] = true for k,v in ['string', 'number']

module.exports = (obj) ->
	Traverse(obj).forEach (node) ->
		ctx = this
		return unless ctx.key is 'constant'
		if module.DEBUG then console.log "It's a constant"
		schemaType = ctx.parent?.node?.type
		if typeof node.key is 'object'
			throw kw Error "'constant' with $data reference not supported"
		if schemaType of constantTypes or
		ctx.parent?.key of parentProps or
		ctx.parent?.parent?.key of greatParentProps
			schemaType or= typeof node
			ctx.parent.node.type = schemaType
			if module.DEBUG then console.log "It's a json-schema v5 constant"
			if schemaType is 'string'
				ctx.parent.node.enum = [node]
			else if schemaType is 'number'
				ctx.parent.node.min = node
				ctx.parent.node.max = node
			ctx.update()
			ctx.remove()
