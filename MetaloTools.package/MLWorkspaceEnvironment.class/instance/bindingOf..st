compilation
bindingOf: aName
	
	| superBinding |
	superBinding := parentEnvironment bindingOf: aName.
	^ superBinding isUndeclared
		ifTrue: [ workspace declareWorkspaceBindingNamed: aName ]
		ifFalse: [ superBinding ]