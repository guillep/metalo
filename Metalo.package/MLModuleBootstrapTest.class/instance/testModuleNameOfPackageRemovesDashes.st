tests
testModuleNameOfPackageRemovesDashes
	| packageName |
	packageName := #'Network-Kernel'.
	self assert: (MLBootstrap moduleNameForPackageName: packageName) equals: #'NetworkKernel'
