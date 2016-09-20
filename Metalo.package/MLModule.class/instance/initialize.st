accessing
initialize

	super initialize.	
	nameBindings := Dictionary new.
	nameBindings at: self class name put: self class.
	nameBindings at: #thisModule put: self.
	
	importedNameBindings := Dictionary new.