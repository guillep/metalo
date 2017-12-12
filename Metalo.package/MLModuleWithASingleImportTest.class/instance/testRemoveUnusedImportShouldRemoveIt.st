test-import
testRemoveUnusedImportShouldRemoveIt

	self removeImport.
	
	self assert: module imports isEmpty.
	self assert: module undeclaredNames isEmpty.