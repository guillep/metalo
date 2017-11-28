dependencies computing
computePackageToGlobalDependencies
	| global allGlobals globalUsersDict |
	
	PackageDependenciesDict ifNil: [ 
	allGlobals := Smalltalk globals keys
		reject: [ :k | 
			global := Smalltalk globals at: k.
			global isClassOrTrait and: [ global name = k ] ].
	globalUsersDict := Dictionary new.
	allGlobals
		do: [ :globalName | 
			globalUsersDict
				at: globalName
				put: ((SystemNavigation default allReferencesTo: (Smalltalk bindingOf: globalName)) collect: [ :meth | meth package name asSymbol ]) asSet ].
	PackageDependenciesDict := Dictionary new.
	globalUsersDict
		keysAndValuesDo: [ :k :v | v do: [ :packageName | (PackageDependenciesDict at: packageName ifAbsentPut: [ OrderedCollection new ]) add: k ] ].
	].

	^ PackageDependenciesDict  