tests
testDeclareClassWithSameNameThanAlreadyDeclaredModuleVariableFails
	
	self should: [module declareClassNamed: self definedVariableName ] raise: Error