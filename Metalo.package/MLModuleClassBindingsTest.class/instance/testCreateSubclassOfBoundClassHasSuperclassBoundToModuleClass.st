test-class bindings
testCreateSubclassOfBoundClassHasSuperclassBoundToModuleClass

	| module |
	module := MLModule newNamed: 'myModule'.
	module declareClassNamed: #Object.
	module declareClassNamed: #Point subclassOfClassNamed: #Object.
	
	self assert: (module classNamed: #Point) superclass equals: (module classNamed: #Object)