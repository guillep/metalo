test-moduleVariables
testDeclareClassWithSameNameThanAlreadyDeclaredModuleVariableFails

	| module variable |
	module := MLModule newNamed: 'myModule'.
	
	variable := module declareVariableNamed: #Variable.
	
	self should: [module declareClassNamed: #Variable] raise: Error