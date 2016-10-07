tests-name invariants
testImportedClassIsIdenticalToClassOutsideModule

	self assert: (networkModule resolveName: #Object) == Object