test-import
testRemoveInexistentImportShouldFail

	self should: [ module removeImport: #Object from: #Kernel ] raise: NotFound