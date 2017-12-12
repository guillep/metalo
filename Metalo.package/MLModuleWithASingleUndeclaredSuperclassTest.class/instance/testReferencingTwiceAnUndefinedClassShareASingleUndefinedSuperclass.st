test-undeclareds
testReferencingTwiceAnUndefinedClassShareASingleUndefinedSuperclass

	"We create an undefined class named #Object as a stub for Point's supeclass.
	However, no binding is created for this undefined class.
	It is private to the module and cannot be imported."
	| pointClass2  |
	pointClass2 := module declareClassNamed: #Point2 subclassOfClassNamed: self undeclaredName.
	
	self assert: definedClass superclass == pointClass2 superclass