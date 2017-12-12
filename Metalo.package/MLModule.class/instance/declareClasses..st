class creation
declareClasses: aCollection 
	
	aCollection do: [ :each | 
		self declareClass: each asClassDefinition ]