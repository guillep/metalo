examples
exampleModule

	| imported importing moduleRegistry |
	moduleRegistry := Dictionary new.
	
	imported := MLMetaModuleWithStackedImports createModuleNamed: 'Imported'.
	imported metaModule moduleRegistry: moduleRegistry.
	moduleRegistry at: imported name put: imported.
	
	imported metaModule createClassNamed: 'Universe'.
	imported metaModule compileMethod: 'answer
		^ 42' inClass: (imported classNamed: #Universe).
	
	importing := MLMetaModuleWithStackedImports createModuleNamed: 'Importing'.
	importing metaModule moduleRegistry: moduleRegistry.
	moduleRegistry at: importing name put: importing.
	
	importing metaModule compileMethod: 'imports
		metaModule import: #Imported' inClass: (importing class).
	importing metaModule createClassNamed: 'Test'.
	importing metaModule compileMethod: 'answerToTheUniverse
		^ Universe new answer' inClass: (importing classNamed: 'Test').
	^ importing