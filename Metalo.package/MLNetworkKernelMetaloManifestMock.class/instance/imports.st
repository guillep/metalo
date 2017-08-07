imports
imports
	^ {(#UIManager -> #(#UIManager)).
	(#'CollectionsNative' -> #(#ByteArray)).
	(#'SystemSessionManager' -> #(#SessionManager)).
	(#Kernel
		->
			#(#Mutex #Error #PrimitiveFailed #Delay #Object #Semaphore #Time #Notification #Character #Processor)).
	(#Metalo -> #(#MLModule)).
	(#'SystemPlatforms' -> #(#OSPlatform #MacOSPlatform)).
	(#'CollectionsStrings' -> #(#String)).
	(#'CollectionsWeak' -> #(#WeakRegistry)).
	(#Transcript -> #(#Transcript)).
	(#'CollectionsSequenceable' -> #(#OrderedCollection #Array)).
	(#'SystemSupport' -> #(#Smalltalk))}