tests
testBoundingImportIsBound

	| importee importer import |
	importee := MLModule newNamed: #SomeContainerModule.
	importee declareVariableNamed: #SomeName.

	importer := MLModule newNamed: 'MEmptyModule'.
	import := importer declareImport: #SomeName from: #SomeContainerModule.

	importer bindTo: importee.

	self assert: import isBound.