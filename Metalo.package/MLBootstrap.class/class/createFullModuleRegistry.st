public API
createFullModuleRegistry	
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
	rPackagesToModularize do: [  :packageName |  
				fullRegistry at: packageName put:  (MLModule loadRPackageNamed: packageName).
				Transcript crShow: packageName
	] .

	^ fullRegistry