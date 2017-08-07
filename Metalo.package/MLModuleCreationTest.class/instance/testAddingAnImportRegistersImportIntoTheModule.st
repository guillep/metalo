imports
testAddingAnImportRegistersImportIntoTheModule

	| importer |
	importer := MLModule newNamed: 'MEmptyModule'.
	importer import: #SomeName from: #SomeContainerModule.

	self assert: (importer hasImport: #SomeName from: #SomeContainerModule)