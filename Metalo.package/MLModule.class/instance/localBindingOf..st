binding-resolution
localBindingOf: aName
	| binding |
	binding := classBindings bindingOf: aName.
	^ binding
		ifNil: [ | resolvedName |
			resolvedName := variableBindings at: aName ifAbsent: [ nil ].
			resolvedName ifNil: [ (MLUnresolvedNameError named: aName inModuleNamed: name) signal ] ]