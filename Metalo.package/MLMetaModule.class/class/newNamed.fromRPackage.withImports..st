instance-creation
newNamed: aName fromRPackage: anRPackage withImports: importsCollection
	
	"
	MLMetaModule newNamed: 'Network' fromRPackage: (RPackage organizer packageNamed: 'Network-Kernel')
	"
	| module |
	module := self createModuleNamed: aName.
	importsCollection do: [ :each | each importInto: module ].
	module metaModule createClasses: anRPackage definedClasses.
	
	anRPackage definedClasses do: [ :c | | definedMethods | 
		definedMethods := anRPackage definedMethodsForClass: c.
		definedMethods do: [ :method | 
			module metaModule compileMethod: method sourceCode inClass: (module resolveName: c name) ] ].
	
	^ module 