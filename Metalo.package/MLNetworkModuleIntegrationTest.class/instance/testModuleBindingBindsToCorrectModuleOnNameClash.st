tests-binding
testModuleBindingBindsToCorrectModuleOnNameClash

	registry registerModule: networkModule.
	registry registerModule: self networkMIME.
	self networkMIME bindTo: registry.
	
	testModule := self networkTests.
	testModule bindTo: registry.
	
	self assert: (testModule bindingOf: #TestCase) == (Smalltalk globals bindingOf: #TestCase).
	
	self assert: (testModule bindingOf: #Socket) ~= (Smalltalk globals bindingOf: #Socket).
	self assert: (testModule bindingOf: #Socket) == (networkModule bindingOf: #Socket).