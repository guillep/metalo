"
Specific version of compiled code for methods. They encode only the method's bytecodes and literals, blocks have each a CompiledBlock.

In addition the execution mechanics, a compiled method has two extra literals. The last literal is the class in which the method is installed. The last but one literal is either the method's selector or an AdditionalMethodState instance. AdditionalMethodState instances are used to encode pragmas and properties.

The bytecode encodes the trailer at the end, see #trailerSize for the current size used.
Thus endPC of a compiled method is not the size of the bytecode, but the size minus the fixed length of the trailer.

"
Class {
	#name : 'PetitCompiledMethod',
	#superclass : 'PetitCompiledCode',
	#type : 'compiledMethod',
	#category : 'Metalo-Kernel',
	#package : 'Metalo-Kernel'
}

{ #category : 'constants' }
PetitCompiledMethod class >> abstractMarker [
	^ #subclassResponsibility
]

{ #category : 'class initialization' }
PetitCompiledMethod class >> checkBytecodeSetConflictsInMethodsWith: aBlock [

	self allSubInstances
		detect: aBlock
		ifFound: [ Warning signal: 'There are existing CompiledMethods with a different encoderClass.' ]
]

{ #category : 'class initialization' }
PetitCompiledMethod class >> checkIsValidBytecodeEncoder: aBytecodeEncoderSubclass [
	(aBytecodeEncoderSubclass inheritsFrom: BytecodeEncoder) ifFalse:
		[self error: 'A bytecode set encoder is expected to be a subclass of BytecodeEncoder']
]

{ #category : 'constants' }
PetitCompiledMethod class >> conflictMarker [
	^ #traitConflict
]

{ #category : 'constants' }
PetitCompiledMethod class >> disabledMarker [
	^ #shouldNotImplement
]

{ #category : 'constants' }
PetitCompiledMethod class >> explicitRequirementMarker [
	^ #explicitRequirement
]

{ #category : 'class initialization' }
PetitCompiledMethod class >> fullFrameSize [  "CompiledMethod fullFrameSize"
	^ LargeFrame
]

{ #category : 'instance creation' }
PetitCompiledMethod class >> headerFlagForEncoder: anEncoderClass [
	anEncoderClass == PrimaryBytecodeSetEncoderClass ifTrue: [ ^ 0 ].
	anEncoderClass == SecondaryBytecodeSetEncoderClass ifTrue: [ ^ SmallInteger minVal ].
	self error: 'The encoder is not one of the two installed bytecode sets'
]

{ #category : 'class initialization' }
PetitCompiledMethod class >> initialize [    "CompiledMethod initialize"
	"Initialize class variables specifying the size of the temporary frame
	needed to run instances of me."

	SmallFrame := 16.	"Context range for temps+stack"
	LargeFrame := 56.
	PrimaryBytecodeSetEncoderClass := nil. "Old encoder was removed"
	SecondaryBytecodeSetEncoderClass := EncoderForSistaV1
]

{ #category : 'class initialization' }
PetitCompiledMethod class >> installPrimaryBytecodeSet: aBytecodeEncoderSubclass [
	PrimaryBytecodeSetEncoderClass == aBytecodeEncoderSubclass ifTrue:
		[ ^self ].
	self checkIsValidBytecodeEncoder: aBytecodeEncoderSubclass.
	self checkBytecodeSetConflictsInMethodsWith: [:m|
		m usesPrimaryBytecodeSet and: [m encoderClass ~~ aBytecodeEncoderSubclass]].
	PrimaryBytecodeSetEncoderClass := aBytecodeEncoderSubclass
]

{ #category : 'class initialization' }
PetitCompiledMethod class >> installSecondaryBytecodeSet: aBytecodeEncoderSubclass [
	PrimaryBytecodeSetEncoderClass == aBytecodeEncoderSubclass ifTrue:
		[ ^ self ].
	self checkIsValidBytecodeEncoder: aBytecodeEncoderSubclass.
	self checkBytecodeSetConflictsInMethodsWith: [ :m |
		m usesSecondaryBytecodeSet and: [ m encoderClass ~~ aBytecodeEncoderSubclass ] ].
	SecondaryBytecodeSetEncoderClass := aBytecodeEncoderSubclass
]

{ #category : 'accessing - class hierarchy' }
PetitCompiledMethod class >> methodPropertiesClass [
	"Answer the class to use to create a method's properties, which can be a poor man's way
	 to add instance variables to subclassses of CompiledMethod.  Subclasses of CompiledMethod
	 should define a corresponding subclass of AdditionalMethodState that adds any instance variables
	 required, and override this method to answer that class."
	^AdditionalMethodState
]

{ #category : 'instance creation' }
PetitCompiledMethod class >> new [
	"This will not make a meaningful method, but it could be used
	to invoke some otherwise useful method in this class."
	^self basicNew: 2 header: 1024
]

{ #category : 'class initialization' }
PetitCompiledMethod class >> smallFrameSize [

	^ SmallFrame
]

{ #category : 'constants' }
PetitCompiledMethod class >> subclassResponsibilityMarker [
	^ #subclassResponsibility
]

{ #category : 'constants' }
PetitCompiledMethod class >> trailerSize [
	"we use the last 5 byte to store the source pointer"
	^ 5
]

{ #category : 'queries' }
PetitCompiledMethod >> allIgnoredNotImplementedSelectors [

	^ (self pragmaAt: #ignoreNotImplementedSelectors:)
		  ifNotNil: [ :pragma | pragma argumentAt: 1 ]
		  ifNil: [ #(  ) ]
]

{ #category : 'accessing - pragmas & properties' }
PetitCompiledMethod >> cachePragmas [

	self pragmas do: [ :pragma | pragma class addToCache: pragma ]
]

{ #category : 'accessing' }
PetitCompiledMethod >> classBinding [
	"answer the association to the class that I am installed in, or nil if none."
	^self literalAt: self numLiterals
]

{ #category : 'accessing' }
PetitCompiledMethod >> classBinding: aBinding [
       "sets the association to the class that I am installed in"
       ^self literalAt: self numLiterals put: aBinding
]

{ #category : 'source code management' }
PetitCompiledMethod >> clearSourcePointer [
	"we use #setSourcePointer: to not clear the property #source"
	self setSourcePointer: 0
]

{ #category : 'accessing' }
PetitCompiledMethod >> codeForNoSource [
	"if everything fails, decompile the bytecode"
	"If there is no compiler, we cannot decompile it"
	Smalltalk hasCompiler ifFalse: [ ^ nil ].

	 ^(self compiler decompileMethod: self) formattedCode
]

{ #category : 'testing' }
PetitCompiledMethod >> containsHalt [

	^ self hasProperty: #containsHalt
]

{ #category : 'accessing' }
PetitCompiledMethod >> defaultSelector [
	"Invent and answer an appropriate message selector (a Symbol) for me,
	that is, one that will parse with the correct number of arguments."

	^ #DoIt numArgs: self numArgs
]

{ #category : 'displaying' }
PetitCompiledMethod >> displayStringOn: aStream [
	aStream print: self methodClass; nextPutAll: '>>'; store: self selector
]

{ #category : 'accessing' }
PetitCompiledMethod >> endPC [
	"Answer the index of the last bytecode"
	^ self size - self class trailerSize
]

{ #category : 'accessing' }
PetitCompiledMethod >> flushCache [
	"Tell the virtual machine to remove all references to this method from its method lookup caches, and to discard any optimized version 	of the method, if it has any of these.  This must be done whenever a method is modified in place, such as modifying its literals or 	machine code, to reflect the revised code.  c.f. Behavior>>flushCache & Symbol>>flushCache.  Essential.	 See MethodDictionary class 	comment."

	<primitive: 116>
]

{ #category : 'source code management' }
PetitCompiledMethod >> getPreambleFrom: aFileStream at: position [
	^ SourceFiles getPreambleFrom: aFileStream at: position
]

{ #category : 'source code management' }
PetitCompiledMethod >> getSourceFromFile [
	"PLEASE Note: clients should always call #sourceCode"
	"Read the source code from file, determining source file index and
	file position from the last bytes of this method (size defined in #trailerSize)."

	^ [ SourceFiles sourceCodeAt: self sourcePointer ] on: Error do: [ nil ]
]

{ #category : 'source code management' }
PetitCompiledMethod >> getSourceReplacingSelectorWith: newSelector [
	| oldKeywords newKeywords source newSource oldSelector start |
	source := self sourceCode.

	source ifNil: [ ^ nil ].

	oldSelector := self selector.
	oldSelector = newSelector ifTrue: [ ^ source ].

	oldKeywords := oldSelector keywords.
	newKeywords := (newSelector ifNil: [self defaultSelector]) keywords.
	[oldKeywords size = newKeywords size] assert.

	newSource := source.
	start := 1.
	oldKeywords with: newKeywords do: [:oldKey :newKey| |pos|
		pos := newSource findString: oldKey startingAt: start .
		newSource := newSource copyReplaceFrom: pos to: (pos + oldKey size -1) with: newKey.
		start := pos + newKey size ].

	^newSource
]

{ #category : 'testing' }
PetitCompiledMethod >> hasComment [
	"check if this method has a method comment"
	^self comment isEmptyOrNil not
]

{ #category : 'testing' }
PetitCompiledMethod >> hasEquivalentMethodInSuperclass [

	^ self overriddenMethod
		  ifNil: [ false ]
		  ifNotNil: [ :method | self equivalentTo: method ]
]

{ #category : 'testing' }
PetitCompiledMethod >> hasNonLocalReturn [
	"Answer whether any block has a method-return ('^') in its code."
	self allBlocksDo: [ :each | each hasMethodReturn ifTrue: [ ^true ] ].
	^false
]

{ #category : 'testing' }
PetitCompiledMethod >> hasPragma [
	<reflection: 'Class structural inspection - Pragma'>
	^ self hasProperties and: [self pragmas isNotEmpty]
]

{ #category : 'accessing - pragmas & properties' }
PetitCompiledMethod >> hasPragmaNamed: aSymbol [
	<reflection: 'Class structural inspection - Pragma'>
	^ self pragmas anySatisfy: [ :pragma | pragma selector = aSymbol ]
]

{ #category : 'testing' }
PetitCompiledMethod >> hasProperties [
	^ self penultimateLiteral isMethodProperties
]

{ #category : 'accessing - pragmas & properties' }
PetitCompiledMethod >> hasProperty: aKey [

	| extendedMethodState |
	^ (extendedMethodState := self penultimateLiteral) isMethodProperties
		  and: [  extendedMethodState includesProperty: aKey ]
]

{ #category : 'accessing' }
PetitCompiledMethod >> hasSourceCode [

	^ self sourceCodeOrNil isNotNil
]

{ #category : 'testing' }
PetitCompiledMethod >> hasSourcePointer [
	^ self sourcePointer ~= 0
]

{ #category : 'testing' }
PetitCompiledMethod >> isAbstract [
	"Answer true if I am abstract"

	| marker |
	marker := self markerOrNil ifNil: [^false].

	^marker == self class subclassResponsibilityMarker
		or: [ marker == self class explicitRequirementMarker ]
]

{ #category : 'testing' }
PetitCompiledMethod >> isBinarySelector [
	^self selector
		allSatisfy: [:each | each isSpecial]
]

{ #category : 'testing' }
PetitCompiledMethod >> isClassSide [
	<reflection: 'Class structural inspection - Class/Metaclass shift'>
	^self methodClass isClassSide
]

{ #category : 'testing' }
PetitCompiledMethod >> isClassified [

	^ self protocol isUnclassifiedProtocol not
]

{ #category : 'testing' }
PetitCompiledMethod >> isCompiledMethod [

	^ true
]

{ #category : 'testing' }
PetitCompiledMethod >> isConflict [
	^ self markerOrNil == self class conflictMarker
]

{ #category : 'testing' }
PetitCompiledMethod >> isDeprecated [

	^ (self sendsAnySelectorOf:
		   #( #deprecated: #deprecated:transformWith: #deprecated:transformWith:when: #deprecated:on:in: #deprecated:on:in:transformWith:
		      #deprecated:on:in:transformWith:when: )) or: [ self methodClass isDeprecated or: [ self package ifNotNil: [ :package | package isDeprecated ] ] ]
]

{ #category : 'testing' }
PetitCompiledMethod >> isDisabled [
	^ self isDisabled: self markerOrNil
]

{ #category : 'testing' }
PetitCompiledMethod >> isDisabled: marker [
	^ marker == self class disabledMarker
]

{ #category : 'testing' }
PetitCompiledMethod >> isDoIt [
	^self selector isDoIt
]

{ #category : 'testing' }
PetitCompiledMethod >> isExplicitlyRequired [
	^ self isExplicitlyRequired: self markerOrNil
]

{ #category : 'testing' }
PetitCompiledMethod >> isExplicitlyRequired: marker [
	^ marker == self class explicitRequirementMarker
]

{ #category : 'testing' }
PetitCompiledMethod >> isExtension [
	"I return true if a method is an extension method. Which means that the methods is not packaged in the package of the class containing the method, but in another package."

	"(self >> #selector) isExtension >>> false"

	"(self >> #traitSource) isExtension >>> true"

	^ self hasProperty: #extensionPackage
]

{ #category : 'testing' }
PetitCompiledMethod >> isFaulty [
 	"check if this method was compiled from syntactically wrong code"
	| ast |
	"fast pre-check: all methods with syntax errors reference this symbol"
  	(self refersToLiteral: #signalSyntaxError:) ifFalse: [ ^false].

	"Check the ast in cache, if any"
	ast := self propertyAt: #ast ifAbsent: [].

	ast ifNil: [
		"Warning, the following does not work for doit methods because this assumes `noPrefix:false` "
		ast := self methodClass compiler
				source: self sourceCode;
				parse ].
	^ ast isFaulty
]

{ #category : 'testing' }
PetitCompiledMethod >> isFromTrait [
	"Return true for methods that have been included from Traits"

	<reflection: 'Class structural inspection - Selectors and methods inspection'>
	^ self hasProperty: #traitSource
]

{ #category : 'testing' }
PetitCompiledMethod >> isInstalled [
	self methodClass ifNotNil:
		[:class|
		self selector ifNotNil:
			[:selector|
			^self == (class compiledMethodAt: selector ifAbsent: nil)]].
	^false
]

{ #category : 'testing' }
PetitCompiledMethod >> isInstanceSide [
	<reflection: 'Class structural inspection - Class/Metaclass shift'>
	^self methodClass isInstanceSide
]

{ #category : 'testing' }
PetitCompiledMethod >> isOverridden [
	| selector|
	selector := self selector.
	self methodClass allSubclassesDo: [:each |
		(each includesSelector: selector)
			ifTrue: [ ^ true ]].
	^ false
]

{ #category : 'testing' }
PetitCompiledMethod >> isProvided [
	^ self isProvided: self markerOrNil
]

{ #category : 'testing' }
PetitCompiledMethod >> isProvided: marker [
	marker ifNil: [^ true].
	^ (self isRequired: marker) not and: [(self isDisabled: marker) not]
]

{ #category : 'testing' }
PetitCompiledMethod >> isRequired [
	"A method is required if it is a method declaring a subclass responsibility or an explicit requirement. This mean the method needs to be overriden (in case of subclass reponsibility) or implemented (in case of explicit requirement)."

	^ self isRequired: self markerOrNil
]

{ #category : 'testing' }
PetitCompiledMethod >> isRequired: marker [
	marker ifNil: [^ false].
	(self isExplicitlyRequired: marker) ifTrue: [^ true].
	(self isSubclassResponsibility: marker) ifTrue: [^ true].
	^ false
]

{ #category : 'testing' }
PetitCompiledMethod >> isReturnField [
	"Answer whether the receiver is a quick return of an instance variable."
	^ self primitive between: 264 and: 519
]

{ #category : 'printing' }
PetitCompiledMethod >> isSelfEvaluating [

	^self methodClass isNotNil and: [self isDoIt not]
]

{ #category : 'testing' }
PetitCompiledMethod >> isSubclassResponsibility [
	^ self isSubclassResponsibility: self markerOrNil
]

{ #category : 'testing' }
PetitCompiledMethod >> isSubclassResponsibility: marker [
	^ marker == self class subclassResponsibilityMarker
]

{ #category : 'source code management' }
PetitCompiledMethod >> linesOfCode [
	"An approximate measure of lines of code.
	Includes method's name and comments, but excludes empty lines."
	| lines |
	lines := 0.
	self sourceCode lineIndicesDo: [:start :endWithoutDelimiters :end |
		endWithoutDelimiters > start ifTrue: [lines := lines+1]].
	^lines
]

{ #category : 'literals' }
PetitCompiledMethod >> literalsToSkip [

	^ 2
]

{ #category : 'private' }
PetitCompiledMethod >> markerOrNil [
	^ self encoderClass markerOrNilFor: self
]

{ #category : 'accessing' }
PetitCompiledMethod >> method [
	"polymorphic with closure"

	^ self
]

{ #category : 'accessing' }
PetitCompiledMethod >> methodClass [
	"answer the class that I am installed in"
	^self classBinding value
]

{ #category : 'accessing' }
PetitCompiledMethod >> methodClass: aClass [
	"set the class binding in the last literal to aClass"
	^self numLiterals > 0
		ifTrue: [ self literalAt: self numLiterals put: aClass binding ]
]

{ #category : 'private' }
PetitCompiledMethod >> migratePersistingPropertiesIn: aNewCompileMethod [
	"While creating a new version of a method, we might want to persist some properties. I am here for this. I migrate the properties to persist from myself, the old version of the method, to the new version."

	| properties |
	(properties := self penultimateLiteral) isMethodProperties ifFalse: [ ^ self "There is no property so nothing to migrate." ].

	properties class propertiesToPersist do: [ :propertyName |
		properties at: propertyName ifPresent: [ :value | aNewCompileMethod propertyAt: propertyName put: value ] ]
]

{ #category : 'accessing' }
PetitCompiledMethod >> name [
	^ self printString
]

{ #category : 'accessing' }
PetitCompiledMethod >> overriddenMethod [

	^ self methodClass superclass ifNotNil: [ :class | class lookupSelector: self selector ]
]

{ #category : 'accessing' }
PetitCompiledMethod >> pathOfLiteralIndexes [
	
	^ #[]
]

{ #category : 'private' }
PetitCompiledMethod >> penultimateLiteral [
	"Answer the penultimate literal of the receiver, which holds either
	 the receiver's selector or its properties (which will hold the selector)."
	| pIndex |
	^(pIndex := self numLiterals - 1) > 0
		ifTrue: [self literalAt: pIndex]
		ifFalse: [nil]
]

{ #category : 'private' }
PetitCompiledMethod >> penultimateLiteral: anObject [
	"Answer the penultimate literal of the receiver, which holds either
	 the receiver's selector or its properties (which will hold the selector)."
	| pIndex |
	(pIndex := self numLiterals - 1) > 0
		ifTrue: [self literalAt: pIndex put: anObject]
		ifFalse: [self error: 'insufficient literals']
]

{ #category : 'copying' }
PetitCompiledMethod >> postCopy [
	| penultimateLiteral |
	(penultimateLiteral := self penultimateLiteral) isMethodProperties ifTrue:
		[self penultimateLiteral: (penultimateLiteral copy
									method: self;
									yourself).
		 self penultimateLiteral pragmas do:
			[:p| p method: self]]
]

{ #category : 'accessing - pragmas & properties' }
PetitCompiledMethod >> pragmaAt: aKey [
	"Answer the first pragma with selector aKey, or nil if none."
	<reflection: 'Class structural inspection - Pragma'>
	^ self pragmas detect: [ :pragma | pragma selector == aKey ] ifNone: nil
]

{ #category : 'literals' }
PetitCompiledMethod >> pragmaRefersToLiteral: literal [

	^ self penultimateLiteral isMethodProperties and: [
		  self pragmas anySatisfy: [ :pragma | pragma refersToLiteral: literal ] ]
]

{ #category : 'accessing - pragmas & properties' }
PetitCompiledMethod >> pragmas [
	| selectorOrProperties |
	<reflection: 'Class structural inspection - Pragma'>
	^(selectorOrProperties := self penultimateLiteral) isMethodProperties
		ifTrue: [selectorOrProperties pragmas]
		ifFalse: [#()]
]

{ #category : 'accessing - pragmas & properties' }
PetitCompiledMethod >> pragmasDo: aBlock [
	<reflection: 'Class structural inspection - Pragma'>
	| selectorOrProperties |
	(selectorOrProperties := self penultimateLiteral) isMethodProperties
		ifTrue: [selectorOrProperties pragmasDo: aBlock]
]

{ #category : 'debugger support' }
PetitCompiledMethod >> prepareForSimulationWith: numArgs [
	"This method changes the argument count of a CompiledMethod header to numArgs, its temporary count to numArgs + 1 and change the code handling primitive error to store the error code in the unique temporary of the method"

	| newHeader |
	newHeader := (((self header bitAnd: 2r01110000000000111111111111111111)
			bitOr: (numArgs bitShift: 24))
			bitOr: (numArgs + 1 bitShift: 18)).
	newHeader := newHeader + (self class headerFlagForEncoder: self encoderClass).
	self objectAt: 1 put: newHeader.

	self encoderClass prepareMethod: self forSimulationWith: numArgs
]

{ #category : 'printing' }
PetitCompiledMethod >> printOn: aStream [
	"Overrides method inherited from the byte arrayed collection."

	aStream print: self methodClass; nextPutAll: '>>'; print: self selector
]

{ #category : 'printing' }
PetitCompiledMethod >> printPrimitiveOn: aStream [
	"Print the primitive on aStream"
	| primDecl |
	self isPrimitive ifFalse: [ ^self ].

	self isExternalCallPrimitive ifTrue:
		[^aStream print: (self literalAt: 1); cr].
	aStream nextPutAll: '<primitive: '.
	self isNamedPrimitive
		ifTrue:
			[primDecl := self literalAt: 1.
			 (primDecl at: 2) asString printOn: aStream.
			 (primDecl at: 1) ifNotNil:
				[:moduleName|
				aStream nextPutAll:' module: '.
				moduleName asString printOn: aStream]]
		ifFalse:
			[aStream print: self primitive].
	self primitiveErrorVariableName ifNotNil:
		[:primitiveErrorVariableName|
		 aStream nextPutAll: ' error: '; nextPutAll: primitiveErrorVariableName].
	aStream nextPut: $>; cr
]

{ #category : 'accessing' }
PetitCompiledMethod >> properties [
	"Answer the method properties of the receiver."
	| propertiesOrSelector |
	^(propertiesOrSelector := self penultimateLiteral) isMethodProperties
		ifTrue: [propertiesOrSelector]
		ifFalse: [self class methodPropertiesClass forMethod: self selector: propertiesOrSelector]
]

{ #category : 'accessing' }
PetitCompiledMethod >> properties: aMethodProperties [
	"Set the method-properties of the receiver to aMethodProperties."

	self
		literalAt: self numLiterals - 1
		put:
			(aMethodProperties
				ifEmpty: [ aMethodProperties selector ]
				ifNotEmpty: [
			 		aMethodProperties
				 		setMethod: self;
				 		yourself ])
]

{ #category : 'accessing - pragmas & properties' }
PetitCompiledMethod >> propertyAt: propName [
	| propertiesOrSelector |
	^(propertiesOrSelector := self penultimateLiteral) isMethodProperties
		ifTrue: [propertiesOrSelector propertyAt: propName ifAbsent: [nil]]
		ifFalse: [nil]
]

{ #category : 'accessing - pragmas & properties' }
PetitCompiledMethod >> propertyAt: propName ifAbsent: aBlock [
	| propertiesOrSelector |
	^(propertiesOrSelector := self penultimateLiteral) isMethodProperties
		ifTrue: [propertiesOrSelector propertyAt: propName ifAbsent: aBlock]
		ifFalse: [aBlock value]
]

{ #category : 'accessing - pragmas & properties' }
PetitCompiledMethod >> propertyAt: aKey ifAbsentPut: aBlock [
	"Answer the property associated with aKey or, if aKey isn't found store the result of evaluating aBlock as new value."

	^ self propertyAt: aKey ifAbsent: [ self propertyAt: aKey put: aBlock value ]
]

{ #category : 'accessing - pragmas & properties' }
PetitCompiledMethod >> propertyAt: propName ifPresent: aBlock [
	| propertiesOrSelector |
	^(propertiesOrSelector := self penultimateLiteral) isMethodProperties
		ifTrue: [propertiesOrSelector propertyAt: propName ifPresent: aBlock]
		ifFalse: [nil]
]

{ #category : 'accessing - pragmas & properties' }
PetitCompiledMethod >> propertyAt: propName put: propValue [
	"Set or add the property with key propName and value propValue.
	 If the receiver does not yet have a method properties create one and replace
	 the selector with it.  Otherwise, either relace propValue in the method properties
	 or replace method properties with one containing the new property."
	| propertiesOrSelector |
	(propertiesOrSelector := self penultimateLiteral) isMethodProperties ifFalse:
		[self penultimateLiteral: ((self class methodPropertiesClass
									selector: propertiesOrSelector
									with: (Association
											key: propName asSymbol
											value: propValue))
									setMethod: self;
									yourself).
		^propValue].
	(propertiesOrSelector includesProperty: propName) ifTrue:
		[^propertiesOrSelector at: propName put: propValue].
	self penultimateLiteral: (propertiesOrSelector
								copyWith: (Association
												key: propName asSymbol
												value: propValue)).
	^propValue
]

{ #category : 'accessing - pragmas & properties' }
PetitCompiledMethod >> propertyKeysAndValuesDo: aBlock [
	"Enumerate the receiver with all the keys and values."

	| propertiesOrSelector |
	(propertiesOrSelector := self penultimateLiteral) isMethodProperties ifTrue:
		[propertiesOrSelector propertyKeysAndValuesDo: aBlock]
]

{ #category : 'protocols' }
PetitCompiledMethod >> protocol [
	"Return in which protocol (conceptual groups of methods) the receiver is grouped into.
	
	With the current implementation the method will have to lookup the protocol in its class, but the #protocol property will be added when we remove a method to still be able to answer the protocol the method was into."

	^ self propertyAt: #protocol ifAbsent: [ self methodClass protocolOfSelector: self selector ]
]

{ #category : 'protocols' }
PetitCompiledMethod >> protocol: aProtocol [
	^ self methodClass classify: self selector under: aProtocol
]

{ #category : 'protocols' }
PetitCompiledMethod >> protocolName [
	"Return the name of the protocol (conceptual groups of methods) in which the receiver is grouped into."

	^ self protocol ifNotNil: [ :protocol | protocol name ]
]

{ #category : 'scanning' }
PetitCompiledMethod >> readsField: varIndex [
	"Answer whether the receiver loads the instance variable indexed by the argument."
	self isReturnField ifTrue: [^self returnField = (varIndex - 1)].
	^ super readsField: varIndex
]

{ #category : 'evaluating' }
PetitCompiledMethod >> receiver: aReceiver withArguments: anArray executeMethod: aMethod [
	"execute aMethod.
	This method takes aMethod as an argument so we can call primitive 188.
	Clients should use #valueWithReceiver:arguments:
	
	We have this method here in addition to ProtoObject>>#withArgs:executeMethod:
	so we can execute a method without sending a message to aReceiver"
		<reflection: 'Message sending and code execution - Arbitrary method/primitive execution'>
	<primitive: 188>
	self primitiveFailed
]

{ #category : 'literals' }
PetitCompiledMethod >> refersToLiteral: aLiteral [
	"Answer true if any literal in this method is literal, even if embedded in array structure."

	^(self pragmaRefersToLiteral: aLiteral) or: [ super refersToLiteral: aLiteral]
]

{ #category : 'private' }
PetitCompiledMethod >> removeFromPackage [

	self isFromTrait ifFalse: [ self package ifNotNil: [ :package | package removeMethod: self ] ]
]

{ #category : 'initialization' }
PetitCompiledMethod >> removeFromSystem [
	^ self methodClass removeSelector: self selector
]

{ #category : 'accessing - pragmas & properties' }
PetitCompiledMethod >> removeProperty: propName [
	"Remove the property propName if it exists.
	 Do _not_ raise an error if the property is missing."
	| value |
	value := self propertyAt: propName ifAbsent: [^nil].
	self penultimateLiteral: (self penultimateLiteral copyWithout:
									(Association
										key: propName
										value: value)).

	"Remove unneded AdditionalMethodState"
	self penultimateLiteral size = 0 ifTrue: [ self penultimateLiteral: self selector ].
	^value
]

{ #category : 'accessing - pragmas & properties' }
PetitCompiledMethod >> removeProperty: propName ifAbsent: aBlock [
	"Remove the property propName if it exists.
	 Answer the evaluation of aBlock if the property is missing."
	| value |
	value := self propertyAt: propName ifAbsent: [^aBlock value].
	self penultimateLiteral: (self penultimateLiteral copyWithout:
									(Association
										key: propName
										value: value)).
	^value
]

{ #category : 'accessing' }
PetitCompiledMethod >> returnField [
	"Answer the index of the instance variable returned by a quick return
	method."
	| prim |
	prim := self primitive.
	prim < 264
		ifTrue: [self error: 'only meaningful for quick-return']
		ifFalse: [^ prim - 264]
]

{ #category : 'accessing' }
PetitCompiledMethod >> selector [
	"Answer a method's selector.  This is either the penultimate literal,
	 or, if the method has any properties or pragmas, the selector of
	 the MethodProperties stored in the penultimate literal."
	<reflection: 'Class structural inspection - Selectors and methods inspection'>
	| penultimateLiteral |
	^(penultimateLiteral := self penultimateLiteral) isMethodProperties
		ifTrue: [penultimateLiteral selector]
		ifFalse: [penultimateLiteral]
]

{ #category : 'accessing' }
PetitCompiledMethod >> selector: aSelector [
	"Set a method's selector.  This is either the penultimate literal,
	 or, if the method has any properties or pragmas, the selector of
	 the MethodProperties stored in the penultimate literal."
	<reflection: 'Class structural inspection - Selectors and methods inspection'>
	| penultimateLiteral nl |
	(penultimateLiteral := self penultimateLiteral) isMethodProperties
		ifTrue: [penultimateLiteral selector: aSelector]
		ifFalse: [(nl := self numLiterals) < 2 ifTrue:
					[self error: 'insufficient literals to hold selector'].
				self literalAt: nl - 1 put: aSelector]
]

{ #category : 'source code management' }
PetitCompiledMethod >> setSourcePointer: srcPointer [

	| trailerBytes trailerSize start |
	trailerSize := self class trailerSize.
	trailerBytes := srcPointer asByteArrayOfSize: trailerSize.
	start := self size - trailerSize.
	start + 1 to: self size do: [:n | self at: n put: (trailerBytes at: n - start) ]
]

{ #category : 'accessing' }
PetitCompiledMethod >> sourceCodeOrNil [
	"Retrieve the source code for this method, or return nil."

	self propertyAt: #source ifPresent:  [ :code | ^ code ].
	self hasSourcePointer ifFalse: [ ^ nil ].
	^ self getSourceFromFile
]

{ #category : 'source code management' }
PetitCompiledMethod >> sourcePointer [
	"Answer the integer which can be used to find the source file and position for this method.
	The actual interpretation of this number is up to the SourceFileArray stored in the global variable SourceFiles."
	| trailerBytes trailerSize start |
	trailerSize := self class trailerSize.
	trailerBytes := ByteArray new: trailerSize.
	start := self size - trailerSize.
	start + 1 to: self size do: [:n | trailerBytes at: n - start put: (self at: n) ].
	^ trailerBytes asInteger
]

{ #category : 'source code management' }
PetitCompiledMethod >> sourcePointer: srcPointer [

	"Drop the #source property if any"
	self removeProperty: #source.
	self setSourcePointer: srcPointer
]

{ #category : 'debugger support' }
PetitCompiledMethod >> stepIntoQuickMethods: aBoolean [
	^self propertyAt: #stepIntoQuickMethod put: aBoolean
]

{ #category : 'storing' }
PetitCompiledMethod >> storeOn: aStream [
	| noneYet |
	aStream nextPutAll: '(('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' newMethod: '.
	aStream store: self size - self initialPC + 1.
	aStream nextPutAll: ' header: '.
	aStream store: self header.
	aStream nextPut: $).
	noneYet := self storeElementsFrom: self initialPC to: self endPC on: aStream.
	1 to: self numLiterals do:
		[:index |
		noneYet
			ifTrue: [noneYet := false]
			ifFalse: [aStream nextPut: $;].
		aStream nextPutAll: ' literalAt: '.
		aStream store: index.
		aStream nextPutAll: ' put: '.
		aStream store: (self literalAt: index)].
	noneYet ifFalse: [aStream nextPutAll: '; yourself'].
	aStream nextPut: $)
]

{ #category : 'source code management' }
PetitCompiledMethod >> tempNames [
	"on the level of the compiled method, tempNames includes argument names"
	^self ast argumentNames, self ast temporaryNames
]

{ #category : 'protocols' }
PetitCompiledMethod >> unclassify [

	self protocol: Protocol unclassified
]

{ #category : 'testing' }
PetitCompiledMethod >> usesUndeclareds [
	"this is mixing Undeclareds and Obsoletes, maybe we should have two methods"
	self withAllNestedLiteralsDo: [ :literal |
		literal class == UndeclaredVariable ifTrue: [ ^ true ].
		(literal isBlock not and: [
			 literal value isBehavior and: [ literal value isObsolete ] ])
			ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'evaluating' }
PetitCompiledMethod >> valueWithReceiver: aReceiver [
	<reflection: 'Message sending and code execution - Arbitrary method/primitive execution'>
	^self receiver: aReceiver withArguments: #() executeMethod: self
]

{ #category : 'evaluating' }
PetitCompiledMethod >> valueWithReceiver: aReceiver arguments: anArray [
	<reflection: 'Message sending and code execution - Arbitrary method/primitive execution'>
	^self receiver: aReceiver withArguments: anArray executeMethod: self
]

{ #category : 'copying' }
PetitCompiledMethod >> veryDeepCopyWith: deepCopier [
	"Return self.  I am always shared.  Do not record me.  Only use this for blocks.  Normally methodDictionaries should not be copied this way."
]

{ #category : 'scanning' }
PetitCompiledMethod >> writesField: varIndex [
	"Answer whether the receiver stores into the instance variable indexed by the argument."
	self isQuick ifTrue: [^false].
	^ super writesField: varIndex
]
