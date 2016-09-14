mop
compileMethod: sourceCode inClass: aClass 
	
	| method |
	method := self compileMethod: sourceCode forClass: aClass.
	self installMethod: method inClass: aClass.
	^ method