test-undeclareds
testDeclareModuleVariableForUndeclaredNameRemovesUndeclared

	"Undeclared => Import"
	| module pointClass undeclaredBinding binding |	
	module := MLModule newNamed: 'myModule'.
	
	"We create a subclass of an undefined class. This triggers the creation of an undefined #Object class local to the module."
	pointClass := module declareClassNamed: #Point subclassOfClassNamed: #Object.
	undeclaredBinding := module undeclaredBindings anyOne.
	
	"We declare a name that conflicts with the undefined class name.
	Explicit declarations resolve undeclared bindings."
	binding := module declareVariableNamed: #Object.

	"The superclass of Point should still point to an undefined class.
	The imported name points to the undefined class."	
	self assert: binding value == undeclaredBinding value.
	self assert: binding value == pointClass superclass.
	
	self assert: module undeclaredNames isEmpty.