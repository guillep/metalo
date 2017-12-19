class creation
declareClass: aClassDefinition
	
	| newClass |
	self assertVariableNotDeclared: aClassDefinition className.
	self assertNameNotImported: aClassDefinition className.

	newClass := self basicCreateClass: aClassDefinition inEnvironment: classBindings.
	self undeclaredBindings removeKey: aClassDefinition className ifAbsent: [].
	^ newClass