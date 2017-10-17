class creation
basicCreateClass: aClassDefinition
	
	| superclass superclassName |
	superclassName := aClassDefinition superclassName.
	superclass := superclassName = #nil ifFalse: [ | binding |
		binding := self bindingOf: superclassName.
		binding value ifNil: [ 
			binding value: (self declareUndefinedClassNamed: superclassName).
		].
		binding value
	].
	
	DangerousClassNotifier disableDuring: [
		^ MLClassInstaller make: [ :builder |
			builder
					superclass: superclass;
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