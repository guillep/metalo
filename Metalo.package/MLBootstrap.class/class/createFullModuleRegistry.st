public API
createFullModuleRegistry	
	"self createFullModuleRegistry"
	
	| rPackagesToModularize |
	
	FullModuleRegistry := MLModuleRegistry new.
	
	rPackagesToModularize := RPackageOrganizer default packageNames asOrderedCollection.
	rPackagesToModularize 
		remove: #Kernel ;  "because duplicating Kernel classes may be a problem"
		remove: #_UnpackagedPackage. "because we do not know what is inside"
	
	(rPackagesToModularize, #Kernel) do: [  :packageName |  
		FullModuleRegistry at: packageName put:  Smalltalk globals ].
	
	Transcript clear.
	rPackagesToModularize do: [  :packageName |  
				FullModuleRegistry at: packageName put:  (MLModule loadRPackageNamed: packageName).
				Transcript crShow: packageName
	] .

	^ FullModuleRegistry