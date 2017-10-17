class creation
createClass: aClassDefinition 
	
	| theClass  superclass |
	
	(self includesName: aClassDefinition name) ifTrue: [ ^ self ].
	
	aClassDefinition traitComposition isEmpty ifFalse: [ Transcript crShow: 'TraitComposition missing for: ', aClassDefinition name ].
	
	superclass := aClassDefinition superclass ifNotNil: [ | binding |
		binding := self bindingOf: aClassDefinition superclass name.
		binding value ifNil: [ 
			binding value: (self basicCreateClassNamed: aClassDefinition superclass name subclassOfClass: UndefinedClass).
		].
		binding value ].
	
	theClass := AnonymousClassInstaller make: [ :builder | 
		builder
			superclass: superclass ;
			name: aClassDefinition name;
			layoutClass: aClassDefinition classLayout class;
			slots: (aClassDefinition slots collect: [ :each | each copy ]);
			sharedVariables: (aClassDefinition classVariables collect: [ :assoc | assoc key ]);
			sharedPools: (' ' join: aClassDefinition sharedPoolNames) ;
			classSlots: (aClassDefinition classSide slots collect: [ :each | each copy ] );
			traitComposition: #() asTraitComposition;
			classTraitComposition: #() asTraitComposition;
			environment: self ].
	
	theClass environment: self.
	
	self at: aClassDefinition name put: theClass.
	^ theClass