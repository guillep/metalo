mocks
networkCore
	
	^ networkCore ifNil: [ networkCore := self class networkCore ]