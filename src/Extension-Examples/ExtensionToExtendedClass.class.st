Class {
	#name : 'ExtensionToExtendedClass',
	#superclass : 'Object',
	#category : 'Extension-Examples',
	#package : 'Extension-Examples'
}

{ #category : 'as yet unclassified' }
ExtensionToExtendedClass class >> extends [

	^ ExtendedClass
]

{ #category : 'accessing' }
ExtensionToExtendedClass >> extension [

	^ 'extension!'
]
