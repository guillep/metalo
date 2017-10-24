tests
testRedefineSuperclassWithDifferentFormatReplacesOldClass

	| pointClass |

	"Create point class without instance variables"
	module declareClass: (MCClassDefinition
		name: #Object
		superclassName: nil
		category: 'no category'
		instVarNames: #( )
		comment: 'no comments').
	
	"Create point class without instance variables"
	pointClass := module declareClass: (MCClassDefinition
		name: #Point
		superclassName: #Object
		category: 'no category'
		instVarNames: #( )
		comment: 'no comments').
	
	self assert: pointClass allSlots size equals: 0.
	
	"Recreate point class with instance variables"
	module declareClass: (MCClassDefinition
		name: #Object
		superclassName: nil
		category: 'no category'
		instVarNames: #( x y )
		comment: 'no comments').
	
	self assert: pointClass allSlots size equals: 2.
	