Class {
	#name : 'MLClassBuilderEnvironmentAdapter',
	#superclass : 'Object',
	#instVars : [
		'module'
	],
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'accessing' }
MLClassBuilderEnvironmentAdapter >> associationAt: aString ifAbsent: aFullBlockClosure [ 
	
	^ (module bindingOf: aString) ifNil: aFullBlockClosure
]

{ #category : 'accessing' }
MLClassBuilderEnvironmentAdapter >> at: aString ifAbsent: aFullBlockClosure [

	^ module lookupName: aString ifAbsent: aFullBlockClosure
]

{ #category : 'binding' }
MLClassBuilderEnvironmentAdapter >> bindingOf: aString [ 
	
	^ module bindingOf: aString
]

{ #category : 'accessing' }
MLClassBuilderEnvironmentAdapter >> codeChangeAnnouncer [
	
	^ Announcer new
]

{ #category : 'testing' }
MLClassBuilderEnvironmentAdapter >> hasBindingThatBeginsWith: aString [ 
	
	^ false
]

{ #category : 'testing' }
MLClassBuilderEnvironmentAdapter >> hasClassNamed: aString [ 

	module at: aString ifAbsent: [ ^ false ].
	^ true
]

{ #category : 'lookup' }
MLClassBuilderEnvironmentAdapter >> lookupVar: aString [
	"Lookup a var in the environment and all its dependencies"

	^ module lookupVar: aString
]

{ #category : 'accessing' }
MLClassBuilderEnvironmentAdapter >> module [

	^ module
]

{ #category : 'accessing' }
MLClassBuilderEnvironmentAdapter >> module: anObject [

	module := anObject
]

{ #category : 'accessing' }
MLClassBuilderEnvironmentAdapter >> organization [

	^ module organization
]
