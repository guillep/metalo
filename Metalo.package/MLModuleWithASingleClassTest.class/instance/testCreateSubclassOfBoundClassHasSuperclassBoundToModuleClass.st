tests
testCreateSubclassOfBoundClassHasSuperclassBoundToModuleClass


	module declareClassNamed: #Point subclassOfClassNamed: self definedClassName.
	
	self assert: (module classNamed: #Point) superclass equals: definedClass