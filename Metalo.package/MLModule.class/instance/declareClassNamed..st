class creation
declareClassNamed: aClassName
	
	^ self declareClass: (MCClassDefinition
		name: aClassName
		superclassName: nil
		category: 'no category'
		instVarNames: #( )
		comment: 'no comments').