as yet unclassified
bindingOf: aName

	| binding |
	binding := environment bindingOf: aName.
	binding ifNil: [ | definingModule |
		definingModule := imports detect: [ :module | module definesName: aName ] ifNone: nil.
		binding := definingModule ifNotNil: [ definingModule bindingOf: aName ] ].
	
	binding ifNil: [ 
		MLUnknownName new
			module: self;
			undefinedName: aName;
			signal ].
	^ binding