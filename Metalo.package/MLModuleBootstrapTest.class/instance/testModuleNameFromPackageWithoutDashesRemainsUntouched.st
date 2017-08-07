tests
testModuleNameFromPackageWithoutDashesRemainsUntouched
	| packageName |
	packageName := #'NetworkKernel'.
	self assert: (MLBootstrap moduleNameForPackageName: packageName) equals: #'NetworkKernel'