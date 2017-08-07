tests
testBoundingImportWithDifferentModuleProvidingNameIsUnbound

	| importee importer import |
	importee := MLModule newNamed: #UnexpectedModuleName.
	importee defineVariableNamed: #SomeName.

	importer := MLModule newNamed: 'MEmptyModule'.
	import := importer import: #SomeName from: #SomeContainerModule.

	importer bindTo: importee.

	self assert: import isUnbound.