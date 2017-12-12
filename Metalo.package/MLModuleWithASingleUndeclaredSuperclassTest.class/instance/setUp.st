running
setUp

	super setUp.

	"We create a subclass of an undefined class. This triggers the creation of an undefined #Object class local to the module."
	definedClass := module declareClassNamed: self definedClassName subclassOfClassNamed: self undeclaredName.
	undeclaredBinding := module undeclaredBindings associationAt: self undeclaredName.
