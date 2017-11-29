module-loading
testCreateModuleFromRPackageWithDependencyAnalyzerImports
	
	| loadedSystemSupportRulesModule |
	
	loadedSystemSupportRulesModule := MLModule loadRPackageNamed: 'System-Support-Rules'.
	
	self deny: (loadedSystemSupportRulesModule hasImportNamed: #MLModule).
	self assert: loadedSystemSupportRulesModule undeclaredNames isEmpty.
	
	#( AsClassRule ) do: [ :aClassName |
		self assert: (loadedSystemSupportRulesModule  definesClassNamed:  aClassName) ].

	#( ReNodeRewriteRule ) do: [ :notDefinedName |
		self assert: (loadedSystemSupportRulesModule  hasImportNamed:  notDefinedName) ].
	
	