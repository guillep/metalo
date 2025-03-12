Class {
	#name : 'MLModuleBuilder',
	#superclass : 'Object',
	#instVars : [
		'module',
		'errors',
		'compilerClass'
	],
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'as yet unclassified' }
MLModuleBuilder class >> forCompilerClass: aCompilerClass [

	^ self new
		  compilerClass: aCompilerClass;
		  yourself
]

{ #category : 'accessing' }
MLModuleBuilder >> compilerClass: anObject [

	compilerClass := anObject
]

{ #category : 'instance creation' }
MLModuleBuilder >> initialize [

	super initialize.

	module := MLModule new.
	errors := OrderedCollection new.
]

{ #category : 'instance creation' }
MLModuleBuilder >> installMethod: m inOwner: owner [

	| methodDefinition compiler |
	methodDefinition := m asMCMethodDefinition.
	compiler := self newCompiler
		class: owner;
		source: methodDefinition source;
		yourself.
	compiler installer
		protocol: methodDefinition protocol.
	compiler install
]

{ #category : 'instance creation' }
MLModuleBuilder >> installMethodsFromPackage: aPackageDefinition fromClass: e classSide: isMeta [

	(aPackageDefinition definedMethodsForClass: e isMeta: isMeta) do: [
		:method |
		[
		| owner |
		owner := module lookupName: e name.
		isMeta ifTrue: [ owner := owner classSide ].
		self installMethod: method inOwner: owner ]
			on: Error
			do: [ :error | errors add: error freeze ] ]
]

{ #category : 'instance creation' }
MLModuleBuilder >> named: aName fromDefinition: aPackageDefinition except: namesToFilterOut nameResolver: aNameResolver [

	| classDefinitions sortedMCDefinitions |
	classDefinitions := aPackageDefinition definedClasses reject: [ :e |
		                    namesToFilterOut includes: e name ].
	sortedMCDefinitions := self topologicallySortClasses:
		                       classDefinitions.
	classDefinitions := sortedMCDefinitions collect: [ :e |
		                    classDefinitions detect: [ :class |
			                    class name = e name ] ].

	module name: aName.
	module nameResolver: aNameResolver.

	"First define all names in the namespace"
	sortedMCDefinitions do: [ :e |
		[
		e isTraitDefinition
			ifTrue: [ module createTraitFromDefinition: e ]
			ifFalse: [ module createClassFromDefinition: e ] ]
			on: Error
			do: [ :error | errors add: error freeze ] ].

	"Then compile all methods"
	classDefinitions do: [ :e |
		self
			installMethodsFromPackage: aPackageDefinition
			fromClass: e
			classSide: false.
		self
			installMethodsFromPackage: aPackageDefinition
			fromClass: e
			classSide: true ].

	"Then compile all methods"
	aPackageDefinition extensionMethods do: [ :method |
		[
		| owner m |
		m := method asMCMethodDefinition.
		owner := module lookupNameChecked: m className.
		m classIsMeta ifTrue: [ owner := owner classSide ].
		"Ignore conflicting extensions for now"
		(owner includesSelector: m selector) ifFalse: [
			self installMethod: method inOwner: owner ] ]
			on: Error
			do: [ :error | errors add: error freeze ] ].

	errors ifNotEmpty: [
		MLModuleCompilationError new
			errors: errors;
			signal ].

	module classes
		select: [ :e | e class includesLocalSelector: #initialize ]
		thenDo: [ :e | e initialize ].

	^ module
]

{ #category : 'instance creation' }
MLModuleBuilder >> newCompiler [

	| compiledMethodClass compiledBlockClass |
	compiledMethodClass := module lookupNameChecked: #CompiledMethod.
	compiledBlockClass := module lookupNameChecked: #CompiledBlock.


	^ compilerClass new
		  compiledMethodClass: compiledMethodClass;
		  compiledBlockClass: compiledBlockClass;
		  environment: module;
		  bindings: module;
		  permitUndeclared: false;
		  yourself
]

{ #category : 'instance creation' }
MLModuleBuilder >> topologicallySortClasses: classes [

	^ MCDependencySorter sortItems: (classes collect: [ :e | e asClassDefinition ])
]
