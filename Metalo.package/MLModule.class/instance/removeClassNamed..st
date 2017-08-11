classes
removeClassNamed: aString 
	
	| aBinding |
	aBinding := classBindings bindingOf: aString.
	aBinding ifNil: [ 
		"The class does not exist."
		NotFound signalFor: aString.
	].
	classBindings removeKey: aBinding name.
	
	SystemAnnouncer uniqueInstance suspendAllWhile: [ | undefinedClass |
		undefinedClass := self declareUndefinedClassNamed: aBinding name.
		aBinding value becomeForward: undefinedClass ].
	self checkUndeclaredBinding: aBinding