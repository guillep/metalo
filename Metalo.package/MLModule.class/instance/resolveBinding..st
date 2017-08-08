binding-resolution
resolveBinding: aString 
	
	(classBindings includesKey: aString)
		ifTrue: [ ^ classBindings bindingOf: aString ].
	(importedNameBindings includesKey: aString)
		ifTrue: [ ^ importedNameBindings bindingOf: aString ].

	"If it is not defined locally, nor in the imports, we define it as an undeclared"
	^ self declareUndeclaredBinding: aString