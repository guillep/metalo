compilation
bindingOf: aName
	
	| parentBinding |
	parentBinding := parentScope bindingOf: aName.
	^ parentBinding isUndeclared
		ifTrue: [ 
			aName first isUppercase ifTrue: [ MLUnknownClassError signalForName: aName ].
			workspace declareWorkspaceBindingNamed: aName ] 
		ifFalse: [ parentBinding ]