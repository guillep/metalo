Extension { #name : 'Package' }

{ #category : '*Modules' }
Package >> definedMethodsForClass: aClass isMeta: aBoolean [

	| classToSearch |
	classToSearch := aBoolean
		                 ifTrue: [ aClass classSide ]
		                 ifFalse: [ aClass instanceSide ].
	^ (self definedSelectorsForClass: classToSearch) asOrderedCollection
		  collect: [ :each | classToSearch >> each ]
]
