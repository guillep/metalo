notifications
classAdded: aClass inCategory: aCategory

	aClass superclass == UndefinedClass 
		ifTrue: [ environment declareUndeclaredBinding:  aClass name with: aClass ]
		ifFalse: [ 
				" Install the new class in the system "
				environment at: aClass name put: aClass ].
	
	aClass environment: environment.

	" Inform superclass of new subclass "
	aClass superclass addSubclass: aClass.