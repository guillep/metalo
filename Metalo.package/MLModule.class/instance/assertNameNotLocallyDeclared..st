class creation
assertNameNotLocallyDeclared: aName

	self locallyDeclaredNames
		detect: [ :each | each name = aName ]
		ifFound: [ :each |
			self error: ('Cannot declare name {1}: {1} is already locally declared'
				format: { aName }) ].