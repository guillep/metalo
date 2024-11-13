Class {
	#name : 'UserOfExtendedClass',
	#superclass : 'Object',
	#category : 'Extension-Examples',
	#package : 'Extension-Examples'
}

{ #category : 'as yet unclassified' }
UserOfExtendedClass class >> compiler [
	"the example plugin is active for this class"
	^super compiler addPlugin: ExtensionPlugin
]

{ #category : 'as yet unclassified' }
UserOfExtendedClass >> compiler [
	^ self class compiler
]

{ #category : 'as yet unclassified' }
UserOfExtendedClass >> doSomething: anObject [

	^ anObject extension
]

{ #category : 'as yet unclassified' }
UserOfExtendedClass >> doSomethingNotExtension: anObject [

	^ anObject notExtension
]

{ #category : 'as yet unclassified' }
UserOfExtendedClass >> extension [

	^ 'not an extension...'
]

{ #category : 'as yet unclassified' }
UserOfExtendedClass >> notExtension [

	^ 'a verr'
]
