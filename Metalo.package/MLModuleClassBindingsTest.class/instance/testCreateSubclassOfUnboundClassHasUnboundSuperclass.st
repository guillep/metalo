tests-undefined classes
testCreateSubclassOfUnboundClassHasUnboundSuperclass

	| module |
	module := MLModule newNamed: 'myModule'.
	module declareClassNamed: #Point subclassOfClassNamed: #Object.
	
	self assert: (module at: #Point) superclass notNil