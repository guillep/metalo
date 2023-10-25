Class {
	#name : 'MLModule',
	#superclass : 'Object',
	#instVars : [
		'name',
		'nameResolver',
		'nameRegistry'
	],
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'instance creation' }
MLModule class >> fromPackage: aPackage nameResolver: aNameResolver [

	| thePackage classDefinitions module |
	thePackage := aPackage asPackage.
	classDefinitions := self topologicallySortClasses:
		                    thePackage definedClasses.

	module := self newNamed: thePackage name.
	module nameResolver: aNameResolver.

	"First define all names in the namespace"
	classDefinitions do: [ :e | module createClassFromDefinition: e ].

	"Then compile all methods"
	classDefinitions do: [ :e |
		(thePackage definedMethodsForClass: e) do: [ :m |
			| owner |
			owner := module at: e name.
			owner compile: m sourceCode ].
		
		(thePackage definedMethodsForClass: e class) do: [ :m |
			| owner |
			owner := module at: e name.
			owner class compile: m sourceCode ] ].
	^ module
]

{ #category : 'instance creation' }
MLModule class >> newNamed: aString [

	^ self new
		  name: aString;
		  yourself
]

{ #category : 'private' }
MLModule class >> topologicallySortClasses: classes [

	| leftToSort sorted |
	leftToSort := classes.
	sorted := OrderedCollection new.

	[ leftToSort notEmpty ] whileTrue: [
		| currentIterationToSort |
		currentIterationToSort := leftToSort.
		leftToSort := OrderedCollection new.
		currentIterationToSort do: [ :e |
			((classes includes: e superclass) not or: [
				 sorted includes: e superclass ])
				ifTrue: [ sorted add: e ]
				ifFalse: [ leftToSort add: e ] ] ].
	^ sorted
]

{ #category : 'adding' }
MLModule >> addMethod: aCollection [ 
	
	"Don't care here"
]

{ #category : 'accessing' }
MLModule >> associationAt: aString ifAbsent: aFullBlockClosure [ 
	
	"Compiler compatibility"
	
	| binding |
	binding := self lookupVar: aString.
	binding ifNotNil: [ ^ binding ].
	^ aFullBlockClosure value
]

{ #category : 'name-resolution' }
MLModule >> at: aString [
	
	^ nameRegistry at: aString
]

{ #category : 'name-resolution' }
MLModule >> at: aString ifAbsent: aFullBlockClosure [ 
	
	^ nameResolver lookupName: aString ifAbsent: aFullBlockClosure
]

{ #category : 'name-resolution' }
MLModule >> at: aString put: aValue [

	^ nameRegistry add: (GlobalVariable key: aString value: aValue)
]

{ #category : 'class-installation' }
MLModule >> createClassFromDefinition: aClassDefinition [

	| superclass builder newClass |
	superclass := self lookupName: aClassDefinition superclass name.

	builder := MLClassBuilder new
		           superclass: superclass;
		           name: aClassDefinition name;
		           slots: aClassDefinition slots;
		           classSlots: aClassDefinition class slots;
		           classTraits: aClassDefinition traitComposition;
		           environment: self;
		           yourself.

	"Hack so it does not go look in the system for a class with the same name"
	newClass := builder build.
	self at: aClassDefinition name put: newClass.
	^ newClass
]

{ #category : 'package - access from class' }
MLModule >> extendingPackagesOf: aClass [ 
	"Compatibility for now?"
	^ #()
]

{ #category : 'accessing' }
MLModule >> initialize [

	super initialize.
	nameRegistry := Dictionary new
]

{ #category : 'name-resolution' }
MLModule >> lookupName: aString [ 
	
	^ nameResolver lookupName: aString
]

{ #category : 'name-resolution' }
MLModule >> lookupName: aString ifAbsent: aConstantBlockClosure [ 
	
	^ self at: aString ifAbsent: aConstantBlockClosure
]

{ #category : 'lookup' }
MLModule >> lookupVar: aString [

	"Compiler compatibility"
	| binding |
	binding := nameRegistry bindingOf: aString.
	binding ifNotNil: [ ^ binding ].
	
	^ nameResolver lookupVar: aString
]

{ #category : 'accessing' }
MLModule >> name [
	^ name
]

{ #category : 'accessing' }
MLModule >> name: aString [ 
	
	name := aString
]

{ #category : 'accessing' }
MLModule >> nameResolver: aNameResolver [ 
	
	nameResolver := aNameResolver
]

{ #category : 'accessing' }
MLModule >> organization [
	
	"Compiler compatibility? Or announcements"
	^ self
]

{ #category : 'private' }
MLModule >> packageOf: aClass [ 
	
	"Announcements ask funny things"
	^ self "?"
]

{ #category : 'package - access from class' }
MLModule >> packageOfClassNamed: aString [ 
	
	"?"
	^ self
]

{ #category : 'class tags' }
MLModule >> tagOf: aClass [ 
	
	"Wat"
	^ UndefinedPackageTag undefinedPackage: self
]
