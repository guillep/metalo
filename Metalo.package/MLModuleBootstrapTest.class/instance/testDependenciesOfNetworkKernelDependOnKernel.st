tests
testDependenciesOfNetworkKernelDependOnKernel
	| dependenciesDict packageName |
	packageName := #'Network-Kernel'.
	dependenciesDict := MLBootstrap
		computePackageDependenciesOfPackageNamed: packageName.
	self assert: (dependenciesDict includesKey: #Kernel).
	
