delcarations
declareVariableNamed: aString 
	
	| binding |
	self assertNameNotImported: aString.
	self assertClassNotDeclared: aString.
	
	binding := GlobalVariable named: aString.
	
	variableBindings
		detect: [ :each | each name = aString ]
		ifFound: [ :found | ^ found ].
	
	self declareBinding: binding.
	
	variableBindings at: aString put: binding.
	^ binding