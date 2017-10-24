test-undeclareds
testCreateSubclassOfUndeclaredTwice

	| module pointClass colorClass |	
	module := MLModule newNamed: 'myModule'.
	
	"We create a subclass of an undefined class. This triggers the creation of an undefined #Object class local to the module."
	pointClass := module declareClassNamed: #Point subclassOfClassNamed: #Object.
	colorClass := module declareClassNamed: #Color subclassOfClassNamed: #Object.
	
	self assert: pointClass superclass equals: colorClass superclass.
	self assert:  module undeclaredBindings size equals: 1.
		
	