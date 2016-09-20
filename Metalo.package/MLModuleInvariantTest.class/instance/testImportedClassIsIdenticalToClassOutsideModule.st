tests-name invariants
testImportedClassIsIdenticalToClassOutsideModule

	self assert: (module resolveName: #Object) == Object