test-moduleVariables
testRemoveInexistentModuleVariableShouldFail	
	self should: [ module removeVariableNamed: #Object ] raise: NotFound