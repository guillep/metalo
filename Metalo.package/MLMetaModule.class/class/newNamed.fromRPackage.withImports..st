instance-creation
newNamed: aName fromRPackage: anRPackage withImports: importsCollection
	
	"
	MLMetaModule newNamed: 'Network' fromRPackage: (RPackage organizer packageNamed: 'Network-Kernel')
	"
	| module |
	module := self createModuleNamed: aName.
	importsCollection do: [ :each | each importInto: module ].
	anRPackage definedClasses do: [ :aClassDefinition | 
		module metaModule createClass: aClassDefinition. ].
	^ module 