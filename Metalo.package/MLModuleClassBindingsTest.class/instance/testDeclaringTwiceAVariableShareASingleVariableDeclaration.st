test-declaredVariables
testDeclaringTwiceAVariableShareASingleVariableDeclaration

	| module variable1 variable2 |
	module := MLModule newNamed: 'myModule'.
	
	variable1 := module declareVariableNamed: #Variable.
	variable2 := module declareVariableNamed: #Variable.
	
	self assert: variable1 == variable2