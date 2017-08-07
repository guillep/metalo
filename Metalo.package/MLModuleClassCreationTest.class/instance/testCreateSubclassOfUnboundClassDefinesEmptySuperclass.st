tests
testCreateSubclassOfUnboundClassDefinesEmptySuperclass

	| module |
	module := MLModule newNamed: 'myModule'.
	module createClassNamed: #Point subclassOf: #Object.
	
	self assert: (module definesName: #Object)