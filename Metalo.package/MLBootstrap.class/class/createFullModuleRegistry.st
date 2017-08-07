create module registry
createFullModuleRegistry
	"self createFullModuleRegistry"
	
	| fullRegistry |
	fullRegistry := MLModuleRegistry new.
	
	RPackageOrganizer default packageNamesDo: [  :packageName |  
		fullRegistry at: packageName put:  Smalltalk globals ].
	
	RPackageOrganizer default packageNamesDo: [  :packageName |  
		packageName = #Kernel ifFalse: [ 
			fullRegistry at: packageName put:  ((self newNamed: packageName) createModuleBoundTo: fullRegistry).
			Transcript crShow: packageName
			] ].

	^ fullRegistry