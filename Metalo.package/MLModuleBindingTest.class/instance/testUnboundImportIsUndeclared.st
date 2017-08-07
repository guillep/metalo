tests
testUnboundImportIsUndeclared

	| emptyModule |
	emptyModule := MLModule newNamed: 'MEmptyModule'.
	emptyModule import: #SomeName from: #SomeContainerModule.

	self assert: ((emptyModule unboundImports collect: #importedName) includes: #SomeName).