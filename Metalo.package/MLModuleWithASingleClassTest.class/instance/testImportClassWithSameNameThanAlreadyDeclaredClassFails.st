tests
testImportClassWithSameNameThanAlreadyDeclaredClassFails
		
	self should: [module declareImport: self definedClassName from: #Kernel ] raise: Error