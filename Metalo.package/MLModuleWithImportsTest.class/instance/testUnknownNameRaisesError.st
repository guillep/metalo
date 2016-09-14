tests
testUnknownNameRaisesError

	| module |
	module := MLImportingModule new.
	module import: 'Object' from: (MLDictionaryModule for: Smalltalk).
	module createClassNamed: 'Mock'.
	
	self should: [
		module
			addMethod: 'mockModuleMethod
			^ unknownName'
			inClassNamed: 'Mock' ] raise: Error.