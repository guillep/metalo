tests-name invariants
testNonLocalNonImportedNameIsNotResolved

	self assert: (Smalltalk globals includesKey: #Point).
	self should: [module resolveName: #Point] raise: Error