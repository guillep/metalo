tests
testCreateSubclassOfUnboundClassHasUnboundSuperclass

	| module |
	module := MLModule newNamed: 'myModule'.
	module declareClassNamed: #Point subclassOfClassNamed: #Object.
	
	"Point class exists and inherits from an UndefinedClass"
	self assert: (module at: #Point) superclass isUndefinedSubclass 