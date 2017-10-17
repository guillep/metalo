specs
defaultSpec
	^ SpecLayout composed
		newColumn: [ :col | 
			col add: #text ];
		yourself