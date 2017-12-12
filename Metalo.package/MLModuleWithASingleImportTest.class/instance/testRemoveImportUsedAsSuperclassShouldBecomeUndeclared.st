test-import
testRemoveImportUsedAsSuperclassShouldBecomeUndeclared
	| point |
	point := module
		declareClassNamed: #Point
		subclassOfClassNamed: self importedName.
	self removeImport.
	self assert: module imports isEmpty.
	self assert: (module undeclaredNames includes: self importedName).
	self assert: module undeclaredBindings anyOne value == point superclass