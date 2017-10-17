test-import
testImportAlreadyImportedNameFromDifferentModuleFails

	| module |
	module := MLModule newNamed: 'myModule'.
	module declareImport: #Object from: #Kernel.
	
	self
		should: [ module declareImport: #Object from: #Kernel2 ]
		raise: Error