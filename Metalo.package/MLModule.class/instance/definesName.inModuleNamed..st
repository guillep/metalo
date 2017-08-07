testing
definesName: aDefinedName inModuleNamed: aModuleName
	
	self name = aModuleName
		ifFalse: [ ^ false ].
	
	^ self definesName: aDefinedName