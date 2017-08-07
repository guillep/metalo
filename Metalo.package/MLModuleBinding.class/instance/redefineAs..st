redefinition
redefineAs: aBinding
	
	"Since this binding belongs to the module, we are free of becoming the value."
	self value ifNotNil: [ :bindingValue | 
		(bindingValue isClass
			and: [ aBinding value isClass
				and: [ (bindingValue format = aBinding value format) not ] ])
				ifTrue: [ self error: 'incompatible format change in a class!' ].
			 bindingValue becomeForward: aBinding value ].
	self becomeForward: aBinding