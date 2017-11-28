mocks
networkMIME
	
	^ networkMIME ifNil: [ networkMIME := self class networkMIME ]