module-loading
testCreateModuleFromRPackageWithDependencyAnalyzerImports

	| rPackage loadedSystemSupportRulesModule rPackageName packageDependenciesClass |
	rPackageName := 'System-Support-Rules'.
	rPackage := RPackageOrganizer default packageNamed: rPackageName.

	MLBootstrap createModuleManifestForPackageNamed: rPackageName.
	
	packageDependenciesClass := Smalltalk globals at: (MLBootstrap manifestNameForPackageName: rPackageName) asSymbol.
	
	loadedSystemSupportRulesModule := MLModule loadRPackage: rPackage withImportDeclarations: packageDependenciesClass new imports.
	
	self deny: (loadedSystemSupportRulesModule hasImportNamed: #MLModule).
	loadedSystemSupportRulesModule undeclaredNames isEmpty.