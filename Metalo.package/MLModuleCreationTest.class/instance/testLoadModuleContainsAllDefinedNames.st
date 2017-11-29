module-loading
testLoadModuleContainsAllDefinedNames

	| rPackage loadedNetworkModule |
	rPackage := RPackageOrganizer default packageNamed: 'Network-Kernel'.
	loadedNetworkModule := MLModule loadRPackage: rPackage.
	
	rPackage definedClassNames do: [ :className | 
		self assert: (loadedNetworkModule includesName: className) ]