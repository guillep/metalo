class creation
assertVariableNotDeclared: aName

	(variableBindings includesKey: aName)
		ifTrue: [ :each |
			self error: ('Cannot declare name {1}: {1} is already declared as a variable'
				format: { aName }) ].