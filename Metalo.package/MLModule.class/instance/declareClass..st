class creation
declareClass: aClassDefinition
	
	| classCreated |
	self assertVariableNotDeclared: aClassDefinition className.
	self assertNameNotImported: aClassDefinition className.
	
	classCreated := self basicCreateClass: aClassDefinition.
	^ classCreated