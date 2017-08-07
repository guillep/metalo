tests
testCreateSuperclassAfterSubclassFixesSubclassSuperclass

	| module |
	module := MLModule newNamed: 'myModule'.
	module createClassNamed: #Point subclassOf: #Object.
	module createClassNamed: #Object.
	
	self assert: (module at: #Point) superclass equals: (module at: #Object)