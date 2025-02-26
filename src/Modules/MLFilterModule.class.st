Class {
	#name : 'MLFilterModule',
	#superclass : 'Object',
	#instVars : [
		'environment',
		'acceptedNames',
		'name'
	],
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'instance creation' }
MLFilterModule class >> on: anEnvironment named: aName [

	^ self new
		  name: aName;
		  environment: anEnvironment;
		  yourself
]

{ #category : 'accessing' }
MLFilterModule >> acceptedNames [

	^ acceptedNames
]

{ #category : 'lookup' }
MLFilterModule >> bindingOf: aString [

	(acceptedNames includes: aString) ifFalse: [ ^ nil ].
	^ environment bindingOf: aString
]

{ #category : 'accessing' }
MLFilterModule >> classes [
	
	^ acceptedNames collect: [ :n | environment lookupName: n ] thenSelect: [ :e | e isClass ]
]

{ #category : 'accessing' }
MLFilterModule >> environment [

	^ environment
]

{ #category : 'accessing' }
MLFilterModule >> environment: anObject [

	environment := anObject
]

{ #category : 'as yet unclassified' }
MLFilterModule >> filterName: aName [

	acceptedNames add: aName
]

{ #category : 'as yet unclassified' }
MLFilterModule >> initialize [

	super initialize.
	acceptedNames := OrderedCollection new
]

{ #category : 'name-resolution' }
MLFilterModule >> lookupName: aString ifPresent: aFullBlockClosure [

	(acceptedNames includes: aString) ifFalse: [ ^ nil ].
	^ aFullBlockClosure value: (environment lookupName: aString)
]

{ #category : 'name-resolution' }
MLFilterModule >> lookupVar: aString ifPresent: aFullBlockClosure [

	(acceptedNames includes: aString) ifFalse: [ ^ nil ].
	^ aFullBlockClosure value: (environment lookupVar: aString)
]

{ #category : 'accessing' }
MLFilterModule >> name [
	
	^ name
]

{ #category : 'accessing' }
MLFilterModule >> name: anObject [

	name := anObject
]
