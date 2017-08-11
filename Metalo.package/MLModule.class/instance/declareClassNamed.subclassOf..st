class creation
declareClassNamed: aClassName subclassOf: aSuperclass
	
	| classCreated |
	
	self assertVariableNotDeclared: aClassName.
	self assertNameNotImported: aClassName.
	
	classCreated := self
		basicCreateClassNamed: aClassName
		subclassOfClass: aSuperclass.

	self at: aClassName put: classCreated.
	^ classCreated