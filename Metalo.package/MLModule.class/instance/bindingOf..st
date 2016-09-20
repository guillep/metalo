compiling
bindingOf: aName

	^ (nameBindings bindingOf: aName)
		ifNil: [ importedNameBindings bindingOf: aName ]