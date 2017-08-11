test-undeclareds
testUndefinedSuperclassCreatesUndeclaredBinding

	| module |
	module := MLModule newNamed: 'myModule'.
	
	"We create an undefined class named #Object as a stub for Point's supeclass.
	However, no binding is created for this undefined class.
	It is private to the module and cannot be imported."
	module declareClassNamed: #Point subclassOfClassNamed: #Object.
	
	self deny: (module definesName: #Object)