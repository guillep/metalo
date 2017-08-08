class creation
assertClassNotDeclared: aName

	(classBindings includesKey: aName)
		ifTrue: [ :each |
			self error: ('Cannot declare name {1}: {1} is already declared as a class'
				format: { aName }) ].