instance-creation
newNamed: aName fromRPackage: anRPackage withImports: bindingCollection
	
	"
	MLMetaModule newNamed: 'Network' fromRPackage: (RPackage organizer packageNamed: 'Network-Kernel')
	"
	| module |
	module := self createModuleNamed: aName.
	bindingCollection do: [ :each | 
		module addBinding: each ].
	module metaModule createClasses: anRPackage definedClasses.
	
	anRPackage definedClasses do: [ :c | | definedMethods definedClassMethods | 
		definedMethods := anRPackage definedMethodsForClass: c.
		definedMethods do: [ :method | 
			module metaModule compileMethod: method sourceCode inClass: (module resolveName: c name) ].
		definedClassMethods := anRPackage definedMethodsForClass: c classSide.
		definedClassMethods do: [ :method | 
			module metaModule compileMethod: method sourceCode inClass: (module resolveName: c name) classSide ]  ].
	
	module initializeModule.
	
	^ module 