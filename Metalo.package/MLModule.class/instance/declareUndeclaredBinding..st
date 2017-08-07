binding-resolution
declareUndeclaredBinding: aString 
	
	undeclaredBindings
		at: aString
		ifAbsent: [ undeclaredBindings add: (MLUndeclaredBinding named: aString) ].
	^ undeclaredBindings bindingOf: aString.