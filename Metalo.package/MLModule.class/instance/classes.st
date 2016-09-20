accessing
classes
	
	^ nameBindings values
		select: [ :definition | definition isClass ]