Class {
	#name : 'MLSystemModule',
	#superclass : 'Object',
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'lookup' }
MLSystemModule >> bindingOf: aString [ 
	
	^ Smalltalk globals bindingOf: aString
]

{ #category : 'name-resolution' }
MLSystemModule >> lookupName: aString [

	^ Smalltalk globals at: aString ifAbsent: [ self error: 'WAT' ]
]

{ #category : 'name-resolution' }
MLSystemModule >> lookupName: aString ifAbsent: aFullBlockClosure [ 
	
	^ Smalltalk globals at: aString ifAbsent: aFullBlockClosure
]

{ #category : 'lookup' }
MLSystemModule >> lookupVar: aString [ 
	
	^ self bindingOf: aString
]
