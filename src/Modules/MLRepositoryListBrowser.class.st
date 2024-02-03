Class {
	#name : 'MLRepositoryListBrowser',
	#superclass : 'SpPresenter',
	#classTraits : '{} + TraitedClass',
	#instVars : [
		'icebergRepositoriesBrowser',
		'moduleManager',
		'toolbar',
		'repositoriesListBrowser'
	],
	#category : 'Modules-UI',
	#package : 'Modules',
	#tag : 'UI'
}

{ #category : 'layout' }
MLRepositoryListBrowser >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: toolbar expand: false;
		  add: repositoriesListBrowser;
		  yourself
]

{ #category : 'layout' }
MLRepositoryListBrowser >> initializePresenter [

	toolbar := self newToolbar.
	toolbar add: (self newToolbarButton
			 label: 'Add Repository';
			 icon: (self iconNamed: #add);
			 action: [
				 (IceTipRegisterRepositoryDialogPresenter newApplication:
						  self application) asDialogWindow
					 centeredRelativeTo: self window;
					 open ];
			 yourself).

	repositoriesListBrowser := IceTipRepositoriesBrowser
		                           newOnRepositoryProvider: moduleManager
]

{ #category : 'accessing - model' }
MLRepositoryListBrowser >> setModelBeforeInitialization: aModuleManager [

	moduleManager := aModuleManager
]
