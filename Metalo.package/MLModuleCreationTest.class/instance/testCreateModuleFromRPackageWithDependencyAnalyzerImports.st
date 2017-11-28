module-loading
testCreateModuleFromRPackageWithDependencyAnalyzerImports
	
	| loadedSystemSupportRulesModule |
	
	loadedSystemSupportRulesModule := MLModule loadRPackageNamed: 'System-Support-Rules'.
	
	self deny: (loadedSystemSupportRulesModule hasImportNamed: #MLModule).
	loadedSystemSupportRulesModule undeclaredNames isEmpty.