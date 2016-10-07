accessing
definedMethodsForClass: aClass 
	
	^ (rPackages detect: [ :p | p includesClassNamed: aClass theNonMetaClass name ])
		definedMethodsForClass: aClass