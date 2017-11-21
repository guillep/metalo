create module registry
createFullModuleRegistry
	"self createFullModuleRegistry"
	
	| fullRegistry |
	fullRegistry := MLModuleRegistry new.
	
	RPackageOrganizer default packageNamesDo: [  :packageName |  
		fullRegistry at: packageName put:  Smalltalk globals ].
	
	Transcript clear.
	RPackageOrganizer default packagesDo: [  :package |  
		((package packageName = #Kernel) or: [ package packageName = #_UnpackagedPackage ]) ifFalse: [ 
			Smalltalk globals at: (MLBootstrap manifestNameForPackageName: package name) ifPresent: [ :packageDependenciesClass |
				fullRegistry at: package packageName put:  (MLModule loadRPackage: package withImportDeclarations: packageDependenciesClass new imports).
				Transcript crShow: package packageName
			]
			] ].

	^ fullRegistry