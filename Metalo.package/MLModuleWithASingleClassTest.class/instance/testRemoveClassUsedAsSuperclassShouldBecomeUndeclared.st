tests
testRemoveClassUsedAsSuperclassShouldBecomeUndeclared

	| coloredPoint undeclaredSet |

	undeclaredSet := module undeclaredNames.

	coloredPoint := module declareClassNamed: #ColoredPoint subclassOfClassNamed: self definedClassName.

	self assert: 	module undeclaredNames equals: undeclaredSet.

	module removeClassNamed: self definedClassName.

	self assert: (module undeclaredNames includes: self definedClassName).
	self assert: coloredPoint superclass == module undeclaredBindings associations anyOne value.
	self assert:  coloredPoint isUndefinedSubclass.
	self assert:  coloredPoint superclass isUndefinedSubclass.