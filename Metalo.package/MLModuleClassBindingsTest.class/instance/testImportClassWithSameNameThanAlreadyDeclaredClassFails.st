tests-declaredClasses
testImportClassWithSameNameThanAlreadyDeclaredClassFails

	| module variable |
	module := MLModule newNamed: 'myModule'.
	
	variable := module declareClassNamed: #Object.
	
	self should: [module import: #Object from: #Kernel ] raise: Error