tests
testCreateClassInModuleInsertsClassInModule

	| module |
	module := MLImportingModule new.
	module import: 'Object' from: (MLDictionaryModule for: Smalltalk).
	module createClassNamed: 'Mock'.
	self assert: (module classNamed: 'Mock') superclass equals: Object