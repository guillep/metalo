tests
testModuleFromSmalltalkDefinesAllSmalltalkKeys

	| module |
	module := MLModule withEnvironment: Smalltalk globals.
	Smalltalk globals keysDo: [ :name |
		self assert: (module definesName: name) ]