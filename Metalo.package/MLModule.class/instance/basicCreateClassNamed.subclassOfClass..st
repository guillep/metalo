class creation
basicCreateClassNamed: aString subclassOfClass: superclass
	
	| theClass |
	DangerousClassNotifier disableDuring: [		
		theClass := AnonymousClassInstaller make: [ :builder |
			builder
				superclass: superclass;
				name: aString;
				layoutClass: (ObjectLayout layoutForType: #normal);
				slots: #();
				sharedVariables: #();
				sharedPools: '';
				classSlots: #();
				traitComposition: #() asTraitComposition;
				classTraitComposition: #() asTraitComposition;
				environment: Dictionary new ].
		^ theClass
	]