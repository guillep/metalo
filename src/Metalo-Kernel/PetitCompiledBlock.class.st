"
Specific version of compiled code for blocks.

In addition the execution mechanics, a compiled block has an extra literal: the last literal is the compiled code of the outer method or block (see #outerCode)



"
Class {
	#name : 'PetitCompiledBlock',
	#superclass : 'PetitCompiledCode',
	#type : 'compiledMethod',
	#category : 'Metalo-Kernel',
	#package : 'Metalo-Kernel'
}

{ #category : 'constants' }
PetitCompiledBlock class >> trailerSize [
	^ 0
]

{ #category : 'displaying' }
PetitCompiledBlock >> displayStringOn: stream [
	self printOn: stream
]

{ #category : 'accessing' }
PetitCompiledBlock >> endPC [
	"Answer the index of the last bytecode"
	^ self size
]

{ #category : 'scanning' }
PetitCompiledBlock >> hasMethodReturn [
	"Answer whether the receiver has a method-return ('^') in its code."
	^ (InstructionStream on: self) scanFor: [:byte |
		 self encoderClass methodReturnBytecodes includes: byte]
]

{ #category : 'testing' }
PetitCompiledBlock >> hasPragmaNamed: aSymbol [
	<reflection: 'Class structural inspection - Pragma'>
	^ false
]

{ #category : 'testing' }
PetitCompiledBlock >> hasProperties [
	^false
]

{ #category : 'properties' }
PetitCompiledBlock >> hasProperty: aString [

	^ false
]

{ #category : 'testing' }
PetitCompiledBlock >> hasSourceCode [
	^ self method hasSourceCode
]

{ #category : 'comparing' }
PetitCompiledBlock >> hash [
	"CompiledMethod>>#= compares code, i.e. same literals and same bytecode.
	 So we look at the header, methodClass and some bytes between initialPC and endPC,
	 but /not/ the selector because the equal method does not compare selectors.
	 Note that we must override ByteArray>hash which looks at all bytes of the receiver.
	 Using bytes from the pointer part of a COmpiledmethod can lead to a variable hash
	 if and when when the GC moves literals in the receiver."
	| initialPC endPC hash |
	initialPC := self initialPC.
	endPC := self endPC.
	hash := self species hash + self header + initialPC + endPC.
	"sample approximately 20 bytes"
	initialPC to: endPC by: (endPC - initialPC // 20 max: 1) do:
		[:i| hash := hash + (self at: i)].
	^hash

	"(CompiledMethod>>#hash) hash"
]

{ #category : 'accessing' }
PetitCompiledBlock >> indexInOuter [

	| index |
	index := self outerCode literals indexOf: self.
	index > 0 ifTrue: [ ^ index ].

	^ self outerCode literals detectIndex: [ :lit |
		  lit isBlock and: [ lit compiledBlock == self ] ]
]

{ #category : 'accessing' }
PetitCompiledBlock >> indexesInOuter [

	| index |
	index := self outerCode literals indexOf: self.
	index > 0 ifTrue: [ ^ ByteArray with: index ].

	index := self outerCode literals detectIndex: [ :lit |
		         lit isBlock and: [ lit compiledBlock == self ] ].
	^ ByteArray with: index with: 0
]

{ #category : 'testing' }
PetitCompiledBlock >> isCompiledBlock [
	^ true
]

{ #category : 'testing' }
PetitCompiledBlock >> isEmbeddedBlock [
	^ true
]

{ #category : 'testing' }
PetitCompiledBlock >> isInstalled [

	^ self method isInstalled
]

{ #category : 'testing' }
PetitCompiledBlock >> isTestMethod [
	^ false
]

{ #category : 'comparing' }
PetitCompiledBlock >> literalEqual: other [
	"when there are two blocks with the same code, we want to still have both in the literal array"
	^self == other
]

{ #category : 'literals' }
PetitCompiledBlock >> literalsToSkip [

	^ 1
]

{ #category : 'accessing' }
PetitCompiledBlock >> method [
	"answer the compiled method that I am installed in, or nil if none."
	^self outerCode method
]

{ #category : 'accessing' }
PetitCompiledBlock >> methodClass [
	"answer the compiled method that I am installed in, or nil if none."
	^self outerCode methodClass
]

{ #category : 'accessing' }
PetitCompiledBlock >> methodNode [
	^ self outerCode methodNode
]

{ #category : 'initialization' }
PetitCompiledBlock >> needsFrameSize: newFrameSize [
	"Set the largeFrameBit to accomodate the newFrameSize"

	self numTemps + newFrameSize > LargeFrame ifTrue: [
		^ self error: 'Cannot compile -- stack including temps is too deep' ].
	self setFrameBit: self numTemps + newFrameSize > SmallFrame
]

{ #category : 'accessing' }
PetitCompiledBlock >> outerCode [
	"answer the compiled code that I am installed in, or nil if none."
	^self literalAt: self numLiterals
]

{ #category : 'accessing' }
PetitCompiledBlock >> outerCode: aCompiledCode [
	^self literalAt: self numLiterals put: aCompiledCode
]

{ #category : 'accessing' }
PetitCompiledBlock >> pathOfLiteralIndexes [
	
	^ self outerCode pathOfLiteralIndexes copyWithAll: self indexesInOuter
]

{ #category : 'scanning' }
PetitCompiledBlock >> pcInOuter [
	| outer end instructionStream |
	outer := self outerCode.
	instructionStream := InstructionStream on: outer.
	end := outer endPC.
	[instructionStream pc <= end] whileTrue:
		[ (self encoderClass isCreateFullBlock: self code: outer at: instructionStream pc)
			ifTrue: [ ^ instructionStream pc ].
			instructionStream pc: (instructionStream nextPc: (outer at: instructionStream pc))].
	"scan for clean block"
	instructionStream := InstructionStream on: outer.
	[instructionStream pc <= end] whileTrue: [
			| literalOffset |
			literalOffset := self encoderClass literalIndexOfBytecodeAt: instructionStream pc in: outer.
			literalOffset ifNotNil: [
				| literal |
				literal := (self outerCode literalAt: literalOffset + 1).
				((literal isKindOf: CleanBlockClosure) and: [literal compiledBlock == self  ])ifTrue: [ ^ instructionStream pc ].  ].
			instructionStream pc: (instructionStream nextPc: (outer at: instructionStream pc))].

	self error: 'block not installed in outer code'
]

{ #category : 'accessing' }
PetitCompiledBlock >> pragmas [
	<reflection: 'Class structural inspection - Pragma'>
	^ #()
]

{ #category : 'printing' }
PetitCompiledBlock >> printOn: anStream [

	anStream
		nextPutAll: 'a CompiledBlock: ';
		nextPutAll: self sourceNode sourceCode
]

{ #category : 'compatibility' }
PetitCompiledBlock >> properties [
	^ nil->nil
]

{ #category : 'properties' }
PetitCompiledBlock >> propertyAt: aString [

	^ nil
]

{ #category : 'comparing' }
PetitCompiledBlock >> sameLiteralsAs: method [
	"Compare my literals to those of method. This is needed to compare compiled methods."

	| numLits literal1 literal2 |
	(numLits := self numLiterals) ~= method numLiterals
		ifTrue: [ ^ false ].
	"The last literal requires special checking instead of using #literalEqual:"
	1 to: numLits - 1 do: [ :index |
		literal1 := self literalAt: index.
		literal2 := method literalAt: index.
		(literal1 == literal2 or: [ literal1 literalEqual: literal2 ])
			ifFalse: [ ^ false ] ].
	"we can't do = on outer code or it will recursively call this code"
	^ true
]

{ #category : 'accessing' }
PetitCompiledBlock >> selector [

	<reflection: 'Class structural inspection - Selectors and methods inspection'>
	^ self outerCode selector
]

{ #category : 'accessing' }
PetitCompiledBlock >> sourceCode [
	^ self outerCode sourceCode
]

{ #category : 'source code management' }
PetitCompiledBlock >> sourcePointer [
	^self outerCode sourcePointer
]

{ #category : 'debugger support' }
PetitCompiledBlock >> stepIntoQuickMethods [
	^self method stepIntoQuickMethods
]

{ #category : 'debugger support' }
PetitCompiledBlock >> stepIntoQuickMethods: aBoolean [
	^self method stepIntoQuickMethods: aBoolean
]
