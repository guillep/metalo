imports
testAddingAnImportRegistersImportIntoTheModule

	| importer |
	importer := MLModule newNamed: 'MEmptyModule'.
	importer declareImport: #SomeName from: #SomeContainerModule.

	self assert: (importer hasImport: #SomeName from: #SomeContainerModule)