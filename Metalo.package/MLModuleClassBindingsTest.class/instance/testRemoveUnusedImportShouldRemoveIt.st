test-import
testRemoveUnusedImportShouldRemoveIt

	| module |
	module := MLModule newNamed: 'myModule'.
	module import: #Object from: #Kernel.

	module removeImport: #Object from: #Kernel.
	
	self assert: module imports isEmpty.
	self assert: module undeclaredNames isEmpty.