binding-resolution
at: aName put: anObject

	
	| oldBinding newBinding |
	oldBinding := self resolveBinding: aName.
	self undeclaredBindings removeKey: aName ifAbsent: [].
	self environment removeKey: aName ifAbsent: [].
	self environment add: (MLModuleBinding name: aName value: anObject).
	newBinding := self environment bindingOf: aName.