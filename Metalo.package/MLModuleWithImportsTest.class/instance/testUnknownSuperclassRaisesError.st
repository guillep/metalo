tests
testUnknownSuperclassRaisesError

	| module gotError |
	module := MLImportingModule new.
	
	[ module createClass: (
			MLClassDefinition new
				name: 'Mock';
				superclassName: 'Unknown')]
		on: MLUnknownName
		do: [ :err | gotError := err ].
		
	self assert: gotError undefinedName equals: 'Unknown'.