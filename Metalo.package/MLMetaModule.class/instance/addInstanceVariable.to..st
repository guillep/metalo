mop
addInstanceVariable: aString to: aClass
	
	| newClass |
	newClass := AnonymousClassInstaller make: [ :builder |
		builder
			superclass: aClass superclass;
			name: aClass getName;
			layoutClass: aClass classLayout class;
			slots: (aClass slots copyWith: (InstanceVariableSlot named: aString asSymbol));
			classSlots: aClass class classLayout slots;
			sharedVariablesFromString: aClass classVariablesString;
			sharedPools: aClass sharedPoolsString;
			category: aClass category;
			environment: aClass environment].
	aClass becomeForward: newClass.