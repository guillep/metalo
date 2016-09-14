validating
validateModuleName: aString 
	
	aString isEmpty
		ifTrue: [ self error ].
	
	(aString includes: $ )
		ifTrue: [ self error ]