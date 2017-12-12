test-undeclareds
testDeclareModuleVariableForUndeclaredNameRemovesUndeclared
	
	
	"We declare a name that conflicts with the undefined class name.
	Explicit declarations resolve undeclared bindings."
	| binding |
	binding := module declareVariableNamed: self undeclaredName.

	"The superclass of Point should still point to an undefined class.
	The imported name points to the undefined class."	
	self assert: binding value == undeclaredBinding value.
	self assert: binding value == definedClass superclass.
	
	self assert: module undeclaredNames isEmpty.