instance creation - from RPackage
loadRPackageNamed: rPackageName 
		
	| rPackage |
	rPackage := RPackageOrganizer default packageNamed: rPackageName.
	
	^ self loadRPackage: rPackage 