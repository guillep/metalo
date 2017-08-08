configuration
declareClassNamed: aString 
	
	| classCreated |
	classCreated := self class basicCreateClassNamed: aString.
	module definitions at: aString put: classCreated