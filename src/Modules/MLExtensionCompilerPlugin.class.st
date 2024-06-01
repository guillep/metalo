Class {
	#name : 'MLExtensionCompilerPlugin',
	#superclass : 'Object',
	#instVars : [
		'module'
	],
	#category : 'Modules-Extensions',
	#package : 'Modules',
	#tag : 'Extensions'
}

{ #category : 'accessing' }
MLExtensionCompilerPlugin >> module [

	^ module
]

{ #category : 'accessing' }
MLExtensionCompilerPlugin >> module: anObject [

	module := anObject
]

{ #category : 'accessing' }
MLExtensionCompilerPlugin >> priority [
	
	^ 10
]

{ #category : 'accessing' }
MLExtensionCompilerPlugin >> transform: aMethodNode [

	| selectors receiverAssignment |
	selectors := module extensionSelectors.
	selectors ifEmpty: [ ^ aMethodNode ].

	"At runtime, all extensions in the module are active, but we don't know the type of the receiver.
	Worse, a selector can be at the same time an extension and a non-extension.
	Thus, if we just transform the selector we will break non-extensions.
	Instead, Compile a sequence of message-sends with typechecks"

	aMethodNode nodesDo: [ :e |
		| current |
		(e isMessage and: [ selectors includes: e selector ]) ifTrue: [
			| extensions |
			extensions := module extensionsOfSelector: e selector.
			self assert: extensions size = 1.

			receiverAssignment := RBAssignmentNode
				                      variable:
				                      (RBVariableNode named: '_temp_receiver')
				                      value: e receiver copy.
			current := e copy.
			current receiver: (RBVariableNode named: '_temp_receiver').
			extensions do: [ :ext |
				current := RBMessageNode
					           receiver: (RBMessageNode
							            receiver: (RBVariableNode named: '_temp_receiver')
							            selector: #isKindOf:
							            arguments:
							            { (RBVariableNode named: ext extendedClass name) })
					           selector: #ifTrue:ifFalse:
					           arguments: {
							           (RBBlockNode body: (RBMessageNode
									             receiver: (RBMessageNode
											              receiver:
											              (RBVariableNode named:
												               extensions first class name)
											              selector: #uniqueInstance)
									             selector:
									             (extensions first mangledSelectorFor: e selector)
									             arguments:
									             (e arguments copyWithFirst: e receiver copy))
									            asSequenceNode).
							           (RBBlockNode body: current asSequenceNode) } ].

			(e parent temporaryNames includes: '_temp_receiver') ifFalse: [
				e parent addTemporaryNamed: '_temp_receiver' ].
			e parent replaceNode: e withNodes: {
					receiverAssignment.
					current } ] ].

	^ aMethodNode
]
