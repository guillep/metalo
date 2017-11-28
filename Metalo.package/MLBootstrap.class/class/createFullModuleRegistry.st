create module registry
createFullModuleRegistry
	"suppose that MetaloManifest have been created"
	"self createAllManifests"
	
	"self createFullModuleRegistry"
	
	| fullRegistry rPackagesToModularize |
	
	fullRegistry := MLModuleRegistry new.
	
	rPackagesToModularize := RPackageOrganizer default packageNames asOrderedCollection.
	rPackagesToModularize 
		remove: #Kernel ;  "because duplicating Kernel classes may be a problem"
		remove: #_UnpackagedPackage. "because we do not know what is inside"
	
	(rPackagesToModularize, #Kernel) do: [  :packageName |  
		fullRegistry at: packageName put:  Smalltalk globals ].
	
	Transcript clear.
	rPackagesToModularize do: [  :package |  
			Smalltalk globals at: (MLBootstrap manifestNameForPackageName: package name) ifPresent: [ :packageDependenciesClass |
				
				fullRegistry at: package packageName put:  (MLModule loadRPackage: package withImportDeclarations: packageDependenciesClass new imports).
				Transcript crShow: package packageName
			]
	] .

	^ fullRegistry