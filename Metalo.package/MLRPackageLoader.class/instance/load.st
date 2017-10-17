loading
load
	
	| sortedClasses |
	sortedClasses := (rpackage definedClasses
		reject: [ :a | a isTrait ])
		sorted: [ :a :b | (self numberOfDependenciesOf: a) < (self numberOfDependenciesOf: b)  ].
	module createClasses: sortedClasses.
	
	rpackage definedClasses do: [ :c | | definedMethods definedClassMethods | 
		c isTrait ifFalse: [
			definedMethods := rpackage definedMethodsForClass: c.
			definedMethods do: [ :method | 
				module compileMethod: method sourceCode inClass: (module resolveName: c name) ].
			definedClassMethods := rpackage definedMethodsForClass: c classSide.
			definedClassMethods do: [ :method | 
				module compileMethod: method sourceCode inClass: (module resolveName: c name) classSide ] ] ].