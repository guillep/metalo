as yet unclassified
loadRPackageNamed: rPackageName 
		
	| rPackage |
	rPackage := RPackageOrganizer default packageNamed: rPackageName.
	
	^ self loadRPackage: rPackage 