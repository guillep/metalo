examples
networkCore
	<sampleInstance>
	^ MLModule
		loadRPackageNamed: 'Network-Kernel'
		withImportDeclarations: MLNetworkKernelMetaloManifestMock new imports