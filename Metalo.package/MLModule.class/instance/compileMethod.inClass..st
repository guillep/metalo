class creation
compileMethod: sourceCode inClass: aClass 
	
	| method |
	
	[ 
	method := self compileMethod: sourceCode forClass: aClass.
	self installMethod: method inClass: aClass.
	]
		on: OCUndeclaredVariableWarning
		do: [ :warning | | undeclaredName |
			undeclaredName := (warning instVarNamed: #node) name asSymbol.
			self undeclaredBindings at: undeclaredName ifAbsentPut: nil.
			warning return: (self undeclaredBindings bindingOf: undeclaredName) ].
	^ method