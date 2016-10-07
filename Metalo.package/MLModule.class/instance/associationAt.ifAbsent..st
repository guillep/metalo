compiling
associationAt: aString ifAbsent: aBlockClosure 
	
	^ nameBindings
		associationAt: aString
		ifAbsent: aBlockClosure