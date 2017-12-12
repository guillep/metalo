class creation
declareClass: aClassDefinition
	
	| classCreated |
	self assertVariableNotDeclared: aClassDefinition className.
	self assertNameNotImported: aClassDefinition className.

	classCreated := self basicCreateClass: aClassDefinition.
	
	self at: aClassDefinition className put: classCreated.
	classCreated environment: self.
	classCreated superclass addSubclass: classCreated.

	^ classCreated