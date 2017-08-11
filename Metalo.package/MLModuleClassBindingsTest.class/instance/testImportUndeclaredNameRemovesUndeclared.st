test-undeclareds
testImportUndeclaredNameRemovesUndeclared

	"Undeclared => Import"
	| module pointClass import undeclaredBinding |	
	module := MLModule newNamed: 'myModule'.
	
	"We create a subclass of an undefined class. This triggers the creation of an undefined #Object class local to the module."
	pointClass := module declareClassNamed: #Point subclassOfClassNamed: #Object.
	undeclaredBinding := module undeclaredBindings anyOne.
	
	"We import a name that conflicts with the undefined class name.
	Explicit imports resolve undeclared names."
	import := module import: #Object from: #Kernel.

	"The superclass of Point should still point to an undefined class.
	The imported name points to the undefined class."	
	self assert: import binding value == undeclaredBinding value.
	self assert: import binding value == pointClass superclass.
	
	self assert: module undeclaredNames isEmpty.