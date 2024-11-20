Class {
	#name : 'XTNode',
	#superclass : 'Object',
	#instVars : [
		'child'
	],
	#category : 'Extension-Examples-Visitor',
	#package : 'Extension-Examples',
	#tag : 'Visitor'
}

{ #category : 'compiler' }
XTNode class >> compiler [
	"the example plugin is active for this class"
	^super compiler addPlugin: (ExtensionPlugin)
]

{ #category : 'accessing' }
XTNode >> child [

	^ child
]

{ #category : 'accessing' }
XTNode >> child: anObject [

	child := anObject
]
