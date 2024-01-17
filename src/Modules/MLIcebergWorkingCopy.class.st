Class {
	#name : 'MLIcebergWorkingCopy',
	#superclass : 'IceWorkingCopy',
	#instVars : [
		'moduleRegistry'
	],
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'API - packages' }
MLIcebergWorkingCopy >> isLoadedPackageNamed: aString [

	^ moduleRegistry hasModuleNamed: aString
]

{ #category : 'accessing' }
MLIcebergWorkingCopy >> moduleRegistry: aMLModuleRegistry [ 
	
	moduleRegistry := aMLModuleRegistry
]

{ #category : 'API - packages' }
MLIcebergWorkingCopy >> snapshotForPackage: aPackage [

	aPackage isLoaded ifFalse: [
		^ self referenceCommit snapshotForPackage: aPackage ].
	
	^ (MCPackage systemPackage: (moduleRegistry moduleNamed: aPackage name)) snapshot
]
