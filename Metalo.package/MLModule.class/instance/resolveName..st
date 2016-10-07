resolution
resolveName: aName
	
	| resolvedBinding |
	resolvedBinding := self bindingOf: aName.
	resolvedBinding ifNil: [ (MLUnresolvedNameError named: aName inModuleNamed: name) signal ].
	^ resolvedBinding value