undeclareds
declareUndeclaredBinding: aString with: aValue
	
	undeclaredBindings
		at: aString
		ifAbsent: [ undeclaredBindings add: (MLUndeclaredBinding key: aString value: aValue) ].
	^ undeclaredBindings bindingOf: aString.