Class {
	#name : 'MLFilterEnvironment',
	#superclass : 'Object',
	#instVars : [
		'environment',
		'acceptedNames'
	],
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'instance creation' }
MLFilterEnvironment class >> on: anEnvironment [

	^ self new
		  environment: anEnvironment;
		  yourself
]

{ #category : 'accessing' }
MLFilterEnvironment >> acceptedNames [

	^ acceptedNames
]

{ #category : 'lookup' }
MLFilterEnvironment >> bindingOf: aString [

	(acceptedNames includes: aString) ifFalse: [ ^ nil ].
	^ environment bindingOf: aString
]

{ #category : 'accessing' }
MLFilterEnvironment >> environment [

	^ environment
]

{ #category : 'accessing' }
MLFilterEnvironment >> environment: anObject [

	environment := anObject
]

{ #category : 'as yet unclassified' }
MLFilterEnvironment >> filterName: aName [

	acceptedNames add: aName
]

{ #category : 'as yet unclassified' }
MLFilterEnvironment >> initialize [

	super initialize.
	acceptedNames := OrderedCollection new
]
