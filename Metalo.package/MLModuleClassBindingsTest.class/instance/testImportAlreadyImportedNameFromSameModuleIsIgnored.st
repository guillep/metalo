test-import
testImportAlreadyImportedNameFromSameModuleIsIgnored

	| module |
	module := MLModule newNamed: 'myModule'.
	module declareImport: #Object from: #Kernel.
	module declareImport: #Object from: #Kernel.
	
	self assert: module imports size equals: 1 