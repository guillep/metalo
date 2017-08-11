test-undeclareds
testReferencingTwiceAnUndefinedClassShareASingleUndefinedSuperclass

	| module point point2 |
	module := MLModule newNamed: 'myModule'.
	
	"We create an undefined class named #Object as a stub for Point's supeclass.
	However, no binding is created for this undefined class.
	It is private to the module and cannot be imported."
	point := module declareClassNamed: #Point subclassOfClassNamed: #Object.
	point2 := module declareClassNamed: #Point2 subclassOfClassNamed: #Object.
	
	self assert: point superclass == point2 superclass