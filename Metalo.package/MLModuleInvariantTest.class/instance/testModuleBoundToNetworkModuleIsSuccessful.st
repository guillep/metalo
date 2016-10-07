tests-binding
testModuleBoundToNetworkModuleIsSuccessful

	| registry socketTest result |
	registry := MLModuleRegistry default.
	registry registerModule: networkModule.
	testModule := MLModuleDefinition networkTests createModuleBoundTo: registry.
	
	socketTest := testModule classNamed: #SocketTest.
	result := socketTest run: #testClientConnect.
	
	self assert: result hasPassed