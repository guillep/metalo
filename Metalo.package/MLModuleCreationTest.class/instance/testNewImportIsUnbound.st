imports
testNewImportIsUnbound

	| emptyModule import |
	emptyModule := MLModule newNamed: 'MEmptyModule'.
	emptyModule import: #SomeName from: #SomeContainerModule.

	self assert: emptyModule unboundImports size equals: 1.
	
	import := emptyModule unboundImports anyOne.
	self assert: import importedName equals: #SomeName.
	self assert: import moduleName equals: #SomeContainerModule.