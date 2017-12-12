test-undeclareds
testRemoveSingleReferenceToUndeclareShouldRemoveUndeclared

	
	self assert: (module undeclaredNames includes: self undeclaredVariableName).
	
	module removeSelector: self definedMethodSelector fromClassNamed: self definedClassName.
	
	self assert: module undeclaredNames isEmpty.