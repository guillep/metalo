module-loading
testLoadModuleIsNotBound

	| rPackage loadedNetworkModule dependentClassNames |
	rPackage := RPackageOrganizer default packageNamed: 'Network-Kernel'.
	loadedNetworkModule := MLModule loadRPackage: rPackage.
	
	dependentClassNames := (MLBootstrap computePackageDependenciesOfPackageNamed: rPackage name) asDictionary values flatCollect: #yourself.
	loadedNetworkModule undeclaredNames includesAll: dependentClassNames.