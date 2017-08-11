test-moduleVariables
testRemoveInexistentModuleVariableShouldFail
	| module |
	module := MLModule newNamed: 'myModule'.
		
	self should: [ module removeVariableNamed: #Object ] raise: NotFound