as yet unclassified
testModuleMakesEnvironmentVisible

	| module |
	module := MLImportingModule new.
	module import: 'Object' from: (MLDictionaryModule for: Smalltalk).
	module createClassNamed: 'Mock'.

	module addMethod: 'mockModuleMethod
			^ thisModule'
			inClassNamed: 'Mock'.
	
	self assert: (module classNamed: 'Mock') new mockModuleMethod equals: module.