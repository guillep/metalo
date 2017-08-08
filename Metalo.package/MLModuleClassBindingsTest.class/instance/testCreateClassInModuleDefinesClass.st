test-class bindings
testCreateClassInModuleDefinesClass

	| module |
	module := MLModule newNamed: 'myModule'.
	module declareClassNamed: #Object.
	
	self assert: (module at: #Object) isClass