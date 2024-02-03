Class {
	#name : 'MLStackPresenter',
	#superclass : 'SpPresenter',
	#classTraits : '{} + TraitedClass',
	#instVars : [
		'activePage',
		'stackPages'
	],
	#category : 'Modules-UI',
	#package : 'Modules',
	#tag : 'UI'
}

{ #category : 'accessing' }
MLStackPresenter >> activePage: aMLStackPagePresenter [

	activePage := aMLStackPagePresenter.

	layout
		removeAll;
		add: activePage
]

{ #category : 'adding' }
MLStackPresenter >> addChild: aChild [

	| newPage |
	newPage := MLStackPagePresenter new
		child: aChild;
		yourself.
	self addPage: newPage.
	^ newPage
]

{ #category : 'adding' }
MLStackPresenter >> addPage: newPage [

	stackPages add: newPage.
	stackPages size = 1 ifTrue: [ 
		activePage := newPage.
		layout ifNotNil: [ layout add: newPage ] ]
]

{ #category : 'layout' }
MLStackPresenter >> defaultLayout [

	| newLayout |
	newLayout := SpBoxLayout newHorizontal.
	activePage ifNotNil: [ newLayout add: activePage ].
	^ newLayout
]

{ #category : 'adding' }
MLStackPresenter >> initialize [

	super initialize.
	stackPages := OrderedCollection new
]

{ #category : 'testing' }
MLStackPresenter >> isActivePage: aMLStackPagePresenter [ 
	
	^ activePage == aMLStackPagePresenter
]

{ #category : 'accessing' }
MLStackPresenter >> stackPages [
	^ stackPages
]
