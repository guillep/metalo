tests-name invariants
testClassInsideModuleIsDifferentFromClassOutsideModule

	self deny: (module resolveName: #HTTPProgress) == HTTPProgress