tests
testRedefineClassWithDifferentFormatReplacesOldClass

	| oldClass newClass |
	
	"Create point class without instance variables"
	oldClass := module declareClass: (MCClassDefinition
		name: #Point
		superclassName: #Object
		category: 'no category'
		instVarNames: #( )
		comment: 'no comments').
	
	
	self assert: oldClass slots size equals: 0.
	
	"Recreate point class with instance variables"
	newClass := module declareClass: (MCClassDefinition
		name: #Point
		superclassName: #Object
		category: 'no category'
		instVarNames: #( x y )
		comment: 'no comments').
	
	self assert: newClass slots size equals: 2.
	
	self assert: oldClass == newClass