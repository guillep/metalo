as yet unclassified
testExplicitImportShouldMakeImportedNameAvailable

	| module importedModule |
	module := MLImportingModule new.
	module import: 'Object' from: (MLDictionaryModule for: Smalltalk).
	module createClassNamed: 'Mock'.

	importedModule := MLImportingModule new.
	importedModule import: 'Object' from: (MLDictionaryModule for: Smalltalk).
	importedModule createClassNamed: 'Imported'.
	
	module import: importedModule.
	
	module addMethod: 'mockModuleMethod
			^ Imported'
			inClassNamed: 'Mock'.
	
	self assert: (module classNamed: 'Mock') new mockModuleMethod equals: (importedModule classNamed: 'Imported').