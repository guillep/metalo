test-import
testImportAlreadyImportedNameFromSameModuleIsIgnored

	| module |
	module := MLModule newNamed: 'myModule'.
	module import: #Object from: #Kernel.
	module import: #Object from: #Kernel.
	
	self assert: module imports size equals: 1 