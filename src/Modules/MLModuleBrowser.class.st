Class {
	#name : 'MLModuleBrowser',
	#superclass : 'SpPresenter',
	#instVars : [
		'moduleTree',
		'classList',
		'methodList',
		'codePresenter',
		'moduleEnvironment',
		'moduleActionBar',
		'menuBar'
	],
	#category : 'Modules-UI',
	#package : 'Modules',
	#tag : 'UI'
}

{ #category : 'initialization' }
MLModuleBrowser >> connectPresenters [

	moduleTree whenSelectedItemChangedDo: [ :e |
		e ifNotNil: [ 
			self updateClassList.
			moduleTree contextMenu: self newModuleMenu ] ].
	
	classList whenSelectedItemChangedDo: [ :e |
		e ifNotNil: [ methodList items: (e methods sorted: [ :a :b | a selector < b selector ]) ] ].
	
	methodList whenSelectedItemChangedDo: [ :e |
		e ifNotNil: [ 
			codePresenter beForMethod: e.
			codePresenter text: e sourceCode ] ].
	
	codePresenter whenSubmitDo: [ :text |
		classList selectedItem compile: codePresenter text ].
]

{ #category : 'actions' }
MLModuleBrowser >> createNewModule [
	
	| name kernelVirtualModule environment module |
	name := self application newRequestText
		label: 'Module Name';
		openModal.
	kernelVirtualModule := MLFilterModule
		on: MLSystemModule new
		named: #Kernel.
	kernelVirtualModule filterName: #Object.
	kernelVirtualModule filterName: #FixedLayout.

	environment := MLListEnvironment new.
	environment add: kernelVirtualModule.	

	module := MLModule newNamed: name.
	module nameResolver: environment.

	moduleEnvironment register: module.

	self updatePresenter
]

{ #category : 'initialization' }
MLModuleBrowser >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 5;
		  add: menuBar expand: false;
		  add: (SpBoxLayout newHorizontal
				   spacing: 5;
				   add: (SpBoxLayout newVertical
						    add: moduleActionBar expand: false;
						    add: moduleTree;
						    yourself);
				   add: classList;
				   add: methodList;
				   yourself);
		  add: codePresenter;
		  yourself
]

{ #category : 'initialization' }
MLModuleBrowser >> initializePresenters [

	menuBar := self newMenuBar.
	menuBar addGroup: [ :group |
		group addItem: [ :item |
			item
				name: 'Module';
				subMenu: (self newMenu
						 addItem: [ :subitem |
							 subitem
								 name: 'New Module';
								 icon: (self iconNamed: #smallQuit);
								 action: [ self createNewModule ] ];
						 yourself) ] ].

	moduleActionBar := self newActionBar.
	moduleActionBar add: (self newButton
			 label: 'asd';
			 action: [  ];
			 yourself).
	moduleTree := self newTree.
	moduleTree display: [ :e | e name ].

	classList := self newList.
	classList display: [ :e | e name ].

	methodList := self newList.
	methodList display: [ :e | e selector ].

	codePresenter := self newCode
]

{ #category : 'instance creation' }
MLModuleBrowser >> newClass [
	
	moduleTree selectedItem createNewClass.
	self updateClassList.
]

{ #category : 'initialization' }
MLModuleBrowser >> newModuleMenu [

	^ self newMenu
		  addItem: [ :subitem |
			  subitem
				  name: 'New class';
				  icon: (self iconNamed: #smallQuit);
				  action: [ self newClass ] ];
		  addItem: [ :subitem |
			  subitem
				  name: 'New script';
				  icon: (self iconNamed: #smallQuit);
				  action: [ self newScript ] ];
		  addItem: [ :subitem |
			  subitem
				  name: 'New extension';
				  icon: (self iconNamed: #smallQuit);
				  action: [ self newExtension ] ]
]

{ #category : 'accessing - model' }
MLModuleBrowser >> setModelBeforeInitialization: aModuleEnvironment [

	moduleEnvironment := aModuleEnvironment
]

{ #category : 'initialization' }
MLModuleBrowser >> updateClassList [
	
	classList items: (moduleTree selectedItem classes sorted: [ :a :b | a name < b name ]).
]

{ #category : 'initialization' }
MLModuleBrowser >> updateModuleTree [

	moduleTree roots: (moduleEnvironment modules sorted: [ :a :b | a name < b name ])
]

{ #category : 'initialization' }
MLModuleBrowser >> updatePresenter [

	self updateModuleTree
]
