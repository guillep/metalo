classes
createClass: aClassDefinition 
	
	| theClass |
	
	aClassDefinition classSide slots ifNotEmpty: [ self halt ].
	aClassDefinition traitComposition isEmpty ifFalse: [ self halt ].
	
	theClass := AnonymousClassInstaller make: [ :builder | 
		builder
			superclass: aClassDefinition superclass;
			name: aClassDefinition name;
			layoutClass: aClassDefinition classLayout class;
			slots: (aClassDefinition slots collect: [ :each | each copy ]);
			sharedVariables: (aClassDefinition classVariables collect: [ :assoc | assoc key ]);
			sharedPools: '';
			classSlots: #();
			traitComposition: #() asTraitComposition;
			classTraitComposition: #() asTraitComposition;
			environment: Dictionary new ].
		
	module addClass: aClassDefinition.
	^ theClass