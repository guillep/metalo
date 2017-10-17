tests-declaredClasses
testImportClassWithSameNameThanAlreadyDeclaredClassFails

	| module variable |
	module := MLModule newNamed: 'myModule'.
	
	variable := module declareClassNamed: #Object.
	
	self should: [module declareImport: #Object from: #Kernel ] raise: Error