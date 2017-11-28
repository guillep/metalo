tests
testSubclassOfUndefinedClassIsUndefined

	module declareClassNamed: #Object subclassOfClassNamed: #DoNotKnowThisClass.
	
	self assert: (module classNamed: #Object) isUndefinedSubclass