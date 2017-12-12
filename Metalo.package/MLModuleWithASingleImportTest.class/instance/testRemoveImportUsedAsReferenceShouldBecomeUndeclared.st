test-import
testRemoveImportUsedAsReferenceShouldBecomeUndeclared

	|  point |
		
	point := module declareClassNamed: #Point.
	module compileMethod: 'test ^', self importedName inClass: point.
	
	self assert: (point >> #test) literals first == import binding.
	
	self removeImport.
	
	self assert: module imports isEmpty.
	self assert: (module undeclaredNames includes: self importedName).
	self assert: (point >> #test) literals first == module undeclaredBindings associations anyOne.