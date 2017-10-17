tests
testDefineUndefinedClassReplacesOldClass

	module := MLModule newNamed: 'myModule'.
	module declareClassNamed: #Object subclassOfClassNamed: #DoNotKnowThisClass.
	
	self assert: (module classNamed: #Object) isUndefined.
	
	module declareClassNamed: #DoNotKnowThisClass.
	
	self deny: (module classNamed: #Object) isUndefined.