test-import
testImportAlreadyImportedNameFromSameModuleIsIgnored
	self declareImport.
	self assert: module imports size equals: 1