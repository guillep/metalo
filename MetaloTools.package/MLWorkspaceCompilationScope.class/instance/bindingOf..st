compilation
bindingOf: aName
	
	| parentBinding |
	parentBinding := parentScope bindingOf: aName.
	^ parentBinding ifNil: [ 
			aName first isUppercase ifTrue: [ MLUnknownClassError signalForName: aName ].
			workspace declareWorkspaceBindingNamed: aName ] 
		ifNotNil: [ parentBinding ]