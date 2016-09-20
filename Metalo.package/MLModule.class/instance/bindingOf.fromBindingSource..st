private
bindingOf: aName fromBindingSource: aSource

	| resolvedName |
	resolvedName := aSource bindingOf: aName.
	resolvedName ifNil: [ (MLUnresolvedNameError named: aName) signal ].
	^ resolvedName