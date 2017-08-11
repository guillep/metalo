class creation
basicCreateClassNamed: aString subclassOfClassNamed: aSuperclassNameOrNil
	
	| superclass |
	superclass := aSuperclassNameOrNil ifNotNil: [ | binding |
		binding := self bindingOf: aSuperclassNameOrNil.
		binding value ifNil: [ 
			binding value: (self basicCreateClassNamed: aSuperclassNameOrNil subclassOfClassNamed: nil).
		].
		binding value
	].

	^ self basicCreateClassNamed: aString subclassOfClass: superclass