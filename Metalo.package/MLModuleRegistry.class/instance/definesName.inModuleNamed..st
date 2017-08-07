testing
definesName: aName inModuleNamed: aModuleName

	(moduleEnvironment includesKey: aModuleName)
		ifFalse: [ ^ false ].
		
	^ (moduleEnvironment at: aModuleName)
		definesName: aName