tests-name invariants
testAllClassSuperclassesAreResolvedInModule

	networkModule classes do: [ :class |
		self assert: (networkModule resolveName: class superclass name) equals: class superclass. ]