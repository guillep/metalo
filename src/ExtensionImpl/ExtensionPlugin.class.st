Class {
	#name : 'ExtensionPlugin',
	#superclass : 'Object',
	#category : 'ExtensionImpl',
	#package : 'ExtensionImpl'
}

{ #category : 'accessing' }
ExtensionPlugin class >> priority [
	
	^ 10
]

{ #category : 'accessing' }
ExtensionPlugin class >> transform: aRBMethodNode [

	^ self new transform: aRBMethodNode
]

{ #category : 'as yet unclassified' }
ExtensionPlugin >> activeExtensionsInClass: aClass [

	^ aClass package definedClasses select: [ :e |
		  e respondsTo: #extends ]
]

{ #category : 'as yet unclassified' }
ExtensionPlugin >> extensionSelectorsInClass: aClass [ 
	
	| extensions |
	extensions := self activeExtensionsInClass: aClass.
	^ extensions flatCollect: [ :e | e selectors ]
]

{ #category : 'as yet unclassified' }
ExtensionPlugin >> transform: aRBMethodNode [

	| selectors |
	1halt.
	selectors := self extensionSelectorsInClass:
		             aRBMethodNode methodClass.
	aRBMethodNode nodesDo: [ :node |
		(node isMessage and: [ selectors includes: node selector ]) ifTrue: [
			1halt.
			node selector:
				(RBSelectorNode value: (ExtensionSelector on: node selector)) ] ].
	^ aRBMethodNode
]
