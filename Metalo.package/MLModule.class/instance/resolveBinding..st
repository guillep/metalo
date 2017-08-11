binding-resolution
resolveBinding: aString 
	
	(classBindings includesKey: aString)
		ifTrue: [ ^ classBindings bindingOf: aString ].
	variableBindings
		at: aString
		ifPresent: [ :binding | ^ binding ].
	(self hasImportNamed: aString)
		ifTrue: [ ^ self importedBindingOf: aString ].

	"If it is not defined locally, nor in the imports, we define it as an undeclared"
	^ self declareUndeclaredBinding: aString