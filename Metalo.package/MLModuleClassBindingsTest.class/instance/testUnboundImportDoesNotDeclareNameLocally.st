test-import
testUnboundImportDoesNotDeclareNameLocally

	| module |
	module := MLModule newNamed: 'myModule'.
	module declareImport: #Object from: #Kernel.
	
	"An import does not declare a name in the module"
	self deny: (module definesName: #Object)