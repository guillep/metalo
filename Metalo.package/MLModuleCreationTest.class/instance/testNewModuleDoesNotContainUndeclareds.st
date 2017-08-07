empty-modules
testNewModuleDoesNotContainUndeclareds

	| emptyModule |
	emptyModule := MLModule newNamed: 'MEmptyModule'.
	
	self assert: emptyModule undeclaredNames isEmpty.