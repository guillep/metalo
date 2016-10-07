instance-creation
default
	
	^ self new
		at: #Smalltalk put: Smalltalk globals;
		yourself