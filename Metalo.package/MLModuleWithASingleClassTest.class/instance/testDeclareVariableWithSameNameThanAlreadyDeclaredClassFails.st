tests
testDeclareVariableWithSameNameThanAlreadyDeclaredClassFails

	self should: [module declareVariableNamed: self definedClassName ] raise: Error