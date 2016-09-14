as yet unclassified
bindingOf: aName

	^ (imports bindingOf: aName)
		ifNil: [ super bindingOf: aName ]