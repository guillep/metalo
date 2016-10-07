tests-binding
testModuleBindingBindsToCorrectModuleOnNameClash

	| registry |
	registry := MLModuleRegistry default.
	registry registerModule: networkModule.
	
	testModule := MLModuleDefinition networkTests createModuleBoundTo: registry.
	
	self assert: (testModule bindingOf: #TestCase) == (Smalltalk globals bindingOf: #TestCase).
	
	self assert: (testModule bindingOf: #Socket) ~= (Smalltalk globals bindingOf: #Socket).
	self assert: (testModule bindingOf: #Socket) == (networkModule bindingOf: #Socket).