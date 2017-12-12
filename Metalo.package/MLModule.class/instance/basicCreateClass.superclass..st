class creation
basicCreateClass: aClassDefinition superclass: aSuperclass
	"Low level API.
	Mainly used to create undefined classes"
	
	aClassDefinition traitComposition isEmpty ifFalse: [ Transcript crShow: 'TraitComposition missing for: ', aClassDefinition className ].
	
	DangerousClassNotifier disableDuring: [
		^ MLClassInstaller make: [ :builder |
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
					environment: self
		]
	]