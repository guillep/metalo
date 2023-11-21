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
MLModule class >> fromPackage: aPackage except: namesToFilterOut nameResolver: aNameResolver [

	| thePackage classDefinitions module |
	thePackage := aPackage asPackage.
	classDefinitions := thePackage definedClasses reject: [ :e |
		                    namesToFilterOut includes: e name ].
	classDefinitions := self topologicallySortClasses: classDefinitions.

	module := self newNamed: thePackage name.
	module nameResolver: aNameResolver.

	"First define all names in the namespace"
	classDefinitions do: [ :e | module createClassFromDefinition: e ].

	"Then compile all methods"
	classDefinitions do: [ :e |
		(thePackage definedMethodsForClass: e) do: [ :m |
			| owner |
			owner := module at: e name.
			owner compiler
				compiledMethodClass: (module
						 lookupName: #CompiledMethod
						 ifAbsent: [ NotFound signalFor: #CompiledMethod ]);
				bindings: module;
				class: owner;
				source: m sourceCode;
				requestor: nil;
				failBlock: nil;
				"no failblock if no requestor"permitUndeclared: false;
				"compatibility: permit undeclared if no requestor"logged: false;
				install ].

		(thePackage definedMethodsForClass: e class) do: [ :m |
			| owner |
			owner := (module at: e name) class.
			owner compiler
				compiledMethodClass: (module
						 lookupName: #CompiledMethod
						 ifAbsent: [ NotFound signalFor: #CompiledMethod ]);
				bindings: module;
				class: owner;
				source: m sourceCode;
				requestor: nil;
				failBlock: nil;
				"no failblock if no requestor"permitUndeclared: false;
				"compatibility: permit undeclared if no requestor"logged: false;
				install ] ].

	"Then compile all methods"
	thePackage extensionMethods do: [ :e |
		| owner |
		owner := module
			         lookupName: e methodClass instanceSide name
			         ifAbsent: [
			         NotFound signalFor: e methodClass instanceSide name ].
		e isClassSide ifTrue: [ owner := owner class ].
		"Ignore conflicting extensions for now"
		(owner includesSelector: e selector) ifFalse: [
			owner compiler
				compiledMethodClass: (module
						 lookupName: #CompiledMethod
						 ifAbsent: [ NotFound signalFor: #CompiledMethod ]);
				bindings: module;
				class: owner;
				source: e sourceCode;
				requestor: nil;
				failBlock: nil;
				"no failblock if no requestor"permitUndeclared: false;
				"compatibility: permit undeclared if no requestor"logged: false;
				install ] ].

	^ module
]

{ #category : 'instance creation' }
MLModule class >> fromPackage: aPackage nameResolver: aNameResolver [

	^ self
		  fromPackage: aPackage
		  except: #(  )
		  nameResolver: aNameResolver
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
		currentIterationToSort do: [ :e | | dependencies shouldSortClass |
			dependencies := { e superclass }, e traitComposition traits.
			shouldSortClass := dependencies allSatisfy: [ :d |
				"The dependency is external or already defined, thus satisfied"
				(classes includes: d) not or: [ sorted includes: d ]
			].
			shouldSortClass
				ifTrue: [ sorted add: e ]
				ifFalse: [ leftToSort add: e ] ] ].
	^ sorted
]

{ #category : 'adding' }
MLModule >> addMethod: aCollection [ 
	
	"Don't care here"
]

{ #category : 'compiler-compatibility' }
MLModule >> asDictionary [
	
	^ nameRegistry
]

{ #category : 'converting' }
MLModule >> asRingDefinition [
	
	^ RGPackageDefinition named: self name asSymbol
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
	
	^ nameRegistry at: aString ifAbsent: aFullBlockClosure
]

{ #category : 'name-resolution' }
MLModule >> at: aString put: aValue [

	^ nameRegistry add: (GlobalVariable key: aString value: aValue)
]

{ #category : 'name-resolution' }
MLModule >> bindingOf: aName [

	^ nameRegistry bindingOf: aName
]

{ #category : 'accessing' }
MLModule >> classes [
	
	^ nameRegistry values select: [ :e | e isClass ]
]

{ #category : 'compiler' }
MLModule >> compiler [

	^ OpalCompiler new
		  environment: self;
		  yourself
]

{ #category : 'class-installation' }
MLModule >> createClassFromDefinition: aClassDefinition [

	| superclass builder newClass newComposition layoutclass |
	aClassDefinition superclass ifNotNil: [
		superclass := self
			              lookupName: aClassDefinition superclass name
			              ifAbsent: [
			              NotFound signalFor: aClassDefinition superclass name ] ].
	newComposition := self evaluate:
		                  aClassDefinition traitComposition
			                  traitCompositionExpression.
	layoutclass := self
		               lookupName: aClassDefinition classLayout class name
		               ifAbsent: [
		               NotFound signalFor:
			               aClassDefinition classLayout class name ].

	builder := MLClassBuilder new
		           superclass: superclass;
		           layoutClass: layoutclass;
		           name: aClassDefinition name;
		           slots: aClassDefinition slots;
		           classSlots: aClassDefinition class slots;
		           classTraits: newComposition;
		           sharedVariablesFromString:
			           aClassDefinition classVariablesString;
		           buildEnvironment: (MLClassBuilderEnvironmentAdapter new
				            module: self;
				            yourself);
		           yourself.

	"Hack so it does not go look in the system for a class with the same name"
	newClass := builder build.
	self at: aClassDefinition name put: newClass.
	^ newClass
]

{ #category : 'accessing' }
MLModule >> evaluate: aString [

	^ self compiler evaluate: aString
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

{ #category : 'testing' }
MLModule >> isUndefined [
	"For compatibility?"
	^ true
]

{ #category : 'name-resolution' }
MLModule >> lookupName: aString [

	^ self lookupName: aString ifAbsent: nil
]

{ #category : 'name-resolution' }
MLModule >> lookupName: aString ifAbsent: absentBlock [

	PseudoVariable lookupDictionary
		at: aString
		ifPresent: [ :found | ^ found ].
	nameRegistry at: aString ifPresent: [ :found | ^ found ].
	^ nameResolver lookupName: aString ifAbsent: absentBlock
]

{ #category : 'lookup' }
MLModule >> lookupVar: aString [

	"Compiler compatibility"
	| binding |

	PseudoVariable lookupDictionary
		at: aString
		ifPresent: [ :found | ^ found ].
	
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
MLModule >> packageForProtocol: aProtocol from: aClass [ 

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

{ #category : 'tests' }
MLModule >> undefinedPackage [

	^ self
]

{ #category : 'tests' }
MLModule >> undefinedTag [

	^ UndefinedPackageTag undefinedPackage: self
]
