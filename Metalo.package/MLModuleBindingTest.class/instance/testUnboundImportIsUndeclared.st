tests
testUnboundImportIsUndeclared

	| emptyModule |
	emptyModule := MLModule newNamed: 'MEmptyModule'.
	emptyModule declareImport: #SomeName from: #SomeContainerModule.

	self assert: ((emptyModule unboundImports collect: #importedName) includes: #SomeName).