test-undeclareds
testRedefineUndeclaredSuperclassBindingChangesSuperclass

	| module |
	module := MLModule newNamed: 'myModule'.
	module declareClassNamed: #Point subclassOfClassNamed: #Object.
	
	"We create a class #Object.
	Creating a class defines the name #Object in the module.
	This overrides the undeclared"
	module declareClassNamed: #Object.
	
	self assert: module undeclaredNames isEmpty.
	self assert: (module classNamed: #Point) superclass equals: (module classNamed: #Object)