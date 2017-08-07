tests
testCreateSubclassOfUnboundClassHasUnboundSuperclass

	| module |
	module := MLModule newNamed: 'myModule'.
	module createClassNamed: #Point subclassOf: #Object.
	
	self assert: (module at: #Point) superclass notNil