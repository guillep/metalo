test-undeclareds
testUndefinedSuperclassCreatesUndeclaredBinding

	| module |
	module := MLModule newNamed: 'myModule'.
	module declareClassNamed: #Point.
	module compileMethod: 'test ^ Object' inClass: #Point.
	
	self assert: (module undeclaredNames includes: #Object)