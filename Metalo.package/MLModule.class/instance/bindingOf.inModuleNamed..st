binding-resolution
bindingOf: aName inModuleNamed: aModuleName

	(self definesName: aName inModuleNamed: aModuleName)
		ifFalse: [ ^ nil ].
	
	^ classBindings bindingOf: aName