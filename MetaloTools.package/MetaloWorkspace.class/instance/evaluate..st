actions
evaluate: aString 

	[ | method |
	
	method := module compiler
		class: self environment;
		noPattern: true;
		compile: aString.
		
	^ module executeMethod: method ]
			on: OCUndeclaredVariableWarning
			do: [ :warning | | undeclaredName binding |
				undeclaredName := (warning instVarNamed: #node) name asSymbol.
				binding := self declareWorkspaceBindingNamed: undeclaredName.
				warning return: binding ].