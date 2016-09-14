configuration
createClassNamed: aString superclass: aSuperclass

	| classCreated |
	classCreated := self class basicCreateClassNamed: aString superclass: aSuperclass.
	module definitions at: aString put: classCreated