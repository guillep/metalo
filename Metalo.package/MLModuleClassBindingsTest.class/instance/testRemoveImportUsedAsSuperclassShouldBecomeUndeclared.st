test-import
testRemoveImportUsedAsSuperclassShouldBecomeUndeclared

	| module point |
	module := MLModule newNamed: 'myModule'.
	module import: #Object from: #Kernel.
	point := module declareClassNamed: #Point subclassOf: #Object.

	module removeImport: #Object from: #Kernel.
	
	self assert: module imports isEmpty.
	self assert: (module undeclaredNames includes: #Object).
	self assert: (module undeclaredBindings anyOne value == point superclass).