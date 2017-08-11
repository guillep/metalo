tests-declaredClasses
testRemoveInexistentClassShouldFail

	| module |
	module := MLModule newNamed: 'myModule'.
	
	self should: [module removeClassNamed: #Point ] raise: NotFound