Class {
	#name : 'ExtensionOfXTNode',
	#superclass : 'Object',
	#instVars : [
		'child'
	],
	#category : 'Extension-Examples-Visitor',
	#package : 'Extension-Examples',
	#tag : 'Visitor'
}

{ #category : 'as yet unclassified' }
ExtensionOfXTNode class >> extends [

	^ XTNode
]

{ #category : 'as yet unclassified' }
ExtensionOfXTNode >> asHTML [

	^ '<div>', self child asHTML, '</div>'
]
