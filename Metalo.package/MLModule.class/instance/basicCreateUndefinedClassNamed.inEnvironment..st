class creation
basicCreateUndefinedClassNamed: aClassName inEnvironment: anInstallingEnvironment
	
	^ self
		basicCreateClass: (MCClassDefinition
			name: aClassName
			superclassName: nil
			category: 'no category'
			instVarNames: #( )
			comment: 'no comments')
		superclass: UndefinedClass
		inEnvironment: anInstallingEnvironment