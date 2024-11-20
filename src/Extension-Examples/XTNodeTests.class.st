Class {
	#name : 'XTNodeTests',
	#superclass : 'TestCase',
	#category : 'Extension-Examples-Visitor',
	#package : 'Extension-Examples',
	#tag : 'Visitor'
}

{ #category : 'compiler' }
XTNodeTests class >> compiler [
	"the example plugin is active for this class"
	^super compiler addPlugin: ExtensionPlugin
]

{ #category : 'tests' }
XTNodeTests >> compiler [

	^ self class compiler
]

{ #category : 'tests' }
XTNodeTests >> testExtensionInXTNode [

	| node |
	node := XTNode new
		        child: XTCodeParagraph new;
		        yourself.
	self
		assert: node asHTML
		equals: '<div><code>Smalltalk globals browse</code></div>'
]

{ #category : 'tests' }
XTNodeTests >> testNonExtensionCodeParagraph [

	self
		assert: XTCodeParagraph new asHTML
		equals: '<code>Smalltalk globals browse</code>'
]
