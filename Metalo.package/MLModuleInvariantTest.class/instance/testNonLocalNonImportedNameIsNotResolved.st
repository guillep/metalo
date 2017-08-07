tests-name invariants
testNonLocalNonImportedNameIsNotResolved

	self assert: (Smalltalk globals includesKey: #Point).
	self should: [networkModule resolveDeclaredBinding: #Point] raise: Error