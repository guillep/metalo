instance-creation
loadRPackageNamed: rpackageName

	^ self
		loadRPackage: (RPackageOrganizer default packageNamed: rpackageName)
		withImportDeclarations: #()