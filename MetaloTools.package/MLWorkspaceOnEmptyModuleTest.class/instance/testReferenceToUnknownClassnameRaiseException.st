tests
testReferenceToUnknownClassnameRaiseException

	self should: [ (workspace evaluate: 'Point') ] raise: MLUnknownClassError