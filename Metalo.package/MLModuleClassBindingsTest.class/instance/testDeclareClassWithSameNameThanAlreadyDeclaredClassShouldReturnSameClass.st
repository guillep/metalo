tests-declaredClasses
testDeclareClassWithSameNameThanAlreadyDeclaredClassShouldReturnSameClass

	| module object object2 superclass |
	module := MLModule newNamed: 'myModule'.
	superclass := module declareClassNamed: #Super.
	
	object := module declareClassNamed: #Object.
	self assert: object superclass equals: nil.
	
	object2 := module declareClassNamed: #Object subclassOfClassNamed: #Super.
	
	self assert: object superclass equals: superclass.
	self assert: object == object2