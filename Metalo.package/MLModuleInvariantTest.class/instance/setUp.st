as yet unclassified
setUp

	super setUp.
	module := MLMetaModule
		newNamed: 'Network'
		fromRPackage: (RPackage organizer packageNamed: 'Network-Kernel')
		withImports: ({ 'PackageManifest' . 'Object' . 'Error' . 'MLModule' . 'Notification' . 'ByteArray' . 'UIManager' . 'Semaphore' . 'Smalltalk' . 'Time' . 'String' . 'OrderedCollection' . 'Processor' . 'Delay' . 'Character' } collect: [ :each | 
			MLImport name: each from: Smalltalk globals ] ).