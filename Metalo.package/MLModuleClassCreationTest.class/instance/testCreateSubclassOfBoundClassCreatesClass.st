tests
testCreateSubclassOfBoundClassCreatesClass

	| module |
	module := MLModule newNamed: 'myModule'.
	module createClassNamed: #Object.
	module createClassNamed: #Point subclassOf: #Object.
	
	self assert: (module at: #Point) superclass equals: (module at: #Object)