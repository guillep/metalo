testing
hasImport: anImportedName from: aContainerModuleName
	
	^ imports anySatisfy: [ :import |
		import importedName = anImportedName
			and: [ import moduleName = aContainerModuleName ] ]