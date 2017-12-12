test-import
testDeclareClassWithSameNameThanAlreadyImportedNameFails
	
	self should: [ module declareClassNamed: self importedName ] raise: Error