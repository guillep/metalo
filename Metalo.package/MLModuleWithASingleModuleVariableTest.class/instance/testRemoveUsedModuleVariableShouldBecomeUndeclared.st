test-moduleVariables
testRemoveUsedModuleVariableShouldBecomeUndeclared

	|  point  |
		
	point := module declareClassNamed: #Point.
	module compileMethod: 'test ^',self definedVariableName asString inClass: point.
	
	self assert: (point >> #test) literals first == variable.
	
	module removeVariableNamed: self definedVariableName.
	
	self assert: module variableNames isEmpty.
	self assert: (module undeclaredNames includes: self definedVariableName).
	self assert: (point >> #test) literals first == module undeclaredBindings associations anyOne.