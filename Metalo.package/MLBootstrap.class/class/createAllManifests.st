manifest generation
createAllManifests
	"[self createAllManifests] fork"
	
	[RPackageOrganizer default packageNamesDo: [ :packageName |
		Transcript crShow: packageName. 
		self createModuleManifestForPackageNamed: packageName ]
	 ] on: Warning do: [ :ex | ex resume ]


