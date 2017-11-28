testing
shouldBeActivatedInContext: aBrowserContext

	^aBrowserContext selectedPackages size >= 1 and: [ aBrowserContext lastSelectedPackage isKindOf: MLModule  ]