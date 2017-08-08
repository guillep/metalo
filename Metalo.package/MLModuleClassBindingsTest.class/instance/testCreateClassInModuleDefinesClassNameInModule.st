test-class bindings
testCreateClassInModuleDefinesClassNameInModule

	| module |
	module := MLModule newNamed: 'myModule'.
	module declareClassNamed: #Object.
	
	self assert: (module definesName: #Object)