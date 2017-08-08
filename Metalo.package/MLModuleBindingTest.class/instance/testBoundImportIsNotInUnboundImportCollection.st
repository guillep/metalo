tests
testBoundImportIsNotInUnboundImportCollection

	| importee importer |
	importee := MLModule newNamed: #SomeContainerModule.
	importee declareVariableNamed: #SomeName.

	importer := MLModule newNamed: 'MEmptyModule'.
	importer import: #SomeName from: #SomeContainerModule.

	importer bindTo: importee.

	self assert: importer unboundImports isEmpty.