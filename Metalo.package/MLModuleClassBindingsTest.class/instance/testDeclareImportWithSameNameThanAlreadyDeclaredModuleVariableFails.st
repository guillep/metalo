test-moduleVariables
testDeclareImportWithSameNameThanAlreadyDeclaredModuleVariableFails

	| module variable |
	module := MLModule newNamed: 'myModule'.
	
	variable := module declareVariableNamed: #Variable.
	
	self should: [module import: #Variable from: #Kernel] raise: Error