tests
testEvaluateUnknownVariableCreatesWorkspaceBinding

	workspace evaluate: 'unknownVariable'.
	self assert: (workspace bindings includesKey: #unknownVariable)