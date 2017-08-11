class creation
declareClassNamed: aClassName subclassOfClassNamed: aSuperclassName
	
	| classCreated |
	
	self assertVariableNotDeclared: aClassName.
	self assertNameNotImported: aClassName.
	
	classCreated := self
		basicCreateClassNamed: aClassName
		subclassOfClassNamed: aSuperclassName.

	self at: aClassName put: classCreated.
	^ classCreated