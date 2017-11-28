testing
definesName: aName
	
	^ (classBindings includesKey: aName) or: [  
			variableBindings  includesKey: aName ] 
	
