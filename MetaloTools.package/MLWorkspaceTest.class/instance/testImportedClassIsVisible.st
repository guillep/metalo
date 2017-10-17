tests
testImportedClassIsVisible

	| module kernel |
	module := workspace module.
	module import: #Point from: #Smalltalk.
	
	kernel := MLModule withEnvironment: Smalltalk globals.
	kernel name: #Smalltalk.
	module bindTo: kernel.

	self assert: (module bindingOf: #Point) equals: Point binding.

	self assert: (workspace evaluate: 'Point') equals: Point.