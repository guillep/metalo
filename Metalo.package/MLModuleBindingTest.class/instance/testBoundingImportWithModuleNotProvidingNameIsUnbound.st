tests
testBoundingImportWithModuleNotProvidingNameIsUnbound

	| importee importer import |
	importee := MLModule newNamed: #SomeContainerModule.
	importee declareVariableNamed: #SomeOtherName.

	importer := MLModule newNamed: 'MEmptyModule'.
	import := importer import: #SomeName from: #SomeContainerModule.

	importer bindTo: importee.

	self assert: import isUnbound.