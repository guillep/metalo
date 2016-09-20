as yet unclassified
testNonLocalNonImportedNameIsNotResolved

	self assert: (Smalltalk globals includesKey: #Point).
	self should: [module resolveName: #Point] raise: Error