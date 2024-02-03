Class {
	#name : 'MLModuleManager',
	#superclass : 'Object',
	#instVars : [
		'repositories'
	],
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'initialization' }
MLModuleManager >> initialize [

	super initialize.
	repositories := OrderedCollection new
]

{ #category : 'accessing' }
MLModuleManager >> repositories [

	^ repositories
]
