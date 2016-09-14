accessing
initialize

	super initialize.
	definitions := Dictionary new.
	definitions at: self class name put: self class.
	definitions at: #thisModule put: self.