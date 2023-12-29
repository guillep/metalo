Class {
	#name : 'MLModuleRegistry',
	#superclass : 'Object',
	#instVars : [
		'moduleDictionary'
	],
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'initialization' }
MLModuleRegistry >> initialize [

	super initialize.
	moduleDictionary := Dictionary new
]

{ #category : 'name-resolution' }
MLModuleRegistry >> lookupName: aString [

	moduleDictionary values do: [ :e |
		e lookupName: aString ifPresent: [ :found | ^ found ] ].
	^ nil
]

{ #category : 'accessing' }
MLModuleRegistry >> moduleNamed: aString [ 
	
	^ moduleDictionary at: aString asSymbol
]

{ #category : 'registry' }
MLModuleRegistry >> register: aModule [

	moduleDictionary
		at: aModule name asSymbol
		ifPresent: [ self error: 'wat' ]
		ifAbsentPut: aModule.
	^ aModule
]
