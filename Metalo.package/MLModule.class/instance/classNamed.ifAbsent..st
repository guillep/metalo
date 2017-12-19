class-access
classNamed: aString ifAbsent: aBlockClosure 
	
	^ classBindings at: aString ifAbsent: aBlockClosure