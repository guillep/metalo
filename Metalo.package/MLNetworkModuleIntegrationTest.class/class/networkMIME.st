examples
networkMIME
	<sampleInstance>
	^ MLModule
		loadRPackageNamed: 'Network-MIME'
		withImportDeclarations:  MLNetworkMIMEMetaloManifestMock new imports 