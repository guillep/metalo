accessing
bindingOf: aName

	^ (importStack
		detect: [ :each | each includesKey: aName ]
		ifNone: [ module definitions ])
			bindingOf: aName