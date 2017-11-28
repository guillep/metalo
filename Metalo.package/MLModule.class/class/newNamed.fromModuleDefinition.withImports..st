instance creation - from RPackage
newNamed: aName fromModuleDefinition: aModuleDefinition withImports: importsCollection
	"Module definitions and RPackages are polymorphic so far"

	^ self
		newNamed: aName
		fromModuleDefinition: aModuleDefinition
		withModuleVariableNames: #()
		withImports: importsCollection