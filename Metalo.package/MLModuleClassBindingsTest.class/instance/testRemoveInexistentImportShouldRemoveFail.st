test-import
testRemoveInexistentImportShouldRemoveFail

	| module |
	module := MLModule newNamed: 'myModule'.
		
	self should: [ module removeImport: #Object from: #Kernel ] raise: NotFound