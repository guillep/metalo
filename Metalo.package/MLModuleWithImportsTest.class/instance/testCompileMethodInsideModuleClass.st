tests
testCompileMethodInsideModuleClass

	| module |
	module := MLImportingModule new.
	module import: 'Object' from: (MLDictionaryModule for: Smalltalk).
	module createClassNamed: 'Mock'.
	
	module
		addMethod: 'mockModuleMethod
		^ 42'
		inClassNamed: 'Mock'.
		
	self assert: (module classNamed: 'Mock') new mockModuleMethod equals: 42