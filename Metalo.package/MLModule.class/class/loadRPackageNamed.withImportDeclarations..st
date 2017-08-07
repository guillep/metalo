instance-creation
loadRPackageNamed: rpackageName withImportDeclarations: imports

	^ self loadRPackage: (RPackageOrganizer default packageNamed: rpackageName) withImportDeclarations: imports