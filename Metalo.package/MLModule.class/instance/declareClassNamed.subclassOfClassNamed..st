class creation
declareClassNamed: aClassName subclassOfClassNamed: aSuperclassName
	
	
	^ self declareClass: (MCClassDefinition
			name: aClassName
			superclassName: aSuperclassName
			category: 'no category'
			instVarNames: #( )
			comment: 'no comments').