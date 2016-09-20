resolution
resolveName: aName
	
	| resolvedBinding |
	resolvedBinding := self bindingOf: aName.
	resolvedBinding ifNil: [ self error: 'Name not found: ', aName ].
	^ resolvedBinding value