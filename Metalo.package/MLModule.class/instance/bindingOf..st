compiling
bindingOf: aName

	| resolvedName |
	resolvedName := (nameBindings bindingOf: aName)
		ifNil: [ importedNameBindings bindingOf: aName ].
		
	resolvedName ifNil: [ (MLUnresolvedNameError named: aName) signal ].
	^ resolvedName