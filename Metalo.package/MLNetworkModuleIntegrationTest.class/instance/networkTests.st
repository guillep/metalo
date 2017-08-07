mocks
networkTests
	
	^ networkTests ifNil: [ networkTests := self class networkTests ]