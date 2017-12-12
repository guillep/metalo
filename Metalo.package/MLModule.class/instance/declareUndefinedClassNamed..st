class creation
declareUndefinedClassNamed: aClassName
	
	| classCreated |
	self assertVariableNotDeclared: aClassName.
	self assertNameNotImported: aClassName.
	self assertNameNotLocallyDeclared: aClassName.
	
	classCreated := self basicCreateUndefinedClassNamed: aClassName.
	
	undeclaredBindings add: (MLUndeclaredBinding key: aClassName value: classCreated).
	classCreated environment: self.
	classCreated superclass addSubclass: classCreated.
	
	^ classCreated