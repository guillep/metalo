tests-name invariants
testClassInsideModuleIsDifferentFromClassOutsideModule

	self deny: (networkModule resolveName: #HTTPProgress) == HTTPProgress