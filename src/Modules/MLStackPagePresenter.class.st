Class {
	#name : 'MLStackPagePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'child',
		'icon',
		'title'
	],
	#category : 'Modules-UI',
	#package : 'Modules',
	#tag : 'UI'
}

{ #category : 'accessing' }
MLStackPagePresenter >> child: aSpButtonPresenter [ 
	child := aSpButtonPresenter
]

{ #category : 'layout' }
MLStackPagePresenter >> defaultLayout [

	^ SpBoxLayout newHorizontal
		  add: child;
		  yourself
]

{ #category : 'accessing' }
MLStackPagePresenter >> icon [
	
	^ icon
]

{ #category : 'accessing' }
MLStackPagePresenter >> icon: aForm [ 
	icon := aForm
]

{ #category : 'accessing' }
MLStackPagePresenter >> title [
	
	^ title
]

{ #category : 'accessing' }
MLStackPagePresenter >> title: aString [ 
	
	title := aString
]
