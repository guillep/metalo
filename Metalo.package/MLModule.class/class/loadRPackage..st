as yet unclassified
loadRPackage: anRPackage

	| dependencies |
	
	dependencies := MLBootstrap computePackageDependenciesOfPackageNamed: anRPackage packageName.
	
	^ self loadRPackage: anRPackage withImportDeclarations: dependencies