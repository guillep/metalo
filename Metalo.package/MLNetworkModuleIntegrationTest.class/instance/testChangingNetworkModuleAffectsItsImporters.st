tests-binding
testChangingNetworkModuleAffectsItsImporters

	| socket socketTest result |
	registry registerModule: networkModule.
	registry registerModule: self networkMIME.
	self networkMIME bindTo: registry.
	
	testModule := self networkTests bindTo: registry; yourself.

	socket := networkModule classNamed: #Socket.
	networkModule compileMethod: 'isConnected ^ false' inClass: socket.
	
	socketTest := testModule classNamed: #SocketTest.
	result := socketTest run: #testClientConnect.
	
	self assert: result hasFailures