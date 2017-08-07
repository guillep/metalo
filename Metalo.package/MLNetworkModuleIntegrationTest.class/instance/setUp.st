running
setUp

	super setUp.
	registry := MLModuleRegistry default.
	#(#'CollectionsWeak' #'Transcript'  #'SystemSessionManager' #'CollectionsStreams' #'SystemSupport' #Kernel #'CollectionsNative' #UIManager #'CollectionsSequenceable' #Metalo #'CollectionsStrings' #'SystemPlatforms' 'ZincResourceMetaCore' 'Files' 'CollectionsUnordered' 'NetworkMail' 'NetworkProtocols' 'SUnitCore' 'NetworkUUID' ) do: [ :symbol |
		registry at: symbol put: (MLModule withEnvironment: Smalltalk globals) ].

	networkModule := self networkCore
		bindTo: registry;
		yourself