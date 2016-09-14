examples
exampleModule

	| math |
	math := MLMetaModuleWithPrivateMethods createModuleNamed: 'Templates'.
	math metaModule createClassNamed: 'Superclass'.
	math metaModule createClassNamed: 'Subclass' superclass: (math classNamed: 'Superclass').

	math metaModule compileMethod: 'template
		^ self private + self public' inClass: (math classNamed: 'Superclass').
	
	math metaModule compileMethod: 'public
		^ 1' inClass: (math classNamed: 'Subclass').
			
	math metaModule compileMethod: 'private
		<private>
		^ 42' inClass: (math classNamed: 'Subclass').
		
	^ math