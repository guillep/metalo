instance-creation
newNamed: aName fromModuleDefinition: aModuleDefinition withImports: importsCollection
	
	"Module definitions and RPackages are polymorphic so far"
	^ self newNamed: aName fromRPackage: aModuleDefinition withImports: importsCollection