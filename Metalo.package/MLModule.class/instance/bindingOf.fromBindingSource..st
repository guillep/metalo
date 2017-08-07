binding-resolution
bindingOf: aName fromBindingSource: aSource

	| resolvedName |
	resolvedName := aSource bindingOf: aName.
	resolvedName ifNil: [ (MLUnresolvedNameError named: aName inModuleNamed: name) signal ].
	^ resolvedName