test-moduleVariables
testRemoveUnusedModuleVariableShouldRemoveItWithoutLeavingUndeclareds

	|  point  |
		
	module removeVariableNamed: self definedVariableName.
	
	self assert: module variableNames isEmpty.
	self assert: module undeclaredNames isEmpty.