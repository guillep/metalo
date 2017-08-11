test-class bindings
testCreateSubclassOfBoundClassHasSuperclassBoundToModuleClass

	| module |
	module := MLModule newNamed: 'myModule'.
	module declareClassNamed: #Object.
	module declareClassNamed: #Point subclassOfClassNamed: #Object.
	
	self assert: (module at: #Point) superclass equals: (module at: #Object)