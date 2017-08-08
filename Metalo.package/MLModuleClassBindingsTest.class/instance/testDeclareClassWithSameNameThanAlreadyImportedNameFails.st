test-import
testDeclareClassWithSameNameThanAlreadyImportedNameFails

	| module |
	module := MLModule newNamed: 'myModule'.
	module import: #Object from: #Kernel.
	
	self should: [module declareClassNamed: #Object] raise: Error