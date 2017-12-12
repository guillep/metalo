test-moduleVariables
testDeclareImportWithSameNameThanAlreadyDeclaredModuleVariableFails
	
	self should: [module declareImport: self definedVariableName from: #Kernel] raise: Error