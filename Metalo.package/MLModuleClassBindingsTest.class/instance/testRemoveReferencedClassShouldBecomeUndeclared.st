tests-declaredClasses
testRemoveReferencedClassShouldBecomeUndeclared

	| module point rectangle |
	module := MLModule newNamed: 'myModule'.
	
	point := module declareClassNamed: #Point.
	rectangle := module declareClassNamed: #Rectangle.
	module compileMethod: 'test ^Point' inClass: rectangle.
	
	self assert: module undeclaredNames isEmpty.
	
	module removeClassNamed: #Point.

	self assert: (module undeclaredNames includes: #Point).
	self assert: (rectangle >> #test) literals first == module undeclaredBindings associations anyOne.
	self assert:  module undeclaredBindings associations anyOne value isUndefinedSubclass.