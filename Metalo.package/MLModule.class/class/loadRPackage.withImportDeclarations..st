instance-creation
loadRPackage: anRPackage withImportDeclarations: imports

	| module sortedClasses |
	module := self newNamed: (self packageToModuleName: anRPackage name).
	
	imports do: [ :importPerModule | | moduleName namesToImport |
		moduleName := importPerModule key.
		namesToImport := importPerModule value.
		namesToImport do: [ :aNameToImport |
			module import: aNameToImport from: moduleName ] ].
	
	sortedClasses := (anRPackage definedClasses
		reject: [ :a | a isTrait ])
		sorted: [ :a :b | (self numberOfDependenciesOf: a) < (self numberOfDependenciesOf: b)  ].
	module createClasses: sortedClasses.
	
	anRPackage definedClasses do: [ :c | | definedMethods definedClassMethods | 
		c isTrait ifFalse: [
			definedMethods := anRPackage definedMethodsForClass: c.
			definedMethods do: [ :method | 
				module compileMethod: method sourceCode inClass: (module resolveName: c name) ].
			definedClassMethods := anRPackage definedMethodsForClass: c classSide.
			definedClassMethods do: [ :method | 
				module compileMethod: method sourceCode inClass: (module resolveName: c name) classSide ] ] ].
	^ module