accessing
classes
	
	^ classBindings values
		select: [ :definition | definition isClass ]