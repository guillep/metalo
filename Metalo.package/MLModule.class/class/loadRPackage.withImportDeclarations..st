instance creation - from RPackage
loadRPackage: anRPackage withImportDeclarations: imports

	| module |
	module := self newNamed: (self packageToModuleName: anRPackage name).
	
	imports keysAndValuesDo: [ :anRPackageName :aCollectionOfClassNames |
		aCollectionOfClassNames do: [ :aNameToImport |
			module declareImport: aNameToImport from: anRPackageName ] ].
		
	MLRPackageLoader new
		rpackage: anRPackage;
		module: module;
		load.
	^ module