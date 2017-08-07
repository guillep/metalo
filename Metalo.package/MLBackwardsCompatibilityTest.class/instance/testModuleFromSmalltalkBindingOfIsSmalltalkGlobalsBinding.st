tests
testModuleFromSmalltalkBindingOfIsSmalltalkGlobalsBinding

	| module |
	module := MLModule withEnvironment: Smalltalk globals.
	
	self assert: (module bindingOf: #Object) == (Smalltalk globals bindingOf: #Object)