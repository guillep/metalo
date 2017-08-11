definitions
removeVariableNamed: aString 
	
	| aBinding |
	aBinding := variableBindings detect: [ :each | each name = aString ].
	variableBindings removeKey: aBinding name.
	self checkUndeclaredBinding: aBinding