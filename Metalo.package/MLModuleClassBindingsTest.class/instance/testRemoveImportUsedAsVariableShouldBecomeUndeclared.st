test-import
testRemoveImportUsedAsVariableShouldBecomeUndeclared

	| module point import |
	module := MLModule newNamed: 'myModule'.
	import := module import: #Object from: #Kernel.
	
	point := module declareClassNamed: #Point.
	module compileMethod: 'test ^Object' inClass: point.
	
	self assert: (point >> #test) literals first == import binding.
	
	module removeImport: #Object from: #Kernel.
	
	self assert: module imports isEmpty.
	self assert: (module undeclaredNames includes: #Object).
	self assert: (point >> #test) literals first == module undeclaredBindings associations anyOne.