imports
hasImportNamed: aString 
	
	^ self imports anySatisfy: [ :import | import importedName = aString ]