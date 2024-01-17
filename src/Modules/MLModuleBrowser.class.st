Class {
	#name : 'MLModuleBrowser',
	#superclass : 'SpPresenter',
	#instVars : [
		'moduleTree',
		'classList',
		'methodList',
		'codePresenter',
		'moduleEnvironment'
	],
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'initialization' }
MLModuleBrowser >> connectPresenters [

	moduleTree whenSelectedItemChangedDo: [ :e |
		e ifNotNil: [ classList items: (e classes sorted: [ :a :b | a name < b name ]) ] ].
	
	classList whenSelectedItemChangedDo: [ :e |
		e ifNotNil: [ methodList items: (e methods sorted: [ :a :b | a selector < b selector ]) ] ].
	
	methodList whenSelectedItemChangedDo: [ :e |
		e ifNotNil: [ 
			codePresenter beForMethod: e.
			codePresenter text: e sourceCode ] ].
	
	codePresenter whenSubmitDo: [ :text |
		classList selectedItem compile: codePresenter text ].
]

{ #category : 'initialization' }
MLModuleBrowser >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: moduleTree;
				   add: classList;
				   add: methodList;
				   yourself);
		  add: codePresenter;
		  yourself
]

{ #category : 'initialization' }
MLModuleBrowser >> initializePresenters [

	moduleTree := self newTree.
	moduleTree display: [ :e | e name ].
	
	classList := self newList.
	classList display: [ :e | e name ].
	
	methodList := self newList.
	methodList display: [ :e | e selector ].
	
	codePresenter := self newCode
]

{ #category : 'accessing - model' }
MLModuleBrowser >> setModelBeforeInitialization: aModuleEnvironment [

	moduleEnvironment := aModuleEnvironment
]

{ #category : 'initialization' }
MLModuleBrowser >> updatePresenter [

	moduleTree roots: (moduleEnvironment modules sorted: [ :a :b | a name < b name ])
]
