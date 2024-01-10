Class {
	#name : 'MetacelloModuleLoader',
	#superclass : 'MetacelloMonticelloLoader',
	#instVars : [
		'moduleRegistry',
		'engine'
	],
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'accessing' }
MetacelloModuleLoader >> engine: aMetacelloScriptEngine [ 
	engine := aMetacelloScriptEngine
]

{ #category : 'loading' }
MetacelloModuleLoader >> loadAtomicPackageDirectives: packageDirectives [
	"Each package directive can specify many repositorySpecs.
	Find the first one that defines the package (assumming they all are equivalent) and use that."

	| model snapshot module bootstrap environment kernel |
	packageDirectives size > 1 ifTrue: [ self error ].

	model := MCVersionLoader new.

	packageDirectives do: [ :e |
		| repository |
		repository := self repositoriesFrom: e repositorySpecs.
		repository loadPackageNamed: e spec name intoLoader: model ].

	snapshot := (model versions collect: [ :v | v snapshot ]) first.

	kernel := self moduleRegistry moduleNamed: #Kernel.
	bootstrap := self moduleRegistry moduleNamed: #MetacelloBootstrap.
	environment := MLListEnvironment new.
	environment add: kernel.
	environment add: bootstrap.

	(packageDirectives first spec requiredPackageSpecsWithEngine: engine)
		do: [ :e |
		environment add: (self moduleRegistry moduleNamed: e name) ].

	module := MLModule
		          named: packageDirectives first packageName
		          fromDefinition: (MLMonticelloSnapshot on: snapshot)
		          nameResolver: environment.
	self moduleRegistry register: module.

	packageDirectives do: [ :e |
		MetacelloNotification signal:
			'Loaded -> ' , e packageName , ' --- '
			, e repositorySpecs first description ]
]

{ #category : 'accessing' }
MetacelloModuleLoader >> lookupProjectClassNamed: aString [ 
	
	^ moduleRegistry lookupName: aString
]

{ #category : 'accessing' }
MetacelloModuleLoader >> moduleRegistry [
	^ moduleRegistry
]

{ #category : 'accessing' }
MetacelloModuleLoader >> moduleRegistry: aMLModuleRegistry [

	moduleRegistry := aMLModuleRegistry
]
