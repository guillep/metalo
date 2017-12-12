test-undeclareds
testImportUndeclaredNameRemovesUndeclared	
	"We import a name that conflicts with the undefined class name.
	Explicit imports resolve undeclared names."
	| import |
	import := module declareImport: self undeclaredName from: #Kernel.

	"The superclass of Point should still point to an undefined class.
	The imported name points to the undefined class."	
	self assert: import binding value == undeclaredBinding value.
	self assert: import binding value == definedClass superclass.
	
	self assert: module undeclaredNames isEmpty.