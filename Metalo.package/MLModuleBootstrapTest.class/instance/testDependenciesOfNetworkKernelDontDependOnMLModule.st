tests
testDependenciesOfNetworkKernelDontDependOnMLModule
	| dependenciesDict packageName |
	packageName := #'Network-Kernel'.
	dependenciesDict := MLBootstrap
		computePackageDependenciesOfPackageNamed: packageName.
	self deny: (dependenciesDict includesKey: #Metalo).
	
