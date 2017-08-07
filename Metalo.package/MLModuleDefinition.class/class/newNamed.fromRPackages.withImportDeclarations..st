instance creation
newNamed: aModuleName fromRPackages: anRPackageCollection withImportDeclarations: arrayOfImports
	^ self
		newNamed: aModuleName
		fromRPackages: anRPackageCollection
		withModuleVariablesNamed: #()
		withImportDeclarations: arrayOfImports