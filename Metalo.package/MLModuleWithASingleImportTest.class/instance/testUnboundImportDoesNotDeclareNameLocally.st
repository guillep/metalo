test-import
testUnboundImportDoesNotDeclareNameLocally
	
	"An import does not declare a name in the module"
	self deny: (module definesName: self importedName)