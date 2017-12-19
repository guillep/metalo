accessing
classNamed: aString ifAbsent: aBlockClosure 
	
	^ environment at: aString ifAbsent: aBlockClosure