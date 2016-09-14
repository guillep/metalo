as yet unclassified
exampleModule

	| imports |
	imports := MLMetaModuleWithSelectorNamespace createModuleNamed: 'SelectorNamespace'.
	imports metaModule createClassNamed: 'Test'.

	imports metaModule compileMethod: 'one
		^ 1' inClass: (imports classNamed: 'Test').
	^ imports