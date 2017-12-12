test-moduleVariables
testDeclaringTwiceAModuleVariableShareASingleVariableDeclaration
	| variable2 |
	
	variable2 := self declareVariable.
	self assert: variable == variable2