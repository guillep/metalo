Class {
	#name : 'GlobalExtensionPlugin',
	#superclass : 'Object',
	#classInstVars : [
		'activeExtensionCache'
	],
	#category : 'ExtensionImpl-Core',
	#package : 'ExtensionImpl',
	#tag : 'Core'
}

{ #category : 'accessing' }
GlobalExtensionPlugin class >> activeExtensionCache [

	activeExtensionCache ifNotNil: [ ^ activeExtensionCache ].
	^ activeExtensionCache := Smalltalk allClasses select: [ :e |
		  e respondsTo: #extends ]
]

{ #category : 'accessing' }
GlobalExtensionPlugin class >> priority [
	
	^ 10
]

{ #category : 'accessing' }
GlobalExtensionPlugin class >> transform: aRBMethodNode [

	^ self new transform: aRBMethodNode
]

{ #category : 'as yet unclassified' }
GlobalExtensionPlugin >> activeExtensionsInClass: aClass [

	^ self class activeExtensionCache
]

{ #category : 'as yet unclassified' }
GlobalExtensionPlugin >> extensionSelectorsInClass: aClass [ 
	
	| extensions |
	extensions := self activeExtensionsInClass: aClass.
	^ extensions flatCollect: [ :e | e selectors ]
]

{ #category : 'as yet unclassified' }
GlobalExtensionPlugin >> transform: aRBMethodNode [

	| selectors |
	
	self haltIf: [ aRBMethodNode methodClass = IceTipSettingsCommand ].
	selectors := self extensionSelectorsInClass:
		             aRBMethodNode methodClass.
	aRBMethodNode nodesDo: [ :node |
		(node isMessage and: [ selectors includes: node selector ]) ifTrue: [
			node selector:
				(RBSelectorNode value: (ExtensionSelector on: node selector)) ] ].
	^ aRBMethodNode
]
