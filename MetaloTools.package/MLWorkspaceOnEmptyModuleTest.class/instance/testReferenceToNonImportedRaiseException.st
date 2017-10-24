tests
testReferenceToNonImportedRaiseException

	self should: [ (workspace evaluate: 'Point') ] raise: Exception