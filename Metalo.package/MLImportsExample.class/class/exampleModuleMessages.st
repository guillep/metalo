examples
exampleModuleMessages

	| imports test |
	imports := self exampleModule.
	test := (imports classNamed: 'Test') new.
	
	self assert: test orderedCollection == OrderedCollection.

	imports metaModule compileMethod: 'imports
	metaModule importGlobalName: #Array as: #OrderedCollection' inClass: imports class.	
	self assert: test orderedCollection == Array.
	
	imports metaModule compileMethod: 'imports' inClass: imports class.	
	self assert: test orderedCollection == nil.