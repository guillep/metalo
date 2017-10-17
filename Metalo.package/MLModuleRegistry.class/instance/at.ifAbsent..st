accessing
at: aString ifAbsent: aBlockClosure 
	
	(moduleEnvironment definesName: aString) ifFalse: [ ^ aBlockClosure value].
	^ moduleEnvironment at: aString