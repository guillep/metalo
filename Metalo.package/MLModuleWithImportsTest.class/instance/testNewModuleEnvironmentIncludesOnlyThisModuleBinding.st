tests
testNewModuleEnvironmentIncludesOnlyThisModuleBinding

	| module |
	module := MLImportingModule new.
	
	self assert: module environment size equals: 1.
	self assert: module environment keys first equals: 'thisModule'.
	self assert: (module environment at: 'thisModule') equals: module