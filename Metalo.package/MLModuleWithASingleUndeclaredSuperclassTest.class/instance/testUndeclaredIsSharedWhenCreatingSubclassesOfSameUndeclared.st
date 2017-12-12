test-undeclareds
testUndeclaredIsSharedWhenCreatingSubclassesOfSameUndeclared
	
	| colorClass |
	colorClass := module declareClassNamed: #Color subclassOfClassNamed: self undeclaredName.
	
	self assert: definedClass superclass equals: colorClass superclass.
	self assert:  module undeclaredBindings size equals: 1.
		
	