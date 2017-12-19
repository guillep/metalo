class creation
basicCreateClass: aClassDefinition inEnvironment: anInstallingEnvironment
	
	| superclass superclassName |
	superclassName := aClassDefinition superclassName.
	superclass := superclassName = #nil ifFalse: [ | binding |
		binding := self bindingOf: superclassName.
		"If the binding is nil it means that the name is not defined and we need to create an undeclared."
		binding
			ifNil: [ self declareUndefinedClassNamed: superclassName ]
			ifNotNil: [ 
				binding value
					ifNil: [ 
						"If the binding is not nil, and the value is nil it means that we have a non-class binding, and we need to create an undefined class for it."
						binding
							value: (self basicCreateUndefinedClassNamed: superclassName inEnvironment: importsEnvironment);
							value ]
					ifNotNil: [ 
						"Otherwise we assume the binding value is a class and we use it"
						self assert: binding value isBehavior.
						binding value ] ] ].
	
	^ self
		basicCreateClass: aClassDefinition 
		superclass: superclass
		inEnvironment: anInstallingEnvironment