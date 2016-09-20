resolution
resolveName: aName
	
	| resolvedBinding |
	resolvedBinding := self bindingOf: aName.
	resolvedBinding ifNil: [ (MLUnresolvedNameError named: aName) signal ].
	^ resolvedBinding value