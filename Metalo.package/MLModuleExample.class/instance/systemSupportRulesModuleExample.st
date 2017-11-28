examples
systemSupportRulesModuleExample

	| renrakuModule registry ssr |
	renrakuModule := MLModule newNamed: 'Renraku'.
	
	registry := MLModuleRegistry new.
	registry at:  #Renraku put: renrakuModule.

	ssr := MLModule loadRPackageNamed: 'System-Support-Rules'.
	registry at:  #SSR put: ssr.

	^ registry