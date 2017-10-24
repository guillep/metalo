tests
testSubclassOfUndefinedClassIsUndefined

	module := MLModule newNamed: 'myModule'.
	module declareClassNamed: #Object subclassOfClassNamed: #DoNotKnowThisClass.
	
	self assert: (module classNamed: #Object) isUndefinedSubclass