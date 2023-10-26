Class {
	#name : 'MLSystemEnvironment',
	#superclass : 'Object',
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'lookup' }
MLSystemEnvironment >> bindingOf: aString [ 
	
	^ Smalltalk globals bindingOf: aString
]

{ #category : 'name-resolution' }
MLSystemEnvironment >> lookupName: aString [ 
	
	1haltIf: [ aString = 'self' ].
	^ Smalltalk globals at: aString ifAbsent: [ self error: 'WAT' ]
]

{ #category : 'name-resolution' }
MLSystemEnvironment >> lookupName: aString ifAbsent: aFullBlockClosure [ 
	
	^ Smalltalk globals at: aString ifAbsent: aFullBlockClosure
]

{ #category : 'lookup' }
MLSystemEnvironment >> lookupVar: aString [ 
	
	^ self bindingOf: aString
]
