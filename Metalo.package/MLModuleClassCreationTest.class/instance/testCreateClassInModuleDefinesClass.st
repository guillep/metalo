tests
testCreateClassInModuleDefinesClass

	| module |
	module := MLModule newNamed: 'myModule'.
	module createClassNamed: #Object.
	
	self assert: (module at: #Object) isClass