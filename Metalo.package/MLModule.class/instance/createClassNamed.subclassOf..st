class creation
createClassNamed: aClassName subclassOf: aSuperclassName
	
	| classCreated |
	classCreated := self
		basicCreateClassNamed: aClassName
		subclassOf: aSuperclassName.

	self at: aClassName put: classCreated.
	^ classCreated