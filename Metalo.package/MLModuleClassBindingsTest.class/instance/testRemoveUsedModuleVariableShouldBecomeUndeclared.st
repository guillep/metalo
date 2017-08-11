test-moduleVariables
testRemoveUsedModuleVariableShouldBecomeUndeclared

	| module point variable |
	module := MLModule newNamed: 'myModule'.
	variable := module declareVariableNamed: #Variable.
	
	point := module declareClassNamed: #Point.
	module compileMethod: 'test ^Variable' inClass: point.
	
	self assert: (point >> #test) literals first == variable.
	
	module removeVariableNamed: #Variable.
	
	self assert: module variableNames isEmpty.
	self assert: (module undeclaredNames includes: #Variable).
	self assert: (point >> #test) literals first == module undeclaredBindings associations anyOne.