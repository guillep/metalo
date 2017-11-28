module examples
networkTests
	
	^ MLModuleDefinition
		newNamed: 'NetworkTests'
		fromRPackages: ({ 	'Network-Tests' } collect: [ :each | RPackage organizer packageNamed: each ])
		withImports: (
		({ 'Socket' . 'NetworkError' . 'NoBroadcastAllowed' . 'NetNameResolver' . 'MailMessage' . 'SMTPClient' . 'MailAddressParser' . 'QuotedPrintableMimeConverter' . 'NeoUUIDGenerator' . 'UUID' . 'Base64MimeConverter' . 'ConnectionClosed' . 'ConnectionTimedOut' . 'SocketStream' }
		collect: [ :each | MLImport name: each from: #Network ]),
		
		(#('String' 'Processor' 'Delay' 'TestCase' 'ClassTestCase' 'ByteArray' 'Character' 'Stream' 'Set') collect: [ :each | 
			MLImport name: each from: #Smalltalk ]) )