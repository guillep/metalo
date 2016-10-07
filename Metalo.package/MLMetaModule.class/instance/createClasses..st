class creation
createClasses: aCollection 
	
	aCollection do: [ :each | self createClassRecursively: each classes: aCollection ]