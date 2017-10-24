accessing
classAt: aString ifAbsent: aBlockClosure 
	
	(environment definesName: aString) ifFalse: [ ^ aBlockClosure value ].
	^ environment classNamed: aString