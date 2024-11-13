Class {
	#name : 'ExtensionSelector',
	#superclass : 'Object',
	#instVars : [
		'selector'
	],
	#category : 'ExtensionImpl-Core',
	#package : 'ExtensionImpl',
	#tag : 'Core'
}

{ #category : 'instance creation' }
ExtensionSelector class >> on: aSelector [

	^ self new
		  selector: aSelector;
		  yourself
]

{ #category : 'copying' }
ExtensionSelector >> , aString [ 
	
	"Calypso"
	^ selector, aString
]

{ #category : 'copying' }
ExtensionSelector >> = anotherSelector [

	self == anotherSelector ifTrue: [ ^ true ].
	(anotherSelector isKindOf: ExtensionSelector)
		ifTrue: [ ^ self selector == anotherSelector selector ].
	
	^ self selector == anotherSelector asSymbol
]

{ #category : 'converting' }
ExtensionSelector >> asLowercase [
	
	"Calypso"
	^ selector asLowercase
]

{ #category : 'converting' }
ExtensionSelector >> asString [

	^ self selector asString
]

{ #category : 'private' }
ExtensionSelector >> asSymbol [

	^ selector
]

{ #category : 'accessing' }
ExtensionSelector >> at: index [

	"When in a string morph?"
	^ selector at: index
]

{ #category : 'accessing' }
ExtensionSelector >> basicAt: index [

	"When in a string morph?"
	^ selector basicAt: index
]

{ #category : 'matching' }
ExtensionSelector >> beginsWith: aString [
	
	"Code completion"
	^ selector beginsWith: aString 
]

{ #category : 'private' }
ExtensionSelector >> flushCache [

	selector flushCache
]

{ #category : 'copying' }
ExtensionSelector >> hash [

	^ self selector hash
]

{ #category : 'as yet unclassified' }
ExtensionSelector >> includesSubstring: aString caseSensitive: aBoolean [ 
	
	^ selector includesSubstring: aString caseSensitive: aBoolean
]

{ #category : 'testing' }
ExtensionSelector >> isBinary [
	"Calypso!"

	^ selector isBinary
]

{ #category : 'testing' }
ExtensionSelector >> isByteString [
	"Calypso"

	^ selector isByteString
]

{ #category : 'testing' }
ExtensionSelector >> isDoIt [
	
	"Calypso?"
	^ selector isDoIt
]

{ #category : 'testing' }
ExtensionSelector >> isKeyword [
	
	^ selector isKeyword
]

{ #category : 'testing' }
ExtensionSelector >> isUnary [
	
	^ selector isUnary
]

{ #category : 'accessing' }
ExtensionSelector >> keywords [
	
	^ selector keywords
]

{ #category : 'accessing' }
ExtensionSelector >> localizedForPresenter: aSpLabelPresenter [ 
	
	"Spec????"
	^ selector localizedForPresenter: aSpLabelPresenter
]

{ #category : 'as yet unclassified' }
ExtensionSelector >> lookupMethodInReceiver: anExtendedClass withLexicalContext: lexicalContextClass [
	"Look for the active extensions in the class.
	If there is one extension with the same selector, yes!
	Otherwise, go to superclass.
	Return nil if end of hierarchy"

	"the receiver has a normal method witht the same selector?
	Give it priority."
	(anExtendedClass lookupSelector: selector) ifNotNil: [ :foundMethod |
		^ foundMethod ].

	"Assume no conflict between extensions here!"
	(ExtensionPlugin new activeExtensionsInClass: lexicalContextClass)
		do: [ :ext |
			ext extends = anExtendedClass ifTrue: [
				(ext lookupSelector: selector) ifNotNil: [ :foundMethod |
					self assert: foundMethod isCompiledMethod.
					^ foundMethod ] ] ].


	^ anExtendedClass superclass ifNotNil: [
		  self
			  lookupMethodInReceiver: anExtendedClass superclass
			  withLexicalContext: lexicalContextClass ]
]

{ #category : 'accessing' }
ExtensionSelector >> numArgs [
	
	^ selector numArgs
]

{ #category : 'printing' }
ExtensionSelector >> printOn: aStream [
	"Generate a string representation of the receiver based on its instance variables."

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		print: selector;
		nextPutAll: ')'
]

{ #category : 'accessing' }
ExtensionSelector >> selector [

	^ selector
]

{ #category : 'accessing' }
ExtensionSelector >> selector: anObject [

	selector := anObject
]

{ #category : 'accessing' }
ExtensionSelector >> size [

	"When in a string morph?"
	^ selector size
]
