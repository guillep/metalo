imports
importNamed: aString 
	
	^ self imports detect: [ :import | import importedName = aString ]