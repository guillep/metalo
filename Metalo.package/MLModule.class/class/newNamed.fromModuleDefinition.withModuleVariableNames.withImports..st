instance-creation
newNamed: aName fromModuleDefinition: aModuleDefinition withModuleVariableNames: aModuleVariableNameCollection withImports: importsCollection
	"Module definitions and RPackages are polymorphic so far"

	| module |
	module := self newNamed: aName.
	importsCollection do: [ :each | module addBinding: each ].
	aModuleVariableNameCollection do: [ :aVariableName | module declareVariableNamed: aVariableName ].
	module createClasses:
		aModuleDefinition definedClasses.
	aModuleDefinition definedClasses
		do: [ :c | 
			| definedMethods definedClassMethods |
			c isTrait
				ifFalse: [ definedMethods := aModuleDefinition definedMethodsForClass: c.
					definedMethods
						do: [ :method | 
							module
								compileMethod: method sourceCode
								inClass: (module resolveName: c name) ].
					definedClassMethods := aModuleDefinition
						definedMethodsForClass: c classSide.
					definedClassMethods
						do: [ :method | 
							module
								compileMethod: method sourceCode
								inClass: (module resolveName: c name) classSide ] ] ].	"module initializeModule."
	^ module