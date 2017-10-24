tests
testNewWorkpaceBindingRefersToNil

	workspace evaluate: 'unknownVariable'.
	self assert: (workspace bindings at: #unknownVariable) isNil