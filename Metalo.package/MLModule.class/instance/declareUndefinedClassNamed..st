class creation
declareUndefinedClassNamed: aClassName
	
	^ self
		basicCreateClass: (MCClassDefinition
			name: aClassName
			superclassName: nil
			category: 'no category'
			instVarNames: #( )
			comment: 'no comments')
		superclass: UndefinedClass