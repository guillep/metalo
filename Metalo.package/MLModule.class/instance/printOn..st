printing
printOn: aStream
	aStream
		nextPutAll: 'a Module(';
		nextPutAll: (name asString);
		nextPutAll: ')'.

	