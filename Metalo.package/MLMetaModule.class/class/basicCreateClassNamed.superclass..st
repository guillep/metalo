configuration
basicCreateClassNamed: aString superclass: aSuperclass
	
	| theClass |
	theClass := AnonymousClassInstaller make: [ :builder | 
		builder
			superclass: aSuperclass;
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