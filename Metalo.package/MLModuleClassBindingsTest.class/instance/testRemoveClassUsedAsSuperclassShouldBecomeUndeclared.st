tests-declaredClasses
testRemoveClassUsedAsSuperclassShouldBecomeUndeclared

	| module point coloredPoint |
	module := MLModule newNamed: 'myModule'.
	
	point := module declareClassNamed: #Point.
	coloredPoint := module declareClassNamed: #ColoredPoint subclassOfClassNamed: #Point.
	
	self assert: module undeclaredNames isEmpty.
	
	module removeClassNamed: #Point.

	self assert: (module undeclaredNames includes: #Point).
	self assert: coloredPoint superclass == module undeclaredBindings associations anyOne value.
	self assert:  coloredPoint isUndefinedSubclass.
	self assert:  coloredPoint superclass isUndefinedSubclass.