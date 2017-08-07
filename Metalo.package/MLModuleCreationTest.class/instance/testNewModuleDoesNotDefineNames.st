empty-modules
testNewModuleDoesNotDefineNames

	| emptyModule |
	emptyModule := MLModule newNamed: 'MEmptyModule'.
	
	self assert: emptyModule environment isEmpty.