tests
testBoundingImportIsBound

	| importee importer import |
	importee := MLModule newNamed: #SomeContainerModule.
	importee defineVariableNamed: #SomeName.

	importer := MLModule newNamed: 'MEmptyModule'.
	import := importer import: #SomeName from: #SomeContainerModule.

	importer bindTo: importee.

	self assert: import isBound.