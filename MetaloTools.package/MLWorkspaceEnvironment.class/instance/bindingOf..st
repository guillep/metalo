compilation
bindingOf: aName
	
	| superBinding |
	superBinding := parentEnvironment bindingOf: aName.
	^ superBinding ifNil: [ workspace bindings bindingOf: aName ]