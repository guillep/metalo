tests
testImportsOfNetworkKernelDoNotIncludeDashes
	| packageName importsDictionary |
	packageName := #'Network-Kernel'.
	importsDictionary := MLBootstrap computeModuleImportsOfPackageNamed: packageName.
	
	importsDictionary keysDo: [ :moduleName | 
		self deny: (moduleName includes: $-) ]