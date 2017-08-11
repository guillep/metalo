as yet unclassified
assertNameNotImported: aName

	self imports
		detect: [ :each | each importedName = aName ]
		ifFound: [ :each |
			self error: ('Cannot declare name {1}: {1} is already imported from {2}'
				format: { aName . each moduleName }) ].