Class {
	#name : 'ExtensionTests',
	#superclass : 'TestCase',
	#category : 'ExtensionImpl-Tests',
	#package : 'ExtensionImpl',
	#tag : 'Tests'
}

{ #category : 'tests' }
ExtensionTests >> testActiveExtensions [

	| extensions |
	extensions := ExtensionPlugin new activeExtensionsInClass:
		              UserOfExtendedClass.
	self assert: extensions asArray equals: { ExtensionToExtendedClass }
]

{ #category : 'tests' }
ExtensionTests >> testExtendedSelectors [

	| extensions |
	extensions := ExtensionPlugin new extensionSelectorsInClass:
		              UserOfExtendedClass.
	self assert: extensions asArray equals: { #extension }
]
