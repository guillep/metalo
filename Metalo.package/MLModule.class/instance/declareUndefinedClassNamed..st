class creation
declareUndefinedClassNamed: aClassName
	
	^ self
		declareClassNamed: aClassName
		subclassOf: UndefinedClass