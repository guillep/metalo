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

	^ self
		  named: aPackage asPackage name
		  fromDefinition: aPackage asPackage
		  except: namesToFilterOut
		  nameResolver: aNameResolver
]

{ #category : 'instance creation' }
MLModule class >> fromPackage: aPackage nameResolver: aNameResolver [

	^ self
		  fromPackage: aPackage
		  except: #(  )
		  nameResolver: aNameResolver
]

{ #category : 'instance creation' }
MLModule class >> named: aName fromDefinition: aPackageDefinition except: namesToFilterOut nameResolver: aNameResolver [

	| classDefinitions module errors |
	errors := OrderedCollection new.

	classDefinitions := aPackageDefinition definedClasses reject: [ :e |
		                    namesToFilterOut includes: e name ].
	classDefinitions := self topologicallySortClasses: classDefinitions.

	module := self newNamed: aName.
	module nameResolver: aNameResolver.

	"First define all names in the namespace"
	classDefinitions do: [ :e | module createClassFromDefinition: e ].

	"Then compile all methods"
	classDefinitions do: [ :e |
		(aPackageDefinition definedMethodsForClass: e isMeta: false) do: [
			:m |
			[
			| owner |
			owner := module lookupName: e name.
			owner compiler
				compiledMethodClass: (module
						 lookupName: #CompiledMethod
						 ifAbsent: [ NotFound signalFor: #CompiledMethod ]);
				bindings: module;
				class: owner;
				source: m source;
				requestor: nil;
				failBlock: nil;
				"no failblock if no requestor"permitUndeclared: false;
				"compatibility: permit undeclared if no requestor"logged: false;
				install ]
				on: Error
				do: [ :e | errors add: e freeze ] ].

		(aPackageDefinition definedMethodsForClass: e isMeta: true) do: [ :m |
			[
			| owner |
			owner := (module at: e name) class.
			owner compiler
				compiledMethodClass: (module
						 lookupName: #CompiledMethod
						 ifAbsent: [ NotFound signalFor: #CompiledMethod ]);
				bindings: module;
				class: owner;
				source: m source;
				requestor: nil;
				failBlock: nil;
				"no failblock if no requestor"permitUndeclared: false;
				"compatibility: permit undeclared if no requestor"logged: false;
				install ]
				on: Error
				do: [ :e | errors add: e freeze ] ] ].

	"Then compile all methods"
	aPackageDefinition extensionMethods do: [ :e |
		[
		| owner |
		owner := module
			         lookupName: e className
			         ifAbsent: [ NotFound signal: e className ].
		e classIsMeta ifTrue: [ owner := owner classSide ].
		"Ignore conflicting extensions for now"
		(owner includesSelector: e selector) ifFalse: [
			owner compiler
				compiledMethodClass: (module
						 lookupName: #CompiledMethod
						 ifAbsent: [ NotFound signalFor: #CompiledMethod ]);
				bindings: module;
				environment: module;
				class: owner;
				source: e source;
				requestor: nil;
				failBlock: nil;
				"no failblock if no requestor"permitUndeclared: false;
				"compatibility: permit undeclared if no requestor"logged: false;
				install ] ]
			on: Error
			do: [ :e | errors add: e freeze ] ].

	module classes
		select: [ :e | e class includesLocalSelector: #initialize ]
		thenDo: [ :e | e initialize ].

	errors ifNotEmpty: [
		MLModuleCompilationError new
			errors: errors;
			signal ].
	^ module
]

{ #category : 'instance creation' }
MLModule class >> named: aName fromDefinition: aPackageDefinition nameResolver: aNameResolver [

	^ self
		  named: aName
		  fromDefinition: aPackageDefinition
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
	
	^ MCDependencySorter sortItems: classes
	"leftToSort := classes.
	sorted := OrderedCollection new.

	[ leftToSort notEmpty ] whileTrue: [
		| currentIterationToSort |
		currentIterationToSort := leftToSort.
		leftToSort := OrderedCollection new.
		currentIterationToSort do: [ :e | | dependencies shouldSortClass |
			dependencies := { e superclass }, e traitComposition traits.
			shouldSortClass := dependencies allSatisfy: [ :d |
				""The dependency is external or already defined, thus satisfied""
				(classes includes: d) not or: [ sorted includes: d ]
			].
			shouldSortClass
				ifTrue: [ sorted add: e ]
				ifFalse: [ leftToSort add: e ] ] ].
	^ sorted"
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
	| binding |
	binding := nameRegistry bindingOf: aName.
	^ binding ifNil: [ nameResolver lookupVar: aName ]
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
		superclass := self lookupName: aClassDefinition superclassName ].
	newComposition := self evaluate:
		                  aClassDefinition traitCompositionString.
	layoutclass := self lookupName: aClassDefinition layoutClassName.

	builder := MLClassBuilder new
		           superclass: superclass;
		           layoutClass: layoutclass;
		           name: aClassDefinition name;
		           slots: aClassDefinition instVarNames;
		           classSlots: aClassDefinition classInstanceVariables;
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

{ #category : 'system integration' }
MLModule >> ensurePackageOfExtensionProtocol: aProtocol [ 
	
	^ nil
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

	1 haltIf: [ aString = 'XMLSmallIntegerReader' ].
	PseudoVariable lookupDictionary
		at: aString
		ifPresent: [ :found | ^ found ].
	nameRegistry at: aString ifPresent: [ :found | ^ found ].
	^ nameResolver lookupName: aString ifAbsent: absentBlock
]

{ #category : 'name-resolution' }
MLModule >> lookupName: aString ifPresent: aBlock [

1 haltIf: [ aString = 'XMLSmallIntegerReader' ].
	PseudoVariable lookupDictionary
		at: aString
		ifPresent: [ :found | ^ aBlock value: found ].
	nameRegistry at: aString ifPresent: [ :found | ^ aBlock value: found ].
	^ nameResolver lookupName: aString ifAbsent: [ nil ]
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

{ #category : 'system integration' }
MLModule >> packageMatchingExtensionName: aString [ 
	
	^ nil
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

{ #category : 'accessing' }
MLModule >> printOn: aStream [

	aStream << self class name << '(' << name << ')'
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
