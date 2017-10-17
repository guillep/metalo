conflicts
checkRedundancyOn: aMLModule ifRedundant: aBlockClosure 
	
	aMLModule imports
		detect: [ :each | each = self ]
		ifFound: aBlockClosure