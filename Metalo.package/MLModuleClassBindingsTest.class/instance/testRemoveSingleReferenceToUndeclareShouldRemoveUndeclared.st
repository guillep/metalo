test-undeclareds
testRemoveSingleReferenceToUndeclareShouldRemoveUndeclared

	| module point |
	module := MLModule newNamed: 'myModule'.
	
	point := module declareClassNamed: #Point.
	module compileMethod: 'test ^Variable' inClass: point.
	
	self assert: (module undeclaredNames includes: #Variable).
	
	module removeSelector: #test fromClassNamed: #Point.
	
	self assert: module undeclaredNames isEmpty.