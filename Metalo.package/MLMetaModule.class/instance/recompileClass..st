mop
recompileClass: aClass

	aClass methods do: [ :each | 
		self compileMethod: each sourceCode inClass: aClass ]