test-undeclareds
testUndefinedSuperclassCreatesUndeclaredBinding
	
	"We create an undefined class named #Object as a stub for Point's superclass.
	However, no binding is created for this undefined class.
	It is private to the module and cannot be imported."
	module declareClassNamed: self definedClassName subclassOfClassNamed: self undeclaredName.
	
	self assert: (module undeclaredNames includes: self undeclaredName).
	self deny: (module definesName: self undeclaredName)