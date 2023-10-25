Class {
	#name : 'MLSystemResolver',
	#superclass : 'Object',
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'name-resolution' }
MLSystemResolver >> lookupName: aString [ 
	
	1haltIf: [ aString = 'self' ].
	^ Smalltalk globals at: aString ifAbsent: [ self error: 'WAT' ]
]

{ #category : 'name-resolution' }
MLSystemResolver >> lookupName: aString ifAbsent: aFullBlockClosure [ 
	
	^ Smalltalk globals at: aString ifAbsent: aFullBlockClosure
]

{ #category : 'lookup' }
MLSystemResolver >> lookupVar: aString [ 
	
	^ Smalltalk globals bindingOf: aString
]
