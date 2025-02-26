Class {
	#name : 'MLModuleRegistry',
	#superclass : 'Object',
	#instVars : [
		'moduleDictionary'
	],
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'accessing' }
MLModuleRegistry >> hasModuleNamed: aString [ 
	
	^ moduleDictionary includesKey: aString asSymbol
]

{ #category : 'initialization' }
MLModuleRegistry >> initialize [

	super initialize.
	moduleDictionary := Dictionary new
]

{ #category : 'name-resolution' }
MLModuleRegistry >> lookupName: aString [

	^ self lookupName: aString ifAbsent: [ nil ]
]

{ #category : 'name-resolution' }
MLModuleRegistry >> lookupName: aString ifAbsent: aFullBlockClosure [

	moduleDictionary values do: [ :e |
		e lookupName: aString ifPresent: [ :found | ^ found ] ].
	^ aFullBlockClosure value
]

{ #category : 'name-resolution' }
MLModuleRegistry >> lookupVar: aString [

	^ self lookupVar: aString ifAbsent: [ nil ]
]

{ #category : 'name-resolution' }
MLModuleRegistry >> lookupVar: aString ifAbsent: aFullBlockClosure [

	moduleDictionary values do: [ :e |
		e lookupVar: aString ifPresent: [ :found | ^ found ] ].
	^ aFullBlockClosure value
]

{ #category : 'accessing' }
MLModuleRegistry >> moduleNamed: aString [ 
	
	^ moduleDictionary at: aString asSymbol
]

{ #category : 'accessing' }
MLModuleRegistry >> modules [
	
	^ moduleDictionary values
]

{ #category : 'registry' }
MLModuleRegistry >> register: aModule [

	moduleDictionary
		at: aModule name asSymbol
		ifPresent: [ self error: 'wat' ]
		ifAbsentPut: aModule.
	^ aModule
]
