class creation
basicCreateUndefinedClassNamed: aClassName
	
	^ self
		basicCreateClass: (MCClassDefinition
			name: aClassName
			superclassName: nil
			category: 'no category'
			instVarNames: #( )
			comment: 'no comments')
		superclass: UndefinedClass