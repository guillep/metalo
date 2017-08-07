class creation
basicCreateClassNamed: aString subclassOf: aSuperclassNameOrNil
	
	| theClass superclass |
	DangerousClassNotifier disableDuring: [
		superclass := aSuperclassNameOrNil ifNotNil: [ | binding |
			binding := self bindingOf: aSuperclassNameOrNil.
			binding value ifNil: [ 
				binding value: (self basicCreateClassNamed: aSuperclassNameOrNil subclassOf: nil).
			].
			binding value ].
		
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