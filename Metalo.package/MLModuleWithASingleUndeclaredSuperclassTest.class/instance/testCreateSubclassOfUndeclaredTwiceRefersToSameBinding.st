test-undeclareds
testCreateSubclassOfUndeclaredTwiceRefersToSameBinding

	| undeclaredBinding2 |
	
	module declareClassNamed: #Color subclassOfClassNamed: self undeclaredName.
	undeclaredBinding2 := module undeclaredBindings associationAt: self undeclaredName.
	
	self assert: undeclaredBinding ==  undeclaredBinding2
	