Class {
	#name : 'MLListEnvironment',
	#superclass : 'Object',
	#instVars : [
		'environments'
	],
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'instance creation' }
MLListEnvironment class >> withAll: aList [

	^ self new
		  environments: aList;
		  yourself
]

{ #category : 'adding' }
MLListEnvironment >> add: anEnvironment [
	
	environments addFirst: anEnvironment
]

{ #category : 'accessing' }
MLListEnvironment >> environments [

	^ environments
]

{ #category : 'accessing' }
MLListEnvironment >> environments: anObject [

	environments := anObject
]

{ #category : 'initialization' }
MLListEnvironment >> initialize [

	super initialize.
	environments := OrderedCollection new
]

{ #category : 'name-resolution' }
MLListEnvironment >> lookupName: aString [

	^ self lookupName: aString ifAbsent: [ NotFound signal: aString ]
]

{ #category : 'name-resolution' }
MLListEnvironment >> lookupName: aString ifAbsent: aFullBlockClosure [

	(self lookupVar: aString) ifNotNil: [ :found | ^ found value ].
	^ aFullBlockClosure value
]

{ #category : 'lookup' }
MLListEnvironment >> lookupVar: aString [

	environments do: [ :e |
		(e bindingOf: aString) ifNotNil: [ :found | ^ found ] ].
	^ nil
]

{ #category : 'accessing' }
MLListEnvironment >> modules [
	
	^ environments
]
