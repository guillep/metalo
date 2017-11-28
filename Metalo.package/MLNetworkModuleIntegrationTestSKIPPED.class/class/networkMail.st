examples
networkMail
	<sampleInstance>
	^ MLModule
		loadRPackageNamed: 'Network-Mail'
		withImportDeclarations:  MLNetworkMailMetaloManifestMock new imports 