instance creation
newNamed: aModuleName fromRPackages: anRPackageCollection withModuleVariablesNamed: variableNames withImportDeclarations: arrayOfImports
	
	| moduleDefinition imports |
	moduleDefinition := self new.
	moduleDefinition name: aModuleName.
	
	imports := arrayOfImports flatCollect: [ :assoc | 		
			assoc value collect: [  :aName | 
					MLImport name: aName from: assoc key ] 	
				].
	moduleDefinition imports: imports.
	moduleDefinition rPackages: anRPackageCollection.
	moduleDefinition moduleVariableNames: variableNames.
	^ moduleDefinition