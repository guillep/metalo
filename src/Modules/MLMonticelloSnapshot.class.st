Class {
	#name : 'MLMonticelloSnapshot',
	#superclass : 'Object',
	#instVars : [
		'snapshot'
	],
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'instance creation' }
MLMonticelloSnapshot class >> on: aMCSnapshot [

	^ self new
		  snapshot: aMCSnapshot;
		  yourself
]

{ #category : 'accessing' }
MLMonticelloSnapshot >> definedClasses [

	^ snapshot definitions select: [ :e | e isClassDefinition ]
]

{ #category : 'accessing' }
MLMonticelloSnapshot >> definedMethodsForClass: aClass isMeta: aBoolean [

	^ snapshot definitions select: [ :e |
		e isMethodDefinition and: [
			e className = aClass name and: [ e classIsMeta = aBoolean ] ] ]
]

{ #category : 'accessing' }
MLMonticelloSnapshot >> extensionMethods [

	^ snapshot definitions select: [ :e |
		  e isMethodDefinition and: [ e isExtensionMethod ] ]
]

{ #category : 'accessing' }
MLMonticelloSnapshot >> snapshot [

	^ snapshot
]

{ #category : 'accessing' }
MLMonticelloSnapshot >> snapshot: anObject [

	snapshot := anObject
]
