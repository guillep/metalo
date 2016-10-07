running
setUp

	| moduleRegistry |
	super setUp.
	
	moduleRegistry := MLModuleRegistry default.
	networkModule := MLModuleDefinition network createModuleBoundTo: moduleRegistry