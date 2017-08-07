tests
testCreateClassInModuleDefinesClassNameInModule

	| module |
	module := MLModule newNamed: 'myModule'.
	module createClassNamed: #Object.
	
	self assert: (module definesName: #Object)