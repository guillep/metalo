class creation
basicCreateClass: aClassDefinition superclass: aSuperclass inEnvironment: anEnvironment
	"Low level API.
	Mainly used to create undefined classes"
	
	aClassDefinition traitComposition isEmpty ifFalse: [ Transcript crShow: 'TraitComposition missing for: ', aClassDefinition className ].
	
	DangerousClassNotifier disableDuring: [
		^ MLClassInstaller new
			installingEnvironment: (MLInstallingEnvironment new
				environment: anEnvironment;
				yourself);
			make: [ :builder |
				builder
						superclass: aSuperclass;
						name: aClassDefinition className;
						layoutClass: (ObjectLayout layoutForType: aClassDefinition type);
						slots: aClassDefinition instanceVariables;
						sharedVariables: aClassDefinition classVariables;
						sharedPools: aClassDefinition sharedPoolsString;
						classSlots: aClassDefinition classInstanceVariables;
						category: aClassDefinition category;
						traitComposition: #() asTraitComposition; "Ignore the traits for now"
						classTraitComposition: #() asTraitComposition; "Ignore the traits for now"
						buildEnvironment: self ] ]