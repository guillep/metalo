module-loading
testCreateModuleFromRPackageWithDependencyAnalyzerImports
	
	| loadedSystemSupportRulesModule |
	
	loadedSystemSupportRulesModule := MLModule loadRPackageNamed: 'System-Support-Rules'.
	
	self deny: (loadedSystemSupportRulesModule hasImportNamed: #MLModule).
	self assert: loadedSystemSupportRulesModule undeclaredNames isEmpty.
	
	#( AsClassRule ManifestSystemSupportRules ) do: [ :aClassName |
		loadedSystemSupportRulesModule  definesClassNamed:  aClassName ].

	#( PackageManifest ReNodeRewriteRule ) do: [ :notDefinedName |
		loadedSystemSupportRulesModule  hasImportNamed:  notDefinedName ].
	