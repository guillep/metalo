migration
networkCore
	
	^ MLModuleDefinition
		newNamed: 'Network'
		fromRPackages: ({ 'Network-Kernel' } collect: [ :each | RPackage organizer packageNamed: each ])
		withImports: ({ 'PackageManifest' . 'Object' . 'Error' . 'MLModule' . 'Notification' . 'ByteArray' . 'UIManager' . 'Semaphore' . 'Smalltalk' . 'Time' . 'String' . 'OrderedCollection' . 'Processor' . 'Delay' . 'Character' } collect: [ :each | 
			MLImport name: each from: #Smalltalk ] )