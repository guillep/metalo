test-import
testImportAlreadyImportedNameFromDifferentModuleFails

	self
		should: [ module declareImport: self importedName from: #Kernel2 ]
		raise: Error