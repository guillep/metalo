as yet unclassified
testAllClassSuperclassesAreResolvedInModule

	module classes do: [ :class |
		self assert: (module resolveName: class superclass name) equals: class superclass. ]