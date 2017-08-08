class creation
declareClassNamed: aClassName subclassOf: aSuperclassName
	
	| classCreated |
	
	self assertVariableNotDeclared: aClassName.
	self assertNameNotImported: aClassName.
	
	classCreated := self
		basicCreateClassNamed: aClassName
		subclassOf: aSuperclassName.

	self at: aClassName put: classCreated.
	^ classCreated