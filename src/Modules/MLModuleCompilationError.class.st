Class {
	#name : 'MLModuleCompilationError',
	#superclass : 'Error',
	#instVars : [
		'errors'
	],
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'accessing' }
MLModuleCompilationError >> errors [

	^ errors
]

{ #category : 'accessing' }
MLModuleCompilationError >> errors: anObject [

	errors := anObject
]
