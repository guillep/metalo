examples
exampleModule

	| imports |
	imports := MLMetaModuleWithImports createModuleNamed: 'Imports'.
	imports metaModule createClassNamed: 'Test'.

	imports metaModule compileMethod: 'imports
		metaModule importGlobalName: #OrderedCollection' inClass: (imports class).

	imports metaModule compileMethod: 'orderedCollection
		^ OrderedCollection' inClass: (imports classNamed: 'Test').
	^ imports