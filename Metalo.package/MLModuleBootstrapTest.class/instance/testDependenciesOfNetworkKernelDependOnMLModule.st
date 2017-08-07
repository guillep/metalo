tests
testDependenciesOfNetworkKernelDependOnMLModule
	| dependenciesDict packageName |
	packageName := #'Network-Kernel'.
	dependenciesDict := MLBootstrap
		computePackageDependenciesOfPackageNamed: packageName.
	self assert: (dependenciesDict includesKey: #Metalo).
	self assert: ((dependenciesDict at: #Metalo) includes: #MLModule).
	
