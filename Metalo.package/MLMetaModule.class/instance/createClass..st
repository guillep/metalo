classes
createClass: aClassDefinition 
	
	| theClass |
	
	(module includesName: aClassDefinition name) ifTrue: [ ^ self ].
	
	aClassDefinition classSide slots ifNotEmpty: [ self halt ].
	aClassDefinition traitComposition isEmpty ifFalse: [ self halt ].
	
	theClass := AnonymousClassInstaller make: [ :builder | 
		builder
			superclass: (module resolveName: aClassDefinition superclass name);
			name: aClassDefinition name;
			layoutClass: aClassDefinition classLayout class;
			slots: (aClassDefinition slots collect: [ :each | each copy ]);
			sharedVariables: (aClassDefinition classVariables collect: [ :assoc | assoc key ]);
			sharedPools: '';
			classSlots: #();
			traitComposition: #() asTraitComposition;
			classTraitComposition: #() asTraitComposition;
			environment: module ].
	
	theClass environment: module.
	module addClass: theClass.
	^ theClass