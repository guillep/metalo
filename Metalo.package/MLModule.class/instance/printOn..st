printing
printOn: aStream
	aStream
		nextPutAll: 'a Module(';
		nextPutAll: (name isString ifTrue: [ name ] ifFalse: [ '' ]);
		nextPutAll: ')'.

	