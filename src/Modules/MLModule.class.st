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
		  fromPackage: aPackage
		  except: namesToFilterOut
		  nameResolver: aNameResolver
		  compilerClass: OpalCompiler
]

{ #category : 'instance creation' }
MLModule class >> fromPackage: aPackage except: namesToFilterOut nameResolver: aNameResolver compilerClass: aCompilerClass [

	^ (MLModuleBuilder forCompilerClass: aCompilerClass)
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
MLModule class >> fromPackage: aPackage nameResolver: aNameResolver compilerClass: aCompilerClass [

	^ self
		  fromPackage: aPackage
		  except: #(  )
		  nameResolver: aNameResolver
		  compilerClass: aCompilerClass
]

{ #category : 'instance creation' }
MLModule class >> named: aName fromDefinition: aPackageDefinition nameResolver: aNameResolver [

	^ MLModuleBuilder new
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

{ #category : 'adding' }
MLModule >> addExtensionTo: extendedClassName named: extensionName [

	| extendedClass extensionClass |
	extendedClass := self lookupNameChecked: extendedClassName.

	extensionClass := self createClassFromDefinition:
		                  ((MCClassDefinition named: extensionName)
			                   superclassName: #MLClassExtension;
			                   yourself).

	extensionClass initializeWithExtendingClass: extendedClass.
	^ extensionClass uniqueInstance
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
MLModule >> asMCOrganizationDefinition [

	^ MCOrganizationDefinition
		  packageName: self name
		  tagNames: self tagNames
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
MLModule >> at: aString ifPresent: aFullBlockClosure [ 
	
	^ nameRegistry at: aString ifPresent: aFullBlockClosure
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
		  addParsePlugin: (MLExtensionCompilerPlugin new
				   module: self;
				   yourself);
		  yourself
]

{ #category : 'class-installation' }
MLModule >> createClassFromDefinition: aClassDefinition [

	| superclass builder newClass newComposition layoutclass |
	aClassDefinition superclass ifNotNil: [
		superclass := self lookupNameChecked:
			              aClassDefinition superclassName ].
	newComposition := self evaluate:
		                  aClassDefinition traitCompositionString.
	layoutclass := self lookupNameChecked:
		               aClassDefinition layoutClassName.

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

{ #category : 'class-installation' }
MLModule >> createNewClass [

	^ self createClassFromDefinition: (MCClassDefinition named: 'NewClass')
]

{ #category : 'accessing' }
MLModule >> definedClasses [
	
	^ self classes
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
MLModule >> extensionSelectors [
	
	^ self extensions flatCollect: [ :e | e extendedSelectors ]
]

{ #category : 'accessing' }
MLModule >> extensions [

	^ nameRegistry values
		  select: [ :e | e isKindOf: MLClassExtension class ]
		  thenCollect: [ :e | e uniqueInstance ]
]

{ #category : 'extensions' }
MLModule >> extensionsOfSelector: aSelector [

	^ self extensions select: [ :e | e extendsSelector: aSelector ]
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

{ #category : 'name-resolution' }
MLModule >> lookupName: aString ifPresent: aBlock [

	PseudoVariable lookupDictionary
		at: aString
		ifPresent: [ :found | ^ aBlock value: found ].
	nameRegistry
		at: aString
		ifPresent: [ :found | ^ aBlock value: found ].
	^ nameResolver lookupName: aString ifAbsent: [ nil ]
]

{ #category : 'name-resolution' }
MLModule >> lookupNameChecked: aString [

	^ self lookupName: aString ifAbsent: [ NotFound signal: aString ]
]

{ #category : 'lookup' }
MLModule >> lookupVar: aString [

	^ self lookupVar: aString ifPresent: [ :p | p ]
]

{ #category : 'lookup' }
MLModule >> lookupVar: aString ifPresent: aBlock [
	"Compiler compatibility"

	| binding |
	binding := nameRegistry bindingOf: aString.
	binding ifNotNil: [ ^ aBlock value: binding ].

	^ aBlock value: (nameResolver lookupVar: aString ifAbsent: [ ^ nil ])
]

{ #category : 'accessing' }
MLModule >> methods [
	
	^ self classes flatCollect: [ :e | e methods ]
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

{ #category : 'accessing' }
MLModule >> tagNames [

	^ #(  )
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
