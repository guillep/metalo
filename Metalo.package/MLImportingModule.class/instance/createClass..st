as yet unclassified
createClass: aClassDefinition 
	
	| theClass |
	theClass := AnonymousClassInstaller make: [ :builder | 
		builder
			superclass: (self classNamed: (aClassDefinition superclassName ifNil: [ 'Object' ]));
			name: aClassDefinition name;
			layoutClass: (ObjectLayout layoutForType: #normal);
			slots: #();
			sharedVariables: #();
			sharedPools: '';
			classSlots: #();
			traitComposition: #() asTraitComposition;
			classTraitComposition: #() asTraitComposition;
			environment: self environment ].
	self environment at: aClassDefinition name put: theClass.
	^ theClass