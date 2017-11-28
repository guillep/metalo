instance creation - from RPackage
loadRPackage: anRPackage

	| dependencies |
	
	dependencies := MLBootstrap computePackageDependenciesOfPackageNamed: anRPackage packageName.
	
	^ self loadRPackage: anRPackage withImportDeclarations: dependencies