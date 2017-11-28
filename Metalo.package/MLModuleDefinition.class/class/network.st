module examples
network
	
	^ MLModuleDefinition
		newNamed: 'Network'
		fromRPackages: ({ 
			'Network-Kernel' .
			'Network-MIME' .
			'Network-Mail' .
			'Network-Protocols' .
			'Network-UUID' .
			'Network-Url'
			 	} collect: [ :each | RPackage organizer packageNamed: each ])
		withImports: ({ 'PackageManifest' . 'Object' . 'Error' . 'MLModule' . 'Notification' . 'ByteArray' . 'UIManager' . 'Semaphore' . 'Smalltalk' . 'Time' . 'String' . 'OrderedCollection' . 'Processor' . 'Delay' . 'Character' . 'Stream' . 'TextAttribute' . 'Model' . 'LimitingLineStreamWrapper' . 'FileStream' . 'RWBinaryOrTextStream' . 'Array' . 'Integer' . 'Date' . 'Dictionary'. 'Transcript' . 'Form' . 'World' . 'Text' . 'Color' . 'RubScrolledTextModel' . 'SystemWindow' . 'AlignmentMorph' . 'PluggableButtonMorph' . 'FileDoesNotExistException' . 'Exception' . 'SmallInteger' . 'Random' . 'SystemVersion' . 'SessionManager' . 'MD5' . 'Latin1TextConverter' . 'FileException' . 'WeakRegistry' . 'Mutex' . 'PrimitiveFailed' . 'ZnMimeType' . 'ReadWriteStream' . 'DateAndTime' . 'CharacterSet' } collect: [ :each | 
			MLImport name: each from: #Smalltalk ] )