manifest generation
createManifestClassForPackageNamed: aPackageName
	| manifestClassName |
	manifestClassName := self manifestNameForPackageName: aPackageName.
	^ Object
		subclass: manifestClassName
		instanceVariableNames: ''
		classVariableNames: ''
		package: aPackageName asSymbol