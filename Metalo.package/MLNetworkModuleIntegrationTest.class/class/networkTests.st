examples
networkTests
	<sampleInstance>
	^ MLModule
		loadRPackageNamed: 'Network-Tests'
		withImportDeclarations: MLNetworkTestsMetaloManifestMock new imports