as yet unclassified
createClassRecursively: aClassDefinition classes: aCollection
	
	((aCollection includes: aClassDefinition superclass)
		and: [ (module includesName: aClassDefinition superclass name) not ])
		ifTrue: [ self createClassRecursively: aClassDefinition superclass classes: aCollection ].
		
	^ self createClass: aClassDefinition.