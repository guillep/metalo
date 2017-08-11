class creation
assertNameNotLocallyDeclared: aName

	self locallyDeclaredNames
		at: aName
		ifPresent: [ :each |
			self error: ('Cannot declare name {1}: {1} is already locally declared'
				format: { aName }) ].