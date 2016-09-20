instance-creation
newNamed: aName fromRPackage: anRPackage	
	"
	MLMetaModule newNamed: 'Network' fromRPackage: (RPackage organizer packageNamed: 'Network-Kernel')
	"
	
	^ self newNamed: aName fromRPackage: anRPackage withImports: #()