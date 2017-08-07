class creation
createClasses: aCollection 
	
	aCollection do: [ :each | 
		self createClass: each ]