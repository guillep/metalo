initialization
initializeModule

	self classes do: [ :each | 
		(each classSide includesSelector: #initialize)
			ifTrue: [ each initialize ] ].