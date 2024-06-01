Class {
	#name : 'MLClassExtension',
	#superclass : 'Object',
	#instVars : [
		'extendedSelectors'
	],
	#classInstVars : [
		'extendedClass',
		'uniqueInstance'
	],
	#category : 'Modules-Extensions',
	#package : 'Modules',
	#tag : 'Extensions'
}

{ #category : 'accessing' }
MLClassExtension class >> extendedClass [
	^ extendedClass
]

{ #category : 'instance-creation' }
MLClassExtension class >> initializeWithExtendingClass: aClass [

	extendedClass := aClass.
	uniqueInstance := self new
]

{ #category : 'accessing' }
MLClassExtension class >> uniqueInstance [
	^ uniqueInstance
]

{ #category : 'compiling' }
MLClassExtension >> compile: extensionMethodSourceCode [
	"Compile a method for this extension given the source code argument"

	"Extension methods get compiled as follows:
	 - the method is compiled as a class-side method
	 - the method gets an extra argument with the receiver
	 - self gets replaces by the extra argument
	
	Then, users of this selector should be compiled specially"

	| compiler ast newSelector newArgument oldSelector newMethod |
	compiler := self class environment module compiler.
	ast := compiler parse: extensionMethodSourceCode.

	oldSelector := ast selector.
	newSelector := self mangleSelector: oldSelector.
	ast selector: newSelector.
	newArgument := RBVariableNode named: '_receiver'.
	newArgument parent: ast.
	ast arguments: (ast arguments copyWithFirst: newArgument).

	ast nodesDo: [ :e |
		(e isVariable and: [ e name = 'self' ]) ifTrue: [
			e replaceWith: (RBVariableNode named: '_receiver') ] ].

	newMethod := self class compile: ast formattedCode.
	extendedSelectors at: oldSelector put: newMethod.
	^ newMethod
]

{ #category : 'accessing' }
MLClassExtension >> extendedClass [
	
	^ self class extendedClass
]

{ #category : 'accessing' }
MLClassExtension >> extendedSelectors [
	
	^ extendedSelectors keys
]

{ #category : 'extensions' }
MLClassExtension >> extendsSelector: aSelector [
	
	^ extendedSelectors includesKey: aSelector
]

{ #category : 'accessing' }
MLClassExtension >> initialize [

	super initialize.
	extendedSelectors := Dictionary new
]

{ #category : 'mangling' }
MLClassExtension >> mangleSelector: aSelector [
	
	aSelector isBinary ifTrue: [ :e |
		self notYetImplemented.
	].

	^ aSelector , '_receiver:'
]

{ #category : 'accessing' }
MLClassExtension >> mangledSelectorFor: aString [ 
	
	^ extendedSelectors at: aString
]
