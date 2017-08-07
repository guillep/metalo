tests
testUnboundImportSuperclassDoesNotDefineSuperclassName

	| module |
	module := MLModule newNamed: 'myModule'.
	module import: #Object from: #Kernel.
	module createClassNamed: #Point subclassOf: #Object.
	
	self deny: (module definesName: #Object)