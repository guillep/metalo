tests
testCreateSubclassOfUndeclaredIsInUndeclaredBindings


	| undefinedObjectClass |
	self deny: (module hasUndeclaredBinding: self definedClassName).
	self assert:  (module hasUndeclaredBinding: self undeclaredName).

	undefinedObjectClass := module undeclaredBindings at: self undeclaredName.
	self assert: undefinedObjectClass  isUndefinedSubclass.
	self assert: undefinedObjectClass equals: definedClass superclass.
	
	