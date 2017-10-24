asserting
assertClassNotDeclared: aName

	(classBindings includesKey: aName)
		ifTrue: [
			self error: ('Cannot declare name {1}: {1} is already declared as a class'
				format: { aName }) ].