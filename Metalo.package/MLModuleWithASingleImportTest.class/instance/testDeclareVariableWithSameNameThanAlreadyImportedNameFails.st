test-import
testDeclareVariableWithSameNameThanAlreadyImportedNameFails
	
	self should: [ module declareVariableNamed: self importedName ] raise: Error