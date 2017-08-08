tests-declaredClasses
testDeclareVariableWithSameNameThanAlreadyDeclaredClassFails

	| module variable |
	module := MLModule newNamed: 'myModule'.
	
	variable := module declareClassNamed: #Object.
	
	self should: [module declareVariableNamed: #Object ] raise: Error