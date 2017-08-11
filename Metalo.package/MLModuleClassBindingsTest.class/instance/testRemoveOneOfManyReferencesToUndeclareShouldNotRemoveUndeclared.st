test-undeclareds
testRemoveOneOfManyReferencesToUndeclareShouldNotRemoveUndeclared

	| module point |
	module := MLModule newNamed: 'myModule'.
	
	point := module declareClassNamed: #Point.
	module compileMethod: 'test ^Variable' inClass: point.
	module compileMethod: 'test2 ^Variable' inClass: point.
	
	self assert: (module undeclaredNames includes: #Variable).
	
	module removeSelector: #test fromClassNamed: #Point.
	
	self assert: (module undeclaredNames includes: #Variable).