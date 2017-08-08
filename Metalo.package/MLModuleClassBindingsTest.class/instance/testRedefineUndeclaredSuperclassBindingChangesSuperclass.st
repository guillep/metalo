test-undeclareds
testRedefineUndeclaredSuperclassBindingChangesSuperclass

	| module |
	module := MLModule newNamed: 'myModule'.
	module declareClassNamed: #Point subclassOf: #Object.
	
	"We create a class #Object.
	Creating a class defines the name #Object in the module.
	This overrides the undeclared"
	module declareClassNamed: #Object.
	
	self assert: module undeclaredNames isEmpty.
	self assert: (module at: #Point) superclass equals: (module at: #Object)