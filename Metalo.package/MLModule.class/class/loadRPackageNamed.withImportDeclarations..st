as yet unclassified
loadRPackageNamed: rpackageName withImportDeclarations: imports

	^ self loadRPackage: (RPackageOrganizer default packageNamed: rpackageName) withImportDeclarations: imports