test-undeclareds
testCreateSubclassOfUndeclaredIsInUndeclaredBindings

	| module pointClass undefinedObjectClass |	
	module := MLModule newNamed: 'myModule'.
	
	"We create a subclass of an undefined class. This triggers the creation of an undefined #Object class local to the module."
	pointClass := module declareClassNamed: #Point subclassOfClassNamed: #Object.
		
	self deny: (module hasUndeclaredBinding: #Point).
	self assert:  (module hasUndeclaredBinding: #Object).

	undefinedObjectClass := module undeclaredBindings at: #Object.
	self assert: undefinedObjectClass  isUndefinedSubclass.
	self assert: undefinedObjectClass equals: pointClass superclass.
	
	