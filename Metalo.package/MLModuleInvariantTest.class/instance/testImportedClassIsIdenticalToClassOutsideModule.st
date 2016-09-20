as yet unclassified
testImportedClassIsIdenticalToClassOutsideModule

	self assert: (module resolveName: #Object) == Object