tests
testRemoveReferencedClassShouldBecomeUndeclared


	| rectangle undeclaredSet |

	undeclaredSet := module undeclaredNames.

	rectangle := module declareClassNamed: #Rectangle.
	module compileMethod: 'test ^',self definedClassName inClass: rectangle.
	
	self assert: 	module undeclaredNames equals: undeclaredSet.
	
	module removeClassNamed: self definedClassName.

	self assert: (module undeclaredNames includes: self definedClassName).
	self assert: (rectangle >> #test) literals first == module undeclaredBindings associations anyOne.
	self assert:  module undeclaredBindings associations anyOne value isUndefinedSubclass.