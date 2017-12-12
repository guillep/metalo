tests
testCreateClassInModuleDefinesClass

	self assert: (module classNamed: self definedClassName) isClass