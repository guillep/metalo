examples
exampleModule

	| math |
	math := MLMetaModule createModuleNamed: 'Math'.
	math metaModule createClassNamed: 'Number'.
	math metaModule createClassNamed: 'Zero' superclass: (math classNamed: 'Number').
	math metaModule createClassNamed: 'Successor' superclass: (math classNamed: 'Number').
	
	math metaModule
		addInstanceVariable: 'previous'
		to: (math classNamed: 'Successor').

	math metaModule compileMethod: 'previous: aNumber
		previous := aNumber' inClass: (math classNamed: 'Successor').
		
	math metaModule compileMethod: 'printOn: aStream
		aStream nextPutAll: ''succ(''.
		previous printOn: aStream.
		aStream nextPutAll: '')''' inClass: (math classNamed: 'Successor').
		
	math metaModule compileMethod: 'printOn: aStream
		aStream nextPutAll: ''zero''' inClass: (math classNamed: 'Zero').
	
	math metaModule compileMethod: 'next
		| next |
		next := Successor new.
		next previous: self.
		^ next'  inClass: (math classNamed: 'Number').
	
	^ math