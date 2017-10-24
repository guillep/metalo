test-undeclareds
testCreateSubclassOfUndeclaredTwiceRefersToSameBinding

	| module pointClass colorClass undeclaredBinding undeclaredBinding2 |	
	module := MLModule newNamed: 'myModule'.
	
	"We create a subclass of an undefined class. This triggers the creation of an undefined #Object class local to the module."
	pointClass := module declareClassNamed: #Point subclassOfClassNamed: #Object.
	undeclaredBinding := module undeclaredBindings associationAt: #Object.
	
	colorClass := module declareClassNamed: #Color subclassOfClassNamed: #Object.
	undeclaredBinding2 := module undeclaredBindings associationAt: #Object.
	
	self assert: undeclaredBinding ==  undeclaredBinding2
	