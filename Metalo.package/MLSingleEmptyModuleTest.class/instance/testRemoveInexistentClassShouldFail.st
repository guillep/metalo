tests-declaredClasses
testRemoveInexistentClassShouldFail

	self should: [module removeClassNamed: #Point ] raise: NotFound