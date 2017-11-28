tests-binding
testModuleBoundToSmalltalkGlobalsIsSuccessful

	|  socketTest result |
	registry registerModule: networkModule.
	registry registerModule: (self class networkMIME createModuleBoundTo: registry).
	testModule := self class networkTests createModuleBoundTo: registry.
	
	socketTest := testModule classNamed: #SocketTest.
	result := socketTest run: #testClientConnect.
	
	self assert: result hasPassed