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

	moduleDictionary values do: [ :e |
		e lookupName: aString ifPresent: [ :found | ^ found ] ].
	^ nil
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
