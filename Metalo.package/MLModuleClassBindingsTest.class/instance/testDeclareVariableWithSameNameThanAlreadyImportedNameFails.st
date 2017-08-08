test-import
testDeclareVariableWithSameNameThanAlreadyImportedNameFails

	| module |
	module := MLModule newNamed: 'myModule'.
	module import: #Object from: #Kernel.
	
	self should: [module declareVariableNamed: #Object] raise: Error