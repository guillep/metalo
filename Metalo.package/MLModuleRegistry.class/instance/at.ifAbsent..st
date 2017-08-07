accessing
at: aString ifAbsent: aBlockClosure 
	
	^ moduleEnvironment at: aString ifAbsent: aBlockClosure