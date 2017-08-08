test-import
testImportAlreadyImportedNameFromDifferentModuleFails

	| module |
	module := MLModule newNamed: 'myModule'.
	module import: #Object from: #Kernel.
	
	self
		should: [ module import: #Object from: #Kernel2 ]
		raise: Error