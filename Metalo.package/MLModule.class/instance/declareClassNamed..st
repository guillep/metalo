class creation
declareClassNamed: aClassName
	
	^ self
		declareClassNamed: aClassName
		subclassOf: nil