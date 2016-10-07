tests-binding
testChangingNetworkModuleAffectsItsImporters

	| registry socket socketTest result |
	registry := MLModuleRegistry default.
	registry registerModule: networkModule.
	testModule := MLModuleDefinition networkTests createModuleBoundTo: registry.

	socket := networkModule classNamed: #Socket.
	networkModule metaModule compileMethod: 'isConnected ^ false' inClass: socket.
	
	socketTest := testModule classNamed: #SocketTest.
	result := socketTest run: #testClientConnect.
	
	self assert: result hasFailures