tests
testBoundImportIsBoundToBoundModule

	| importee importer import |
	importee := MLModule newNamed: #SomeContainerModule.
	importee declareVariableNamed: #SomeName.

	importer := MLModule newNamed: 'MEmptyModule'.
	import := importer declareImport: #SomeName from: #SomeContainerModule.

	importer bindTo: importee.

	self assert: import binding == (importee bindingOf: #SomeName).