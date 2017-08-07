instance-creation
loadRPackage: anRPackage

	| module |
	module := self newNamed: (self packageToModuleName: anRPackage name).
	module createClasses: anRPackage definedClasses.
	anRPackage definedClasses do: [ :c | | definedMethods definedClassMethods | 
		c isTrait ifFalse: [
			definedMethods := anRPackage definedMethodsForClass: c.
			definedMethods do: [ :method | 
				module compileMethod: method sourceCode inClass: (module resolveName: c name) ].
			definedClassMethods := anRPackage definedMethodsForClass: c classSide.
			definedClassMethods do: [ :method | 
				module compileMethod: method sourceCode inClass: (module resolveName: c name) classSide ] ] ].
	^ module