class creation
declareClassNamed: aClassName
	
	^ self declareClassNamed: aClassName subclassOfClassNamed: nil
