Class {
	#name : 'MLStackSidebar',
	#superclass : 'SpPresenter',
	#instVars : [
		'stackPresenter',
		'stack'
	],
	#category : 'Modules-UI',
	#package : 'Modules',
	#tag : 'UI'
}

{ #category : 'layout' }
MLStackSidebar >> defaultLayout [

	layout := SpBoxLayout newVertical
		  spacing: 5;
		  yourself.
	stack ifNotNil: [ self refreshButtons ].
	^ layout
]

{ #category : 'layout' }
MLStackSidebar >> refreshButtons [

	| nonActiveButtons activeButton |
	nonActiveButtons := OrderedCollection new.
	stack stackPages do: [ :p |
		| button |
		button := self newToggleButton
			          label: p title;
			          icon: p icon;
			          action: [ "If we toggled the current, toggle it back!"
				          (stack isActivePage: p)
					          ifTrue: [ button toggleState ]
					          ifFalse: [ stack activePage: p ] ];
			          yourself.
		button whenBuiltDo: [ 
			button adapter widget extent: 60@60 ].
		(stack isActivePage: p)
			ifTrue: [ activeButton := button ]
			ifFalse: [ nonActiveButtons add: button ].
		layout add: button withConstraints: [ :constraints |
			constraints height: 60; width: 60 ] ].
	activeButton associatedToggleButtons: nonActiveButtons.
	activeButton toggleState
]

{ #category : 'accessing' }
MLStackSidebar >> stack: aStack [

	stack := aStack.
	layout ifNotNil: [ self refreshButtons ]
]
