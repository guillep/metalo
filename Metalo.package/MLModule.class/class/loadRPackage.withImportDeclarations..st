instance-creation
loadRPackage: anRPackage withImportDeclarations: imports

	| module |
	module := self newNamed: (self packageToModuleName: anRPackage name).
	
	imports do: [ :importPerModule | | moduleName namesToImport |
		moduleName := importPerModule key.
		namesToImport := importPerModule value.
		namesToImport do: [ :aNameToImport |
			module declareImport: aNameToImport from: moduleName ] ].
	
	MLRPackageLoader new
		rpackage: anRPackage;
		module: module;
		load.
	^ module