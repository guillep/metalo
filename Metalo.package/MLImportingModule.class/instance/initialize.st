as yet unclassified
initialize
	super initialize.
	
	imports := Set new.
	environment := Dictionary new.
	environment at: 'thisModule' put: self.